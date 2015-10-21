class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	default_scope -> { order('updated_at DESC') }
	validates :user_id, presence: true
	validates :title, presence: true, length: { minimum: 5 }
	validates :text, presence: true, length: { minimum: 10 }
end
