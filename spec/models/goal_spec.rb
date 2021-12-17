require 'rails_helper'

RSpec.describe Goal, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'has a valid factory' do
    expect(build_stubbed(:goal)).to be_valid
  end

  describe 'Validations' do
    it 'is invalid without a description' do
      expect(build_stubbed(:goal, description: nil)).to be_invalid
    end

    it 'is invalid without a amount' do
      expect(build_stubbed(:goal, amount: nil)).to be_invalid
    end

    it 'is invalid if the amount is less than 0' do
      expect(build_stubbed(:goal, amount: -10)).to be_invalid
    end

    it 'is invalid without a target_date' do
      expect(build_stubbed(:goal, target_date: nil)).to be_invalid
    end

    it 'is invalid if the target_date is in the past' do
      expect(build_stubbed(:goal, target_date: Date.yesterday)).to be_invalid
    end
  end

  describe 'Relations' do
    it { expect(Goal.reflect_on_association(:user).macro).to eq(:belongs_to) }
  end
end
