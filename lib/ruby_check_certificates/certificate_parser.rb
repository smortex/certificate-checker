require 'openssl'

module RubyCheckCertificates
  class CertificateParser
    attr_reader :certificates

    def initialize(filename)
      @certificates = {}

      lineno = 0
      reading = false
      data = nil
      data_start_lineno = nil
      File.readlines(filename).each do |line|
        lineno += 1

        if !reading && line == "-----BEGIN CERTIFICATE-----\n" then
          data = line
          data_start_lineno = lineno
          reading = true
        elsif reading && line == "-----END CERTIFICATE-----\n" then
          data += line
          @certificates[data_start_lineno] = OpenSSL::X509::Certificate.new(data)
          reading = false
        elsif reading then
          data += line
        end
      end

      if reading then
        raise "Unexpected end of file"
      end
    end
  end
end
