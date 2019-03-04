# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateChecker do
  let(:checker) { CertificateChecker::CertificateChecker.new('/var/puppet/ssl/certs/ca.pem', 1, certificate) }

  let(:certificate) do
    certificate = OpenSSL::X509::Certificate.new
    certificate.not_before = Time.now.utc - 3600
    certificate.not_after  = Time.now.utc + 3600
    certificate.subject = OpenSSL::X509::Name.parse('/CN=example.com')
    certificate.issuer =  OpenSSL::X509::Name.parse('/CN=CA')
    certificate
  end

  context '#to_e' do
    subject { checker.to_e }

    it { is_expected.to include(service: '/var/puppet/ssl/certs/ca.pem:/CN=CA:/CN=example.com') }
  end
end
