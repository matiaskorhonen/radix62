Radix62
=======

Convert integers to base 62 strings and back.

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

## License and copyright

Copyright (c) 2010 Matias Korhonen

Licensed under the MIT license, see the LICENSE file for details.
