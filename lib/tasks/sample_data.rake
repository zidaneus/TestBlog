namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(fio: "Test 3 User",
					email: "examples3@railstutorial.org",
					password: "foobar12",
					password_confirmation: "foobar12",
					admin: true)
		15.times do |n|
			fio = Faker::Name.name
			email = "examples2-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(fio: fio,
						email: email,
						password: password,
						password_confirmation: password)
		end
	end
end