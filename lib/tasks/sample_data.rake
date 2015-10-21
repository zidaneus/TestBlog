namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do
		article = Article.create!(title: "Test Article",
					text: "Мноооого текста",
					user_id: 2)
		45.times do |n|
			title = Faker::Name.name
			text = Faker::Lorem.sentence(5)
			user_id = "#{n+1}"
			Article.create!(title: title,
						text: text,
						user_id: user_id)
		end

		# admin = User.create!(fio: "Test 4 User",
		# 			email: "examples4@railstutorial.org",
		# 			password: "foobar12",
		# 			password_confirmation: "foobar12",
		# 			admin: true)
		# 15.times do |n|
		# 	fio = Faker::Name.name
		# 	email = "examples4-#{n+1}@railstutorial.org"
		# 	password = "password"
		# 	User.create!(fio: fio,
		# 				email: email,
		# 				password: password,
		# 				password_confirmation: password)
		# end

		# users = User.limit(6)
		# 50.times do
		# 	content = Faker::Lorem.sentence(5)
		# 	users.each { |user| user.comments.create!(text: content) }
		# end
	end
end