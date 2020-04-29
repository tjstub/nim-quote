# nim-quote

nimquote - a random quote or Quote of the Day generator for the CLI.

## Installation

With nim installed, run:

```sh
nimble install
```

## Configuration

The random quote feature requires the `FAVQS_API_KEY` environment variable to 
be exported. In your `~/profile` or elsewhere, add:

```sh
export FAVQS_API_KEY="YOUR_KEY"
```

visit www.favqs.com/api to generate a key. Luckily, the qotd feature
and works without a key.

## Usage

Nim quote is built on top of favqs.com's API, and has two usage modes:

* Quote of the Day (qotd)
* Random (random)

### Examples

Getting the quote of the day:

```sh
nimquote qotd
>>> You need to learn the fine art of detachment, Lieutenant.
--Royce
```

Getting a random quote:

```sh
nimquote random
>>> The blame is his who chooses: God is blameless.
--Plato
```

## Community

This tool is made for my own usage and as a means of practicing Nim. Contributions and critiques are welcome.