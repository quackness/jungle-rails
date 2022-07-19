require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    before do
      @user = User.new(:firstname => "John",
      :lastname => "Smith",
      :email => "test@gmail.com",
      :password => "test",
      :password_confirmation => "test")
      @user.save
      pp @user
    end

    it "should require a firstname, lastname, email" do
      expect(@user.firstname).to_not eq("")
    end

    it "should require a firstname, lastname, email" do
      expect(@user.lastname).to_not eq("")
    end

    it "should require email" do
      expect(@user.email).to_not eq("")
    end

    it "should not create a new user if password confirmation is empty" do
      no_conformation_password_user = User.new(:firstname => "Karolina", :lastname => "Test", :password => "secret", :password_confirmation => nil)
      expect(no_conformation_password_user).to_not (be_valid)
    end

    it "should not create a user if the password does not match with password confirmation" do
      no_match_password_user = User.new(:firstname => "Karolina", :lastname => "Test", :password => "secret", :password_confirmation => "123")
      expect(no_match_password_user).to_not (be_valid)
    end

    it "should not save if the email already exists within the database" do
      user_original = User.create(:firstname => "Karolina", :lastname => "Redden", :email => "testy@gmail.com", :password => "secret")
      user_with_duplicate_email = User.create(:firstname => "Jakub", :lastname => "Redden", :email => "TESTy@gmail.com", :password => "secret")
      expect(user_with_duplicate_email).not_to be_valid
      # pp user_with_duplicate_email
      # # expect(user_with_duplicate_email.email).to eq(nil)
      # # user_with_duplicate_email.save! 
      # # expect(user_with_duplicate_email.email).to eq(nil)
      # expect(user_with_duplicate_email).to eq(nil)
    # @user1 = User.create({ firstname: 'Bob', lastname:"Smith", email: 'abc@gmail.com', password: '123'})
    # @user2 = User.create({ firstname: 'Robert', lastname: "Test", email: 'abc@gmail.com', password: '123'})
    # expect(@user2).not_to be_valid
    end

    it "should allow the user to be created with a password below 5 characters" do
      user_min_characters_password = User.new(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "sec", :password_confirmation => "sec")
      # expect (user_min_characters_password).to_not (be_valid)
      expect(user_min_characters_password).to_not (be_valid)
    end

    describe '.authenticate_with_credentials' do
      it 'should not authenticate when the email is not in database' do
        user = User.create(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "testy", :password_confirmation => "testy")
        params = { email: "another@gmail.com", password: "testy"}
        user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(user).to be_nil
      end

      it "should not authenticate when the pasword is wrong" do
        user = User.create(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "testy", :password_confirmation => "testy")
         params = { email: "another@gmail.com", password: "hello"}
         user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(user).to be_nil
      end

      it "should return user with appropriate credentials" do
        user = User.create(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "testy", :password_confirmation => "testy")
        params = { email: "email@gmail.com", password: "testy"}
        user = User.authenticate_with_credentials(params[:email], params[:password])
        expect(user).to be_present
      end

      it "should auth if there are whitespaces around email" do
        user = User.create(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "testy", :password_confirmation => "testy")
        params = { email: " email@gmail.com", password: "testy" }
        find_user = User.find_by(email: "email@gmail.com")
        user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(find_user).to eq user
      end

      it "should auth if cases are wrong " do
        user = User.create(:firstname => "Karolina", :lastname => "Test", :email => "email@gmail.com", :password => "testy", :password_confirmation => "testy")
        params = { email: " Email@Gmail.com", password: "testy" }
        find_user = User.find_by(email: "email@gmail.com")
        user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(find_user).to eq user
      end

    ends
  end
end
