FactoryBot.define do
  factory :enemy do
    name { FFaker::Lore.word }
    power_base { FFaker::Randomm.rand(1..9999) }
    power_step { FFaker::Randomm.rand(1..9999) }
    level { FFaker::Randomm.rand(1..99) }
    kind { %w[goblin orc demon dragon].sample }
  end
end
