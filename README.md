<div align="center">

# asdf-thrift [![Build](https://github.com/alisaifee/asdf-thrift/actions/workflows/main.yml/badge.svg)](https://github.com/alisaifee/asdf-thrift/actions/workflows/main.yml)


[thrift](https://github.com/apache/thrift) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Supported environments & versions](#supported-versions)
- [Install](#install)
- [License](#license)

# Dependencies

- `automake`, `bison` (>=2.5)

## macOS
The default version of `bison` on macOS is too low to compile thrift against.
Please install using [homebrew](https://brew.sh/):
```sh
brew install bison
```

## Version specific dependencies

Thrift version `0.12.0` explicitely requires boost to build.

### macOS
```
brew install boost
```

### Debian
```
apt install libboost-all-dev
```


# Supported versions
The plugin is tested against recent version of macOS & Ubuntu
(refer to [CI Matrix](https://github.com/alisaifee/asdf-thrift/actions/workflows/main.yml))
and builds a few known version + the latest release tag.


# Install

Plugin:

```shell
asdf plugin add thrift
# or
asdf plugin add thrift https://github.com/alisaifee/asdf-thrift.git
```

thrift:

```shell
# Show all installable versions
asdf list-all thrift

# Install specific version
asdf install thrift latest

# Set a version globally (on your ~/.tool-versions file)
asdf global thrift latest

# Now thrift commands are available
thrift --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.


# License

See [LICENSE](LICENSE) © [Ali-Akber Saifee](https://github.com/alisaifee/)
