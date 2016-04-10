require 'active_support'
require 'active_support/duration'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/integer/time'

module RubyCheckCertificates
  class CertificateReport
    def initialize
      @certificates = []
      @checked_certificates = 0
    end

    def check_certificate(file, line, certificate)
      @checked_certificates += 1
      if certificate.not_after + 3600 * 24 * 30 * 2 < Time.now.utc
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
      "#{error_count} problem#{'s' if error_count != 1} found in #{@checked_certificates} certificate#{'s' if @checked_certificates != 1}\n\n"
    end

    def certificate_group(label, crts)
      res = "#{sprintf(label, crts.count, crts.count != 1 ? 's' : '')}:\n"
      crts.each do |crt|
        res += "#{certificate_details(crt)}\n"
      end
      res
    end

    def certificate_details(crt)
      res = <<EOT
  * #{crt.file}:#{crt.line}
    subject:   #{crt.certificate.subject}
    not_after: #{crt.certificate.not_after} (#{n = ((Time.now.utc - crt.certificate.not_after) / (2600 * 24)).ceil} day#{ 's' if n != 1} ago)
EOT
      crt.certificate.extensions.each do |ext|
        res += "    #{ext.oid}: #{ext.value.chomp.gsub(/\n\s*/, "\n" + ' ' * (4 + ext.oid.length + 2))}\n"
      end
      res
    end

    def to_s
      now = Time.now.utc

      stop_offsets = {
        '%d expired certificate%s' => now,
        '%d certificate%s expiring in less than 1 week'   => now + 1.week,
        '%d certificate%s expiring in less than 2 weeks'  => now + 2.weeks,
        '%d certificate%s expiring in less than 1 month'  => now + 1.month,
        '%d certificate%s expiring in less than 2 months' => now + 2.months
      }

      last_stop = nil

      @certificates.sort! { |a, b| a.certificate.not_after <=> b.certificate.not_after }
      res = summary
      stop_offsets.each do |label, stop|
        crts = @certificates.select { |x| (last_stop.nil? || x.certificate.not_after > last_stop) && x.certificate.not_after <= stop }
        if crts.count > 0
          res += certificate_group(label, crts)
        end
        last_stop = stop
      end
      res
    end
  end
end
