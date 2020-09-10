require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:users) { create_list(:user, 10) }
    let(:admin) { users.second.admin! }
    let(:user) { users.first }
    let(:user_id) { user.id }

    describe "Get /users" do
        

        context 'when user is not an admin' do
            before do
                allow(:controller).to receive(:current_user).and_return(user)
                get "/users"
            end
            
            it 'have http stauts 403' do
                expect(response).to have_http_status(403)
            end

            it 'return failure message' do
                expect(response.body).to match(/Have to be admin to access that action/)
            end

        end

        context 'when user is an admin' do
            before do
            allow(:controller).to receive(:current_user).and_return(admin)
            get "/users"
            end

            it 'return all users' do
                expect(response.body.users.size).to eq(10) 
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end
        end

    end

    describe 'POST /users' do
        let(:valid_params) { { email: 'valid@email.com', password: '12345678', password_confirmation: '12345678' } }

        context 'params are valid' do
            before { post "/users", params: valid_params }

            it 'create user successfully' do
                expect(response.body).to include(user.email)
            end

            it 'have http status 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'params are invalid' do
            before { post "/users", params: { } }

            it 'return failure message' do
                expect(response.body).to include("Email can't be blank")
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe "PUT /users/:user_id" do
        let(:valid_params) { { email: 'another@email.com'} }

        context 'params are valid' do
            before { put "/users#{user_id}", params: valid_params }

            it 'update user properly' do
                updated_user = User.find(user_id)
                expect(updated_user.email).to eq("another@email.com")
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'params are invalid' do
            before { put "/users#{user_id}", params: { } }

            it 'return failure message' do
                expect(response.body).to include("Email can't be blank")
            end
        end
    end

    describe "DELETE /users/:user_id" do
        before { delete "/users#{user_id}" }

        it 'have http status 204' do
            expect(response).to have_http_status(204)
        end
    end

end
