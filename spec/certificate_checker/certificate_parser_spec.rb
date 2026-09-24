# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CertificateChecker::CertificateParser do
  describe '#objects' do
    subject { parser.objects }

    context 'when given a certificate' do
      let(:parser) { described_class.new(File.expand_path('certificates/cacert.org.crt', __dir__)) }

      it { is_expected.to have_attributes(count: 2) }
      it { is_expected.to have_attributes(keys: [1, 42]) }
      it { is_expected.to have_attributes(values: [OpenSSL::X509::Certificate, OpenSSL::X509::Certificate]) }
    end

    context 'when given a CRL' do
      subject { parser.objects }

      let(:parser) { described_class.new(File.expand_path('certificates/rfc5280_CRL.crl', __dir__)) }

      it { is_expected.to have_attributes(count: 1) }
      it { is_expected.to have_attributes(keys: [1]) }
      it { is_expected.to have_attributes(values: [OpenSSL::X509::CRL]) }
    end
  end
end
