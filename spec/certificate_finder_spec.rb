require 'spec_helper'

RSpec.describe CertificateChecker::CertificateFinder do
  let(:root) do
    File.expand_path('..', __dir__)
  end

  it 'finds certificates in a directory' do
    expect(subject.search(root)).to eq(["#{root}/spec/certificates/cacert.org.crt"])
  end

  it 'finds certificate by name' do
    filename = "#{root}/spec/certificates/cacert.org.crt"
    expect(subject.search(filename)).to eq(["#{root}/spec/certificates/cacert.org.crt"])
  end

  it 'returns an empty array when no file is provided' do
    expect(subject.search('no-such-file')).to eq([])
  end
end
