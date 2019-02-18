# frozen_string_literal: true

module CertificateChecker
  class CertificateCheckerFactory
    def initialize
      @finder = CertificateFinder.new
    end

    def certificate_checkers_for(filename)
      @finder.search(filename).map do |file|
        parser = CertificateParser.new(file)
        parser.certificates.map do |line, certificate|
          CertificateChecker.new(file, line, certificate)
        end
      end.flatten
    end
  end
end
