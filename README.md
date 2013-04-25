Radix62
=======

Convert integers to base 62 strings and back.

Base 62 includes the numbers 0-9 and characters A-Z (both lower and upper case). This can be useful for applications such as URL shorteners.

## Installation

Just like any other gem:

    gem install radix62

## Usage

Two methods are provided, Radix62#encode62 and Radix62#decode62

    require "radix62"
    Radix62.encode62(1000)                          #=> "g8"
    Radix62.encode62(9999999)                       #=> "FXsj"
    Radix62.decode62("a")                           #=> "10"
    Radix62.decode62("A")                           #=> "36"
    Radix62.decode62("Abc123")                      #=> "33146185555"
    Radix62.decode62(Radix62.encode62(1234567890))  #=> 1234567890

Radix62 also adds the `decode62` and `encode62` convenience methods to the String and Integer classes, respectively.

    1000.encode62                                   #=> "g8"
    "Abc123".decode62                               #=> "33146185555"

## Tests and compatibility

The tests pass on 1.8.7, 1.9.3, Rubinius 1.0.1, and JRuby 1.5.2/1.6.0.

## License

Licensed under the MIT license, see the LICENSE file for details.
