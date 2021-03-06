# frozen_string_literal: true

require 'internet_security_event'

module CertificateChecker
  # EventWrapper
  class CertificateChecker
    attr_reader :file, :line, :certificate

    def initialize(file, line, certificate)
      @file = file
      @line = line
      @certificate = certificate
    end

    def to_e
      InternetSecurityEvent::X509Status.build(certificate).merge(
        service: service,
        line:    line,
        ttl:     3600 * 12,
        tags:    ['certificate-checker'],
      )
    end

    private

    def service
      "#{file}:#{certificate.issuer}:#{certificate.subject}"
    end
  end
end
