module RubyCheckCertificates
  class CertificateFinder
    def initialize(config = {})
      @config = config.merge(ext: ['*.pem', '*.crt'])
    end

    def certificates(path)
      res = []
      @config[:ext].each do |ext|
        res << Dir.glob(File.join(path, '**', ext))
      end
      res.flatten
    end
  end
end
