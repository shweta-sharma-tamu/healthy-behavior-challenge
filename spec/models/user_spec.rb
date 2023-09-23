require "rails_helper"

describe User, type: :model do
    describe "validations" do
        it "is invalid without an email" do
            user = User.new
            expect(user).to be_invalid
        end
    end

end