# tbc

Trackerboy compiler. Command line front end for [libtrackerboy][libtrackerboy-url].

The Trackerboy compiler is a command line utility for converting a Trackerboy
module (*.tbm) to various formats. While the main purpose of this utility is
to compile module files to bytecode that is playable on the Game Boy itself,
it also contains other export functions such as wav, gbs, and other driver
formats.

## Building

To build the `tbc` executable run:
```sh
nimble build
```

This will compile an executable in the `bin/` directory

Or you can use `nimble run` to build and run the application:
```sh
nimble run -- tbcArgs...
```

Replace tbcArgs with the arguments to pass to tbc, see below for details.

## Usage

The application takes two arguments, the path to the `<input>` module and the
`<format>` to convert the module to. Optional arguments can be specified in
any order.

```sh
tbc <input> <format> [options]
```

To see which formats are available, use the `-h`, `--help` or `--formats`
switches:
```sh
tbc -h              # general help
tbc --formats       # only shows all available formats
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
