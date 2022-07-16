# certificate-checker

[![Build Status](https://github.com/smortex/certificate-checker/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/smortex/certificate-checker/actions/workflows/ci.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/183f536f05771eca87f2/maintainability)](https://codeclimate.com/github/smortex/certificate-checker/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/183f536f05771eca87f2/test_coverage)](https://codeclimate.com/github/smortex/certificate-checker/test_coverage)

Find certificates in a directory tree and report any expired or about to expire
certificate.

## Installation

As simple as:

    $ gem install certificate-checker

## Usage

As simple as:

    $ certificate-checker /usr/local/etc/apache2/ssl /usr/local/etc/slapd/cert

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/smortex/certificate-checker. This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

1. Fork it (https://github.com/smortex/certificate-checker/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the certificate-checker project’s codebases, issue
trackers, chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/smortex/certificate-checker/blob/main/CODE_OF_CONDUCT.md).
