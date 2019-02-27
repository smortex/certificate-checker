# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateCheckerFactory do
  let(:factory) { CertificateChecker::CertificateCheckerFactory.new }
  let(:root) { File.expand_path('..', __dir__) }

  context '#certificate_checkers_for' do
    let(:checkers) { factory.certificate_checkers_for(root) }
    subject { checkers }

    it { is_expected.to be_an(Array) }
    it { is_expected.to have_attributes(size: 2) }

    context '#[0]' do
      subject { checkers[0] }

      it { is_expected.to have_attributes(file: "#{root}/spec/certificates/cacert.org.crt") }
      it { is_expected.to have_attributes(line: 1) }
      it { is_expected.to have_attributes(certificate: OpenSSL::X509::Certificate) }
    end

    context '#[1]' do
      subject { checkers[1] }

      it { is_expected.to have_attributes(file: "#{root}/spec/certificates/cacert.org.crt") }
      it { is_expected.to have_attributes(line: 42) }
      it { is_expected.to have_attributes(certificate: OpenSSL::X509::Certificate) }
    end
  end
end
