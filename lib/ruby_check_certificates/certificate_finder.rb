module RubyCheckCertificates
  class CertificateFinder
    def initialize(config = {})
      @config = config.merge(ext: ['*.pem', '*.crt'])
    end

    def certificates(path)
      res = []
      if File.directory?(path)
        @config[:ext].each do |ext|
          res << Dir.glob(File.join(path, '**', ext))
        end
      elsif File.exist?(path)
        res << path
      else
        raise "No such file or directory: #{path}"
      end
      res.flatten
    end
  end
end
