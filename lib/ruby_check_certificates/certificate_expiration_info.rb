module RubyCheckCertificates
  class CertificateExpirationInfo
    attr_reader :file, :line, :certificate
    def initialize(file, line, certificate)
      @file, @line, @certificate = file, line, certificate
    end
  end
end
