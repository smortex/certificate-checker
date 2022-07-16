# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CertificateChecker::CertificateFinder do
  let(:finder) { described_class.new }
  let(:root) { File.expand_path('../..', __dir__) }

  describe '#search' do
    subject { finder.search(path) }

    context 'with an existing directory' do
      let(:path) { root }

      it { is_expected.to eq(["#{root}/spec/certificate_checker/certificates/cacert.org.crt"]) }
    end

    context 'with an existing certificate' do
      let(:path) { "#{root}/spec/certificate_checker/certificates/cacert.org.crt" }

      it { is_expected.to eq(["#{root}/spec/certificate_checker/certificates/cacert.org.crt"]) }
    end

    context 'with an non-existing path' do
      let(:path) { '/var/empty/no-such-file-or-directory' }

      it { is_expected.to eq([]) }
    end
  end
end
