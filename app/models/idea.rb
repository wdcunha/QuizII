class Idea < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy


  validates :title, presence: true, uniqueness: true

  def upcased_title
    title&.upcase
  end

end
