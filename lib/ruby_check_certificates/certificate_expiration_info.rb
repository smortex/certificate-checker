module RubyCheckCertificates
  class CertificateExpirationInfo
    attr_reader :file, :line, :certificate
    def initialize(file, line, certificate)
      @file = file
      @line = line
      @certificate = certificate
    end
  end
end
