import httpclient
import os
import strutils
import strformat
import docopt
import random
import std/wordwrap
import json

# httpclient doesn't handle proxying. This proxying
# assumes then that you're keeping the proxy-info somewhere
# in a unix environment variable. An empty string
# is assumed to mean no settings are needed.
proc getProxySettings(): string =
  return if existsEnv("https_proxy"):
    getEnv("https_proxy")
  elif existsEnv("HTTPS_PROXY"):
    getEnv("HTTPS_PROXY")
  elif existsEnv("http_proxy"):
    getEnv("http_proxy")
  elif existsEnv("HTTP_PROXY"):
    getEnv("HTTP_PROXY")
  else:
    ""

# Creates a new httpclient, with proxy settings
# if need be.
proc getHttpClient(): HttpClient =
  let proxy_settings = getProxySettings()

  let client = if proxy_settings.isEmptyOrWhitespace():
    newHttpClient()
  else:
    newHttpClient(proxy=newProxy(url=proxy_settings))
  
  return client

# Getting a random quote requires an API key. It isn't
# safe to publish our own, so instead the user will have
# to set one into his/her environment with
# export FAVQS_API_KEY="..."
proc getAPIKey(): string = 
  if existsEnv("FAVQS_API_KEY"):
    return getEnv("FAVQS_API_KEY")
  else:
    raise newException(OSError, "ERROR: FAVQS_API_KEY is not set. Register at https://favqs.com/api.")

# the qotd API requires no token or authorization headers, so we can hit
# this point freely.
proc get_qotd(client: HttpClient): JsonNode =
  return json.parseJson(client.getContent("https://favqs.com/api/qotd"))["quote"]

# favqs has no real "random" quote feature. The 
# quotes endpoint does give a random page, so a
# page item between 0-24. Note that his requires
# a token, so export FAVQS_API_KEY!
proc get_random_quote(client: HttpClient): JsonNode =
  let api_key = getAPIKey()
  client.headers = newHttpHeaders({"Authorization": &"Token token=\"{api_key}\""})
  let quote_list = json.parseJson(client.getContent("https://favqs.com/api/quotes"))
  return quote_list["quotes"][rand(24)]

proc print_quote(quote: JsonNode) =
  let body = quote["body"].getStr()
  let author = quote["author"].getStr()
  echo(wrapWords(body), &"\n--{author}")

when isMainModule:
  let doc = """
    nimquote - Random quotes in Nim. Expects
               FAVQS_API_KEY to be exported.

    Usage:
      nimquote random
      nimquote qotd

    Options:
      -h --help        Show this screen.
      --version        Show version.
    """
  let args = docopt(doc, version="1.0.0")
  let client = getHttpClient()
  # Nim requires this to be called manually,
  # otherwise the result of the random module
  # is always the same.
  random.randomize()


  let quote = if args["qotd"]: get_qotd(client)
              else: get_random_quote(client)

  print_quote(quote)