# frozen_string_literal: true

require 'openssl'

module CertificateChecker
  class CertificateParser
    attr_reader :certificates

    def initialize(filename)
      @filename = filename
      @certificates = {}
      @lineno = 0

      @f = File.open(@filename, 'rb')
      begin
        read_random_data
      ensure
        @f.close
      end
    end

    private

    def read_random_data
      until @f.eof?
        line = @f.readline
        @lineno += 1
        next unless line.match?(/^-----BEGIN CERTIFICATE-----/)

        @data_start_lineno = @lineno
        @data = line
        read_certificate
      end
    end

    def read_certificate
      until @f.eof?
        line = @f.readline
        @lineno += 1
        @data += line
        if line.match?(/^-----END CERTIFICATE-----/)
          add_certificate
          return
        end
      end

      raise "#{@filename}:#{@lineno}: Unexpected end of file"
    end

    def add_certificate
      certificates[@data_start_lineno] = OpenSSL::X509::Certificate.new(@data)
    rescue OpenSSL::X509::CertificateError => e
      warn "Error parsing certificate at #{@filename}:#{@data_start_lineno}: #{e.message}"
    end
  end
end
