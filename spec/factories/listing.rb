FactoryBot.define do
  factory :listing do
    title { 'Apple MacBook Pro' }
    description { '13" MacBook Pro, Late 2015' }
    starting_price { 400 }
    end_time { Date.today + 7.days }
    condition { 'new'}
  end
end
