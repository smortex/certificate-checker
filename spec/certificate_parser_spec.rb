# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CertificateChecker::CertificateParser do
  it 'parses files containing multiple certificates' do
    s = CertificateChecker::CertificateParser.new(File.expand_path('certificates/cacert.org.crt', __dir__))
    expect(s.certificates.count).to eq(2)
    expect(s.certificates.keys).to eq([1, 42])
    expect(s.certificates.values.map { |x| x.subject.to_s }).to eq [
      '/O=Root CA/OU=http://www.cacert.org/CN=CA Cert Signing Authority/emailAddress=support@cacert.org',
      '/O=CAcert Inc./OU=http://www.CAcert.org/CN=CAcert Class 3 Root',
    ]
  end
end
