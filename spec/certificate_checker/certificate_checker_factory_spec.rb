# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateCheckerFactory do
  let(:factory) { described_class.new }
  let(:root) { File.expand_path('../..', __dir__) }

  describe '#certificate_checkers_for' do
    subject { checkers }

    let(:checkers) { factory.certificate_checkers_for(root) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to have_attributes(size: 2) }

    describe '#[0]' do
      subject { checkers[0] }

      it { is_expected.to have_attributes(file: "#{root}/spec/certificate_checker/certificates/cacert.org.crt") }
      it { is_expected.to have_attributes(line: 1) }
      it { is_expected.to have_attributes(certificate: OpenSSL::X509::Certificate) }
    end

    describe '#[1]' do
      subject { checkers[1] }

      it { is_expected.to have_attributes(file: "#{root}/spec/certificate_checker/certificates/cacert.org.crt") }
      it { is_expected.to have_attributes(line: 42) }
      it { is_expected.to have_attributes(certificate: OpenSSL::X509::Certificate) }
    end
  end
end
