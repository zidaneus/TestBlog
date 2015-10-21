class Comment < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :text, presence: true, length: { maximum: 500 }
	belongs_to :article
	belongs_to :user

	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships
							WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
			user_id: user.id)
	end
end
