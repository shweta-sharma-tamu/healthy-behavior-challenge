require "rails_helper"

describe User, type: :model do
    describe "validations" do
        it "is invalid without an email" do
            user = User.new(email:nil)
            expect(user).to be_invalid
        end
         it "is invalid without a password" do
                    user = User.new(email:nil)
                    expect(user).to be_invalid
         end
          it "is invalid without a type" do
                     user = User.new(user_type:nil)
                     expect(user).to be_invalid
          end
           it "is invalid without an userid" do
                      user = User.new(userid:nil)
                      expect(user).to be_invalid
           end
    end

end