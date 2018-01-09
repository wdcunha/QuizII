require 'rails_helper'

RSpec.describe Idea, type: :model do

  describe 'validations' do

    it 'requires a title' do
      # GIVEN: new Idea record
      i = Idea.new

      # WHEN: we invoke validations
      i.valid?

      # THEN: we get an error on the title field
      expect(i.errors.messages).to have_key(:title)
    end

    it 'requires a unique title' do
      # GIVEN: created campaign with a title and a second one with the same
      #        title
      i = Idea.create!({ title: 'Something to Test',
                             description: 'Here some text',
                            })
      i1 = Idea.new({ title: 'Something to Test' })

      # WHEN: We invoke validations
      i1.valid?

      # THEN: we get an error message on title
      expect(i1.errors.messages).to have_key(:title)
    end
  end

  describe '.upcased_title' do
    it 'returns an upcased version of the title' do
      # GIVEN: new idea with title
      i = Idea.new({ title: 'something to test' })

      # WHEN: it calls the `upcased_title` method
      result = i.upcased_title

      # THEN: It gets an upcased version of the upcased_title
      expect(result).to eq('SOMETHING TO TEST')
    end
  end


end
