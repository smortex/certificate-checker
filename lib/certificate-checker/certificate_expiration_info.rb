# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module CertificateChecker
  class CertificateExpirationInfo
    attr_reader :file, :line, :certificate
    def initialize(file, line, certificate)
      @file = file
      @line = line
      @certificate = certificate
    end

    def subject
      @certificate.subject.to_s
    end

    def not_after
      days = ((@certificate.not_after - Time.now.utc) / (24 * 60 * 60))
      format_string = days.negative? ? '%s (%d %s ago)' : '%s (%d %s left)'
      days = days.truncate
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
