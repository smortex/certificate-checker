require 'spec_helper'

describe RubyCheckCertificates::CertificateFinder do
  it 'finds certificates' do
    root = File.expand_path('../..', __FILE__)
    finder = RubyCheckCertificates::CertificateFinder.new
    expect(finder.certificates(root)).to eq(["#{root}/spec/certificates/cacert.org.crt"])
  end
end
