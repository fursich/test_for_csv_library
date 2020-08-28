require 'csv'

RSpec.describe CSV do
  describe 'VERSION' do
    it 'responds' do
      expect(CSV::VERSION).to eq '3.0.9'
    end
  end

  describe '.generate' do
    it 'responds' do
      expect(CSV).to respond_to(:generate)
    end
  end
end
