# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CertificateChecker::CertificateParser do
  let(:parser) { CertificateChecker::CertificateParser.new(File.expand_path('certificates/cacert.org.crt', __dir__)) }

  context '#certificates' do
    subject { parser.certificates }

    it { is_expected.to have_attributes(count: 2) }
    it { is_expected.to have_attributes(keys: [1, 42]) }
    it { is_expected.to have_attributes(values: [OpenSSL::X509::Certificate, OpenSSL::X509::Certificate]) }
  end
end
