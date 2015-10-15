class User < ActiveRecord::Base
	#Перевод в нижний регистр email перед сохранением в базе
	before_save { self.email = email.downcase }
	validates(:fio, presence: true, length: { maximum: 90 })
	#validates(:dateBirth, presence: true)
	#validates(:sex, presence: true)
	#VALID_EMAIL_REGEX = ^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }) 
	has_secure_password
	validates :password, length: { minimum: 8 }
end
