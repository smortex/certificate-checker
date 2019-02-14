# RubyCheckCertificates

[![Build Status](https://travis-ci.com/smortex/ruby_check_certificates.svg?branch=master)](https://travis-ci.com/smortex/ruby_check_certificates)
[![Maintainability](https://api.codeclimate.com/v1/badges/83f90013cf861d5f1b79/maintainability)](https://codeclimate.com/github/smortex/ruby_check_certificates/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/83f90013cf861d5f1b79/test_coverage)](https://codeclimate.com/github/smortex/ruby_check_certificates/test_coverage)

Find certificates in a directory tree and report any expired or about to expire certificate.

## Installation

As simple as:

    $ gem install ruby_check_certificates

## Usage

As simple as:

    $ ruby_check_certificates /usr/local/etc/apache2/ssl /usr/local/etc/slapd/cert

The report can be easily sent by e-mail.  Use the `-t` argument to specify the recipient's address.

## Contributing

1. Fork it ( https://github.com/smortex/ruby_check_certificates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
