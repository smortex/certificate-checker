# frozen_string_literal: true

RSpec.describe CertificateChecker::CertificateCheckerFactory do
  let(:root) do
    File.expand_path('..', __dir__)
  end

  context '#certificate_checkers_for' do
    it 'returns an array of CertificateChecker' do
      expect(subject.certificate_checkers_for(root)).to be_a(Array)
      expect(subject.certificate_checkers_for(root).size).to eq(2)
      expect(subject.certificate_checkers_for(root)[0].file).to eq("#{root}/spec/certificates/cacert.org.crt")
      expect(subject.certificate_checkers_for(root)[0].line).to eq(1)
      expect(subject.certificate_checkers_for(root)[0].certificate).to be_a(OpenSSL::X509::Certificate)
      expect(subject.certificate_checkers_for(root)[1].file).to eq("#{root}/spec/certificates/cacert.org.crt")
      expect(subject.certificate_checkers_for(root)[1].line).to eq(42)
      expect(subject.certificate_checkers_for(root)[1].certificate).to be_a(OpenSSL::X509::Certificate)
    end
  end
end
