require 'spec_helper'
require 'hero'
 
describe Hero do
  it 'has a sword' do
    hero = Hero.new
    expect(hero.weapon).to eq('sword')
  end

  it 'has more then 1000 HP' do
    hero = Hero.new
    expect(hero.health).to be > 1000
  end
end
