require 'rails_helper'

RSpec.describe Guest, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  describe "when email is not a valid format" do
    before { @email = "invalid.email.com" }

    it { should_not be_valid }
  end

end
