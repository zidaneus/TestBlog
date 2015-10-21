class User < ActiveRecord::Base
	# подумать над тем, стоит ли удалять комментарии и статьи при удалении пользователя
	has_many :comments, dependent: :destroy
	has_many :articles, dependent: :destroy
	#has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	#has_many :followed_users, through: :relationships, source: :followed
	# has_many :reverse_relationships, foreign_key: "followed_id",
	# 								class_name: "Relationship",
	# 								dependent: :destroy
	# has_many :followers, through: :reverse_relationships, source: :follower
	#Перевод в нижний регистр email перед сохранением в базе
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates(:fio, presence: true, length: { maximum: 90 })
	#validates(:dateBirth, presence: true)
	#validates(:sex, presence: true)
	#VALID_EMAIL_REGEX = ^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$
	# дополнительная проверка на корректность email
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }) 
	has_secure_password
	validates :password, length: { minimum: 8 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	# def following?(other_user)
	# 	relationships.find_by(followed_id: other_user.id)
	# end

	# def follow!(other_user)
	# 	relationships.create!(followed_id: other_user.id)
	# end

	# def unfollow!(other_user)
	# 	relationships.find_by(followed_id: other_user.id).destroy!
	# end

	# def feed
	# 	Comment.from_users_followed_by(self)
	# end

	private
	
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
