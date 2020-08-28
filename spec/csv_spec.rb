require 'csv'
require_relative '../lib/csv_encoder.rb'

RSpec.describe CSV do
  describe 'VERSION' do
    it 'responds' do
      # expect(CSV::VERSION).to eq '3.0.9'
      expect(CSV::VERSION).to eq '2.4.8'
    end
  end

  describe '.generate' do
    it 'responds' do
      expect(CSV).to respond_to(:generate)
    end
  end

  describe 'Foo#generate' do
    let(:foo) { Foo.new.generate }
    subject { foo }

    it { is_expected.to be_an_instance_of(String) }

    describe '#encoding' do
      subject { foo.encoding.to_s }

      it { is_expected.to eq 'Windows-31J' }

      context 'when prepended with custom String#encode method' do
        before do
          String.prepend(OverrideStringEncodeWithOurDefaultOption)
        end

        subject { foo.encoding.to_s }

        it { is_expected.to eq 'Windows-31J' }
      end
    end
  end
end
