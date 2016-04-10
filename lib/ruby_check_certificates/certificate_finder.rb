module RubyCheckCertificates
  class CertificateFinder
    def initialize(config = {})
      @config = config.merge(ext: ['*.pem', '*.crt'])
    end

    def search(path)
      if File.directory?(path)
        search_directory(path)
      elsif File.exist?(path)
        search_file(path)
      else
        $stderr.puts "No such file or directory @ #{self.class.name}##{__callee__} - #{path}"
        []
      end
    end

    private

    def search_directory(path)
      res = []
      @config[:ext].each do |ext|
        res << Dir.glob(File.join(path, '**', ext))
      end
      res.flatten
    end

    def search_file(path)
      [path]
    end
  end
end
