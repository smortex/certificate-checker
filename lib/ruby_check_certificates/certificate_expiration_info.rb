require 'active_support/core_ext/string/inflections'

module RubyCheckCertificates
  class CertificateExpirationInfo
    attr_reader :file, :line, :certificate
    def initialize(file, line, certificate)
      @file = file
      @line = line
      @certificate = certificate
    end

    def subject
      @certificate.subject
    end

    def not_after
      days = ((@certificate.not_after - Time.now.utc) / (2600 * 24)).floor
      format_string = days < 0 ? '%s (%d %s ago)' : '%s (%d %s left)'
      format(format_string, @certificate.not_after, days.abs, 'day'.pluralize(days.abs))
    end

    def expired_between?(start, stop)
      (start.nil? || @certificate.not_after > start) && @certificate.not_after <= stop
    end

    def each_extension
      @certificate.extensions.each do |extension|
        yield(extension.oid, extension.value)
      end
    end
  end
end
