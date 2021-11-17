#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/apache/thrift"
TOOL_NAME="thrift"
TOOL_TEST="thrift --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	releases_path=https://api.github.com/repos/apache/thrift/releases
	cmd="curl -s"
	cmd="$cmd $releases_path"
	versions=$(eval "$cmd" | grep -oE "tag_name\": *\"v.{1,7}\"," | sed 's/tag_name\": *\"v//;s/\",//')
	echo "$versions"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="$3"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	local bin_install_path="$install_path/bin"
	mkdir -p "${bin_install_path}"

	if [ "$(uname)" == "Darwin" ]; then
		local bison_brew_path
		bison_brew_path="$(brew --prefix bison)/bin"
		export PATH="$bison_brew_path:$PATH"
		local bison_version
		if ! type "automake" >/dev/null 2>&1; then
			fail "Thrift requires automake"
		fi
		if type "bison" >/dev/null 2>&1; then
			bison_version=$(bison --version | head -n 1 | awk '{print $NF}')
		fi
		if [[ -z "${bison_version}" || ("${bison_version}" < "2.5.0") ]]; then
			fail "Thrift requires bison >= 2.5 to compile"
		fi
	fi

	(
		local download_url
		download_url=$(get_download_url $version)
		curl -sSL "$download_url" -o "${install_path}/thrift.tar.gz"
		mkdir -p "${install_path}/src"
		tar xzf "${install_path}/thrift.tar.gz" -C "${install_path}/src" --strip-components=1
		cd "${install_path}/src"
		./bootstrap.sh >/dev/null 2>&1
		./configure \
			--bindir="${install_path}/bin" \
			--disable-option-checking \
			--disable-dependency-tracking \
			--disable-{tests,debug,libs,shared,static} \
			--without-{cpp,cl,d,dart,erlang,go,haskell,haxe,java,perl,php,php_extension,netstd,nodejs,nodets,python,py3,ruby,rs,swift} \
			>/dev/null 2>&1
		make install >/dev/null
	) || (
		rm -rf "${install_path}"
		fail "An error ocurred while installing $TOOL_NAME $version."
	)
}

get_download_url() {
	local version="$1"
	echo "https://github.com/apache/thrift/archive/refs/tags/v${version}.tar.gz"
}
