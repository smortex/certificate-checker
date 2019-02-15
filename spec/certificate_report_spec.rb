RSpec.shared_context 'with a certificate' do
  before do
    certificate = OpenSSL::X509::Certificate.new
    certificate.subject = OpenSSL::X509::Name.parse('/CN=example.com')
    certificate.not_before = not_before
    certificate.not_after = not_after
    subject.check_certificate('/path/to/file/name.crt', 42, certificate)
  end
end

RSpec.shared_context 'with a valid certificate' do
  let(:not_before) { Time.now.utc - 1.day }
  let(:not_after) { Time.now.utc + 3.months }

  include_context 'with a certificate'
end

RSpec.shared_context 'with a certificate expiring in 5 days' do
  let(:not_before) { Time.now.utc - 1.day }
  let(:not_after) { Time.now.utc + 5.days }

  include_context 'with a certificate'
end

RSpec.shared_context 'with an expired certificate' do
  let(:not_before) { Time.now.utc - 1.month }
  let(:not_after) { Time.now.utc - 1.day }

  include_context 'with a certificate'
end

RSpec.describe CertificateChecker::CertificateReport do
  describe '#summary' do
    context 'no certificate' do
      it 'returns correct summary' do
        expect(subject.summary).to eq("0 problems found in 0 certificates\n\n")
      end
    end

    context 'with a valid certificate' do
      include_context 'with a valid certificate'

      it 'returns correct summary' do
        expect(subject.summary).to eq("0 problems found in 1 certificate\n\n")
      end
    end

    context 'with a certificate about to expire' do
      include_context 'with a certificate expiring in 5 days'

      it 'returns correct summary' do
        expect(subject.summary).to eq("1 problem found in 1 certificate\n\n")
      end
    end

    context 'with an expired certificate' do
      include_context 'with an expired certificate'

      it 'returns correct summary' do
        expect(subject.summary).to eq("1 problem found in 1 certificate\n\n")
      end
    end
  end

  describe '#to_s' do
    context 'with a valid certificate' do
      include_context 'with a valid certificate'

      it 'outputs correct information' do
        expect(subject.to_s).to eq("0 problems found in 1 certificate\n\n")
      end
    end

    context 'with a certificate about to expire' do
      include_context 'with a certificate expiring in 5 days'

      it 'outputs correct information' do
        expect(subject.to_s).to match('1 problem found in 1 certificate')
        expect(subject.to_s).to match('1 certificate expiring in less than 1 week:')
        expect(subject.to_s).to match('/path/to/file/name.crt:42')
      end
    end
  end
end
