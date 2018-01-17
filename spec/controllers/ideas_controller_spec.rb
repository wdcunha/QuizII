require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  let(:idea) { FactoryBot.create(:idea) }

  describe '#new' do
    context 'without signed in user' do
      it 'redirect the user to sessions#new page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context  'with signed in user' do
      before do
        request.session[:user_id] = user.id
      end

      it 'renders the new template' do

        get :new

        expect(response).to render_template(:new)

      end

      it 'sets an instance variable with a new idea' do
        get :new
        expect(assigns(:idea)).to(be_a_new(Idea))

      end
    end
  end

  describe '#create' do
    def valid_request
      post :create, params: {
        idea: FactoryBot.attributes_for(:idea)
      }
    end

    context 'with user not signed in' do
      it 'redirects to the new session path' do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before do
        request.session[:user_id] = user.id
      end

      context 'with valid parameters' do

        it 'creates a new idea in the database' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count

          expect(count_before).to eq(count_after - 1)
        end

        it 'redirects to the idea\'s page' do
          valid_request
          expect(response).to redirect_to(ideas_path)
        end

        it 'sets a flash message' do
          valid_request
          expect(flash[:success]).to be
        end

        it 'associates the idea with the signed in user' do
          valid_request
          # byebug
          expect(Idea.last.user).to eq(user)
        end
      end

      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            idea: FactoryBot.attributes_for(:idea).merge({title: nil})
          }
        end

        it 'doesn\'t create a idea in the database' do
          count_before = Idea.count
          invalid_request
          count_after = Idea.count

          expect(count_before).to eq(count_after)
        end

        it 'renders the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
