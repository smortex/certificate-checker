# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateChecker do
  describe '#to_e' do
    subject { checker.to_e }

    context 'with a certificate' do
      let(:checker) { described_class.new('/var/puppet/ssl/certs/ca.pem', 1, certificate) }

      let(:certificate) do
        certificate = OpenSSL::X509::Certificate.new
        certificate.not_before = Time.now.utc - 3600
        certificate.not_after  = Time.now.utc + 3600
        certificate.subject = OpenSSL::X509::Name.parse('/CN=example.com')
        certificate.issuer =  OpenSSL::X509::Name.parse('/CN=CA')
        certificate
      end

      it { is_expected.to include(service: '/var/puppet/ssl/certs/ca.pem:/CN=CA:/CN=example.com') }
    end

    context 'with a certificate revocation list' do
      let(:checker) { described_class.new('/var/puppet/ssl/ca/ca_crl.pem', 1, crl) }

      let(:crl) do
        crl = OpenSSL::X509::CRL.new
        crl.last_update = Time.now.utc - 3600
        crl.next_update = Time.now.utc + 3600
        crl.issuer = OpenSSL::X509::Name.parse('/CN=CA')
        crl
      end

      it { is_expected.to include(service: '/var/puppet/ssl/ca/ca_crl.pem:/CN=CA') }
    end
  end
end
