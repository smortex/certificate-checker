# certificate-checker

[![Build Status](https://travis-ci.com/smortex/certificate-checker.svg?branch=master)](https://travis-ci.com/smortex/certificate-checker)
[![Maintainability](https://api.codeclimate.com/v1/badges/183f536f05771eca87f2/maintainability)](https://codeclimate.com/github/smortex/certificate-checker/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/183f536f05771eca87f2/test_coverage)](https://codeclimate.com/github/smortex/certificate-checker/test_coverage)

Find certificates in a directory tree and report any expired or about to expire certificate.

## Installation

As simple as:

    $ gem install certificate-checker

## Usage

As simple as:

    $ certificate-checker /usr/local/etc/apache2/ssl /usr/local/etc/slapd/cert

The report can be easily sent by e-mail.  Use the `-t` argument to specify the recipient's address.

## Contributing

1. Fork it ( https://github.com/smortex/certificate-checker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
