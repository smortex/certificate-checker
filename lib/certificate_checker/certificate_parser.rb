# frozen_string_literal: true

require 'openssl'

module CertificateChecker
  class CertificateParser
    attr_reader :objects

    def initialize(filename)
      @filename = filename
      @objects = {}

      process_file
    end

    def process_file
      @status = nil
      @data = ''

      @lineno = 0
      File.read(@filename).each_line do |line|
        @lineno += 1

        taste_header(line)
        process(line)
        taste_footer(line)
      end
    end

    def taste_header(line)
      if line.match(/^-----BEGIN CERTIFICATE-----/)
        @status = :read_certificate
        @data_start_lineno = @lineno
      elsif line.match(/^-----BEGIN X509 CRL-----/)
        @status = :read_crl
        @data_start_lineno = @lineno
      end
    end

    def process(line)
      @data += line if @status
    end

    def taste_footer(line)
      if @status == :read_certificate && line.match(/^-----END CERTIFICATE-----/)
        @status = nil
        add_certificate(@data)
        @data = ''
      elsif @status == :read_crl && line.match(/^-----END X509 CRL-----/)
        @status = nil
        add_certificate_revocation_list(@data)
        @data = ''
      end
    end

    private

    def add_certificate(data)
      objects[@data_start_lineno] = OpenSSL::X509::Certificate.new(data)
    rescue OpenSSL::X509::CertificateError => e
      warn "Error parsing certificate at #{@filename}:#{@data_start_lineno}: #{e.message}"
    end

    def add_certificate_revocation_list(data)
      objects[@data_start_lineno] = OpenSSL::X509::CRL.new(data)
    rescue OpenSSL::X509::CRLError => e
      warn "Error parsing crl at #{@filename}:#{@data_start_lineno}: #{e.message}"
    end
  end
end
