module RubyCheckCertificates
  class CertificateExpirationInfo
    attr_reader :file, :line, :subject, :not_after
    def initialize(file, line, subject, not_after)
      @file, @line, @subject, @not_after = file, line, subject, not_after
    end
  end
end
