# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateChecker do
  subject do
    CertificateChecker::CertificateChecker.new('/var/puppet/ssl/certs/ca.pem', 1, certificate)
  end

  let(:certificate) do
    certificate = OpenSSL::X509::Certificate.new
    certificate.not_before = Time.now.utc - 3600
    certificate.not_after  = Time.now.utc + 3600
    certificate
  end

  context '#to_e' do
    it 'has a proper service' do
      expect(subject.to_e[:service]).to eq('/var/puppet/ssl/certs/ca.pem:1')
    end
  end
end
