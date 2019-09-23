FactoryBot.define do
  factory :bid do
    listing
    user

    amount { 500 }
  end
end