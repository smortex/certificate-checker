require 'active_support'
require 'active_support/duration'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/integer/time'
require 'active_support/core_ext/string/inflections'

module CertificateChecker
  class CertificateReport
    def initialize
      @certificates = []
      @checked_certificates = 0

      @now = Time.now.utc

      @stop_offsets = {
        '%d expired %s' => @now,
        '%d %s expiring in less than 1 week'   => @now + 1.week,
        '%d %s expiring in less than 2 weeks'  => @now + 2.weeks,
        '%d %s expiring in less than 1 month'  => @now + 1.month,
        '%d %s expiring in less than 2 months' => @now + 2.months
      }
    end

    def check_certificate(file, line, certificate)
      @checked_certificates += 1
      if certificate.not_after < @stop_offsets.values.last
        @certificates << CertificateExpirationInfo.new(file, line, certificate)
      end
    end

    def errors?
      @certificates.count > 0
    end

    def error_count
      @certificates.count
    end

    def summary
      "#{error_count} #{'problem'.pluralize(error_count)} found in #{@checked_certificates} #{'certificate'.pluralize(@checked_certificates)}\n\n"
    end

    def certificate_group(label, crts)
      res = "#{format(label, crts.count, 'certificate'.pluralize(crts.count))}:\n"
      crts.each do |crt|
        res += "#{certificate_details(crt)}\n"
      end
      res
    end

    def certificate_details(crt)
      res = <<EOT
  * #{crt.file}:#{crt.line}
    subject:   #{crt.subject}
    not_after: #{crt.not_after}
EOT
      crt.each_extension do |oid, value|
        res += format_extension(oid, value)
      end
      res
    end

    def format_extension(oid, value)
      "    #{oid}: #{value.chomp.gsub(/\n\s*/, "\n" + ' ' * (4 + oid.length + 2))}\n"
    end

    def to_s
      last_stop = nil

      @certificates.sort! { |a, b| a.certificate.not_after <=> b.certificate.not_after }

      res = summary
      @stop_offsets.each do |label, stop|
        crts = @certificates.select { |x| x.expired_between?(last_stop, stop) }
        res += certificate_group(label, crts) if crts.count > 0
        last_stop = stop
      end
      res
    end
  end
end
