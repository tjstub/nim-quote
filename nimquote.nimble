version       = "1.0.0"
author        = "Tyler Stubenvoll"
description   = "A random quote-of-the-day tool, in Nim"
license       = "GPL-3.0"
srcDir        = "src"
bin           = @["nimquote"]
backend       = "cpp"

# Dependencies
requires "nim >= 1.0.0"
requires "docopt >= 0.6"
