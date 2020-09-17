require 'rails_helper'

RSpec.describe "Posts", type: :request do
    let(:user) { create(:user) }
    let!(:posts) { create_list(:post, 10, user_id: user.id) }
    let(:post_id) { posts.first.id }
    let(:user_id) { user.id }

    describe "GET /users/:user_id/posts" do
        before { get "/users/#{user_id}/posts" }

        context 'user exist' do
            
            it 'return all users' do
                expect(json.size).to eq(10)
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end

        end
        
        context 'user does not exist' do
            let(:user_id) { 0 }

            it 'return failure message' do
                expect(json['errors']).to include("Couldn't find User")
            end

            it 'have http status 404' do
                expect(response).to have_http_status(404)
            end

        end

    end

    describe "POST /users/:user_id/posts" do
        let(:valid_params) { { title: 'It is valid title', content: 'I like Rails very much' } }
    
        context 'valid params' do
            before { post "/users/#{user_id}/posts", params: valid_params }

            it 'create post properly' do
                expect(response.body).to include('It is valid title')
            end

            it 'have http status 201' do
                expect(response).to have_http_status(201)
            end

        end
           
            
            context 'invalid params' do
                before { post "/users/#{user_id}/posts", params: { } }

                it 'return failure message' do
                    expect(response.body).to include("Title can't be blank")
                end

                it 'have http status 422' do
                    expect(response).to have_http_status(422)
                end

            end

    end

    describe "PUT /users/:user_id/posts/:post_id" do
        let(:valid_params) { { title: 'It is another valid title' } }

        context 'valid params' do
            before { put "/users/#{user_id}/posts/#{post_id}", params: valid_params }

            it 'update post properly' do
                updated_post = Post.find(post_id)
                expect(updated_post.title).to match("It is another valid title")
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end

        end

        context 'invalid params' do
            before { put "/users/#{user_id}/posts/#{post_id}", params: { } }

            it 'return failure message' do
                expect(response.body).to include("Title can't be blank")
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end

        end

    end

    describe "DELETE /users/:user_id/posts/:post_id" do
        before { delete "/users/#{user_id}/posts/#{post_id}" }

        it 'have http status 204' do
            expect(response).to have_http_status(204)
        end
    end

end
