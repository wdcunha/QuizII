require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:idea) { FactoryBot.create(:idea) }

  context  '#new' do

    it 'renders the new template' do
      # GIVEN: Defaults...
      # WHEN: make a get request
      get :new

      # THEN: expect that the new template is rendered
      expect(response).to render_template(:new)
    end

    it 'sets an instance variable with a new idea' do
      get :new

      expect(assigns(:idea)).to(be_a_new(Idea))
    end
  end

  describe '#create' do
    def valid_request
      post :create, params: {
        idea: FactoryBot.attributes_for(:idea)
      }
    end

    context 'with valid parameters' do
      it 'creates a new idea in the database' do
        count_before = Idea.count
        valid_request
        count_after = Idea.count

        expect(count_before).to eq(count_after - 1)
      end

      it 'redirects to the show page of that idea' do
        valid_request
        expect(response).to redirect_to(idea_path(Idea.last))
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:sucess]).to be
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
