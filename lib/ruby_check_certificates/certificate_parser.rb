require 'openssl'

module RubyCheckCertificates
  class CertificateParser
    attr_reader :certificates

    def initialize(filename)
      @certificates = {}
      @lineno = 0

      @f = File.open(filename)
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
        next unless line == "-----BEGIN CERTIFICATE-----\n"
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
        if line == "-----END CERTIFICATE-----\n"
          certificates[@data_start_lineno] = OpenSSL::X509::Certificate.new(@data)
          return
        end
      end

      raise 'Unexpected end of file'
    end
  end
end
