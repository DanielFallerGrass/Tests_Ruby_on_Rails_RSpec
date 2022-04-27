require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
  describe 'GET /index' do
    context 'success' do
      it 'should be return a list of enemies' do
        enemies = create_list(:enemy, 3)
        get enemies_path

        enemies.each do |enemy|
          expect(response.body).to include(enemy.name)
        end
      end
    end
  end

  describe 'POST / create' do
    context 'when has valid parameters' do
      it 'create a enemy' do
        enemies_attributes = FactoryBot.attributes_for(:enemy)
        post enemies_path, params: { enemy: enemies_attributes }
        expect(Enemy.last).to have_attributes(enemies_attributes)
      end

    end

    context 'when has no valid parameters' do
      it 'do not create the weapon with invalid attributes' do
        expect{
          post enemies_path, params: { enemy: { name: '', power_base: -1, power_step: -1, level: -1, kind: '' } }
        }.to_not change(Enemy, :count)
      end
    end
  end

  describe 'PUT /enemies' do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) { put "/enemies/#{enemy.id}", params: enemy_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the record' do
        expect(enemy.reload).to have_attributes(enemy_attributes) # Quando existe atualiza o record
      end

      it 'returns the enemy updated' do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at')) # Testando com o body
      end
    end

    context 'when the enemy does not exist' do
      before(:each) {put '/enemies/0', params: attributes_for(:enemy)}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe 'DELETE /enemies' do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'destroy the record' do
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exists' do
      before(:each) {delete '/enemies/0'}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "GET /show" do
    it "Whether all attributes have been displayed on the screen" do
      enemy = create(:enemy)

      get enemy_path(enemy)
      expect(response.body).to include(enemy.name)
      expect(response.body).to include(enemy.power_base.to_s)
      expect(response.body).to include(enemy.power_step.to_s)
      expect(response.body).to include(enemy.level.to_s)
    end
  end
end
