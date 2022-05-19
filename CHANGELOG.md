# 0.5.27

* Add support for faraday gem version >= 1.0.0 and < 2.0.0

# 0.5.26

* Add support for HTTP status code: 412 Precondition Failed

# 0.5.25

* Fix broken gem build (gemspec files)

# 0.5.23

* Add support for HTTP status code: 423 Locked

# 0.5.22

* Add constraint on faraday < 1.0.0 as it breaks compatibility

# 0.5.21

* add support for http 410 status code

# 0.5.20

* brought back jruby support
* updated CI pipeline

# 0.5.19

* introduced PATCH requests.
* brought back ruby < 2.1 compatibility. Process::CLOCK_MONOTONIC is not present until ruby 2.2. There was a breaking change since 0.5.16.

# 0.5.18

* pass along the caller to each `connection` hook

# 0.5.17
 * fix a bug where logger on debug level thrown an encoding error #19

# 0.5.16

 * improve logging, log request details on Logger::DEBUG level

# 0.5.15

 * add response status code to error message

# 0.5.14

 * make ApiClient::Base marshallable by not storing proc as instance var

# 0.5.13

 * add raw_body method to Scope which allows to set non-hash request payload

# 0.5.12

 * fix threading problem on ruby 1.8.7 and earlier

# 0.5.11

 * fix handling errors

# 0.5.10

 * add TooManyRequests error

# 0.5.9

 * fix compatibility with ruby 1.8.x

# 0.5.8

 * fix the problem with strict_attr_reader and Array#flatten

# 0.5.7

 * fix compatibility with hashie 2.1.0 and strict_attr_reader

# 0.5.6

 * add strict_attr_reader option to raise `KeyError` on missing key access
