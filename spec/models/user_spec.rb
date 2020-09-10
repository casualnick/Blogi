require 'rails_helper'

RSpec.describe 'User', type: :model do
    let(:user) { create(:user) }

    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    it { should validate_length_of :password }

    describe '#email' do

        it 'should validate email format' do
            user.email = 'foobar'
            expect(user).not_to be_valid
        end

    end

    describe 'roles' do
        
        it 'set default standart role' do
            expect(user.role).to eq("standart")
        end

        it 'change to admin role properly' do
            user.admin!
            expect(user.role).to eq("admin")
        end

    end

    describe 'password_confirmation' do

        it 'validate password and password confirmation equality' do
            user.password_confirmation = " not valid "
            expect(user).not_to be_valid
        end
    end

end