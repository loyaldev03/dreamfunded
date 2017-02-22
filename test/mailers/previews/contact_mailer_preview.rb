# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

	def personal_hello
		byebug
		user = User.first
		# ContactMailer.personal_hello(user)
	end
end
