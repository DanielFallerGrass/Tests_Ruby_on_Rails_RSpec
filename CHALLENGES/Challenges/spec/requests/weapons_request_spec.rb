require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  describe 'GET /index' do
    it 'should be return a list of weapons' do
      weapons = create_list(:weapon, 3)

      get weapons_path

      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end
  end

  describe 'POST /create' do
    context 'when it has valid parameters' do
      it 'creates the weapon with correct attributes' do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context 'when it has no valid parameters' do
      it 'do not create the weapon with invalid attributes' do
        expect{
          post weapons_path, params: { weapon: { name: '', description: '', power_base: -1, power_step: -1, level: -1 } }
        }.to_not change(Weapon, :count)
      end
    end
  end

  describe "DESTROY /weapon/:id" do
    context "when it has valid parameters" do
      it "destroy weapon" do

        weapon = create(:weapon)

        expect {
          delete weapon_path(weapon)
        }.to change{ Weapon.count }.by(-1)

        expect(Weapon.find_by_id(weapon.id)).to be_nil

        expect { weapon.reload }.to raise_error(ActiveRecord::RecordNotFound)

      end
    end
  end

  describe "GET /show" do
    it "Whether all attributes have been displayed on the screen" do
      weapon = create(:weapon)

      get weapon_path(weapon)
      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.current_power.to_s)
      expect(response.body).to include(weapon.level.to_s)
    end
  end
end
