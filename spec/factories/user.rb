FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    phone {"0905507959"}
    address {Faker::Address.street_address}
    email {Faker::Internet.email}
    password {"foobar"}
    password_confirmation {"foobar"}
  end

  factory :invalid_user, parent: :user do
    name {nil}
  end
end

