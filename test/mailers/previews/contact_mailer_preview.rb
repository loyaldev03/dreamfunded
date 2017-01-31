# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

	def personal_hello
		user = User.first
		ContactMailer.personal_hello_to_inverstors(user)
	end
end
