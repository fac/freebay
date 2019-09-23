FactoryBot.define do
  factory :user do
    first_name { 'Geoff' }
    last_name { 'Barndale' }
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password { 'asd;12£123asd' }
    encrypted_password { 'asd;12£123asd' }
    remember_token { 'ijioj23' }
  end
end
