FactoryBot.define do
  factory :user do
    nickname { FFaker::Lorem.word }
    kind { %w[knight wizard].sample }  #%w devolve uma string
    level { FFaker::Random.rand(1..99) }
  end
end