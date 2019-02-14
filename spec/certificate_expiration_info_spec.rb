require 'spec_helper'

RSpec.describe RubyCheckCertificates::CertificateExpirationInfo do
  subject { RubyCheckCertificates::CertificateExpirationInfo.new('not-on-disk.crt', 1, certificate) }

  context '#expired_between?' do
    let(:certificate) do
      certificate = OpenSSL::X509::Certificate.new
      certificate.not_after = Time.parse('2016-01-15')
      certificate
    end
    let(:jan) { Date.parse('2015-01-01') }
    let(:feb) { Date.parse('2016-02-01') }
    let(:mar) { Date.parse('2016-03-01') }

    it 'Reports a correct expiration date' do
      expect(subject.expired_between?(jan, feb)).to be_truthy
      expect(subject.expired_between?(feb, mar)).to be_falsy
    end
  end

  context '#not_after' do
    let(:certificate) do
      certificate = OpenSSL::X509::Certificate.new
      certificate.not_after = expiration_date
      certificate
    end
    let(:date) { Time.now.utc }

    context 'a few days ago' do
      let(:expiration_date) { date - 27 * 24 * 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (27 days ago)")
      end
    end

    context 'yesterday' do
      let(:expiration_date) { date - 24 * 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (1 day ago)")
      end
    end

    context 'one hour ago' do
      let(:expiration_date) { date - 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (0 days ago)")
      end
    end

    context 'in one hour' do
      let(:expiration_date) { date + 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (0 days left)")
      end
    end

    context 'tomorow' do
      let(:expiration_date) { date + 24 * 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (0 days left)")
      end
    end

    context 'in a few days' do
      let(:expiration_date) { date + 27 * 24 * 60 * 60 }

      it 'reports correct expiration information' do
        expect(subject.not_after).to eq("#{expiration_date} (26 days left)")
      end
    end
  end
end
