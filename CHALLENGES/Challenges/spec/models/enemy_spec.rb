require 'rails_helper'

RSpec.describe Enemy, type: :model do
  it 'should have a invalid enemy' do
    enemy = build(:enemy)
    expect(enemy).to be_valid
  end

  it 'should have a valid enemy' do
    expect(Enemy.create(name: 'test', power_base: 3000, power_step: 100, level: 1, kind: 'goblin')).to be_valid
  end
end
