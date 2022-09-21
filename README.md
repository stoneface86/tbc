# tbc

Trackerboy compiler. Command line front end for [libtrackerboy][libtrackerboy-url].

The Trackerboy compiler is a command line utility for converting a Trackerboy
module (*.tbm) to various formats. While the main purpose of this utility is
to compile module files to bytecode that is playable on the Game Boy itself,
it also contains other export functions such as wav, gbs, and other driver
formats.

## Building

You will need libtrackerboy in your source path. Clone the repository and add
this to `devconfig.nims` (developer-specific configuration, file is not tracked
by git):
```nim
switch("path", "path/to/libtrackerboy-repo")
```

Or install locally via nimble:
```sh
nimble install https://github.com/stoneface86/libtrackerboy.git
```

Note that this is temporary, once libtrackerboy is added to the nimble package
repository, it will be specified as a dependency in the .nimble file

To build the `tbc` executable run:
```sh
nimble build
```

This will compile an executable in the `bin/` directory

## Usage

The application uses git style subcommand syntax, with each subcommand being
an export format. Example:

```sh
tbc <command> [options]
```

For help on which commands are available use the `-h` or `--help` switch:
```sh
tbc -h              # general help
tbc <command> -h    # command specific help
```

For more documentation see the [manual](#) (In progress, not yet available).

## See Also

 - [Trackerboy](https://github.com/stoneface86/trackerboy) - Game Boy music tracker
 - [libtrackerboy][libtrackerboy-url] - Trackerboy back end library

## Versioning

This project uses Semantic Versioning v2.0.0

## Authors

 - stoneface ([@stoneface86](https://github.com/stoneface86)) - Owner

## License

This project is licensed under the MIT License - See [LICENSE](LICENSE) for more details

[libtrackerboy-url]: https://github.com/stoneface86/libtrackerboy
