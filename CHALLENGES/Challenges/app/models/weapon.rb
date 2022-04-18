class Weapon < ApplicationRecord
  validates :level, numericality: {greater_than: 0}
  validates :power_base, numericality: {greater_than_or_equal_to: 3000}

  def current_power
    # Esse método mostra o poder atual da weapon
    power_base + (level-1) *  power_step
  end

  def title
    # Esse método mostra o título da arma   
    "#{name} ##{level}"
  end 
end
