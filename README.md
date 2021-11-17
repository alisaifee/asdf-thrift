<div align="center">

# asdf-thrift [![Build](https://github.com/alisaifee/asdf-thrift/actions/workflows/build.yml/badge.svg)](https://github.com/alisaifee/asdf-thrift/actions/workflows/build.yml) [![Lint](https://github.com/alisaifee/asdf-thrift/actions/workflows/lint.yml/badge.svg)](https://github.com/alisaifee/asdf-thrift/actions/workflows/lint.yml)


[thrift](https://github.com/alisaifee/thrift) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [License](#license)

# Dependencies

- `automake`, `bison` (>=2.5)

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
