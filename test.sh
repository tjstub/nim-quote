#!/usr/bin/env bash
# This is a terrible example of a test suite - but then, nimquote is a
# pretty dead simple tool so I didn't wish to over-do it. Please
# overlook my lapse, as I wouldn't ship important code like this
# :)

if ! command -v nimquote; then
    echo "Install nimquote tool!"
    echo "e.g., nimble install"
    echo "Failed!"
    exit 1
fi

if ! nimquote random; then
    echo "This is the happy path which failed"
    echo "Failed!"
    exit 1
fi

if ! nimquote qotd; then
    echo "This case should succeed!"
    echo "Failed!"
    exit 1
fi


if ! nimquote --help; then
    echo "longhand Help should be supported!"
    echo "Failed!"
    exit 1

fi

if ! nimquote -h; then
    echo "shorthand Help should be supported!"
    echo "Failed!"
    exit 1

fi

if ! nimquote --version; then
    echo "longhand version should be supported!"
    echo "Failed!"
    exit 1

fi

if ! nimquote -v; then
    echo "shorthand version should be supported!"
    echo "Failed!"
    exit 1
fi

echo "Adhoc testing complete!"
