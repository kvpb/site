class Article < ApplicationRecord
    include Visible

    has_many :comments, dependent: :destroy
    
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 4 } # average length of a word in the english language: 4.7; length of the shortest sentence consisting of a word among good and the bad with a period: 4;
end
