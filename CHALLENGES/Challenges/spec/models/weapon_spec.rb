require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'should have a invalid weapon' do
    weapon = build(:weapon)
    expect(weapon).to be_valid
  end

  it 'should have a valid weapon' do
    expect(Weapon.create(name: 'Excalibur', description: 'two hand', power_base: 3000, power_step: 100, level: 1)).to be_valid
  end

  it 'should have return a valid title' do
    weapon = Weapon.create(name: 'Excalibur', description: 'two hand', power_base: 3000, power_step: 100, level: 3)
    expect(weapon.title).to eq('Excalibur #3')
  end
end
