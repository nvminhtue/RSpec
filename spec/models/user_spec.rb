require "rails_helper"
RSpec.describe User, type: :model do
  describe "Assosciations" do
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many(:products).through(:ratings)}
    it {is_expected.to have_many :suggestion}
    it {is_expected.to have_many :orders}
  end
  describe "Validations" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most(50)}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most(255)}
    it {is_expected.to validate_presence_of :address}
    it {is_expected.to validate_presence_of :phone}
    it {is_expected.to validate_presence_of :password}
    it {is_expected.to validate_length_of(:password).is_at_least(6)}
  end
end
describe User do
  subject {FactoryBot.create(:user)}
  it {expect(subject.email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)}
  it {is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity}
  it {expect(subject.phone).to match(/(09|03|05|07|08)+([0-9]{8})\b/)}
  context ".callback before save" do
    # let(:tue){FactoryBot.build(:user, email: "AbC@mail.com")}
    tue = FactoryBot.build(:user, email: "AbC@mail.com")
    it "downcase email" do
      expect(tue.email).to eq("AbC@mail.com")
      tue.run_callbacks :save
      expect(tue.email).to eq("abc@mail.com")
    end
  end
end
