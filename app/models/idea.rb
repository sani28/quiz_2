class Idea < ApplicationRecord

    belongs_to :user  #association with signed in user
    has_many :reviews, dependent: :destroy

end
