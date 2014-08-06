# RubyCheckCertificates

Find certificates in a directory tree and report any expired or about to expire certificate.

## Installation

As simple as:

    $ gem install ruby_check_certificates

## Usage

As simple as:

    $ ruby_check_certificates /usr/local/etc/apache2/ssl /usr/local/etc/slapd/cert

The report can be easily sent by e-mail.  Use the `-t` argument to specify the recipient's address.

## Contributing

1. Fork it ( https://github.com/sante-link/ruby_check_certificates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
