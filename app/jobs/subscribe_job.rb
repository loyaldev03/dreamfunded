require 'csv'
class SubscribeJob
  include SuckerPunch::Job

  def perform(id)
    ActiveRecord::Base.connection_pool.with_connection do
      user = Guest.find(id)
      mailchimp_list_id = Rails.application.secrets.mailchimp_list_id
      email = user.email

      begin
        g = Gibbon::API.new
        g.lists.subscribe({ id: mailchimp_list_id, email:  {email: email}})

        #SubscribeMailer.confirmation_email(user).deliver
      rescue Gibbon::MailChimpError => mce
        SuckerPunch.logger.error("subscribe failed: due to #{mce.message}")
        raise mce
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def mailchimp_subscribe(id)
    ActiveRecord::Base.connection_pool.with_connection do
      user = Guest.find(id)
      mailchimp_list_id = Rails.application.secrets.mailchimp_crowdfunding_list
      email = user.email

      begin
        g = Gibbon::API.new
        g.lists.subscribe({ id: mailchimp_list_id, email:  {email: email}})

        #SubscribeMailer.confirmation_email(user).deliver
      rescue Gibbon::MailChimpError => mce
        SuckerPunch.logger.error("subscribe failed: due to #{mce.message}")
        raise mce
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def csv_save_emails(file, user, email_template)
    ActiveRecord::Base.connection_pool.with_connection do
      invites = []

      begin
          CSV.foreach(file.path, headers: true) do |row|

            invites << Invite.create!(email: row['Email'], name: row['First Name'], user_id: user.id)

          end # end CSV.foreach
          invites.each do |invite|
            ContactMailer.delay.invite_to_sign_up(invite.email, invite.name) if email_template == 'from_Manny'
            ContactMailer.delay.csv_invite(invite, user) if email_template == 'from_Startup'
          end

      rescue Gibbon::MailChimpError => mce
        SuckerPunch.logger.error("subscribe failed: due to #{mce.message}")
        raise mce

      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end

    end
  end

end
