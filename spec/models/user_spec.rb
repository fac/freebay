require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe '#name' do
    it "should return first name and last name" do
      user = User.new(first_name: 'john', last_name: 'doe')
      expect(user.name).to eq('john doe')
    end
  end
end
