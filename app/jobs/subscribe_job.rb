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
          CSV.foreach(file.path, headers: false, :encoding => 'ISO-8859-1') do |row|
            begin
              invites << Invite.create!( name: row[0], email: row[1], user_id: user.id)
            rescue ActiveRecord::RecordInvalid => invalid
              puts invalid.record.errors
            end

          end # end CSV.foreach
          invites.each do |invite|
            ContactMailer.delay.invite_to_sign_up(invite.email, invite.name) if email_template == 'from_Manny'
            ContactMailer.delay.csv_invite(invite, user) if email_template == 'from_Startup'
          end
          invites = []
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def emails_from_member(file, user, member )
    ActiveRecord::Base.connection_pool.with_connection do
      invites = []
      begin
          CSV.foreach(file.path, headers: false, :encoding => 'ISO-8859-1') do |row|
            begin
              invites << Invite.create!( name: row[0], email: row[1], user_id: user.id)
            rescue ActiveRecord::RecordInvalid => invalid
              puts invalid.record.errors
            end

          end # end CSV.foreach
          invites.each do |invite|
            ContactMailer.delay.invite_from_member(invite.email, invite.name, member)
          end
          invites = []
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def csv_advisors_emails(file, advisor)
    ActiveRecord::Base.connection_pool.with_connection do
      invites = []
      begin
          CSV.foreach(file.path, headers: false, :encoding => 'ISO-8859-1') do |row|
            begin
              p row[1]
              invites << Invite.create!( name: row[0], email: row[1] )
            rescue ActiveRecord::RecordInvalid => invalid
              puts invalid.record.errors
            end

          end # end CSV.foreach
          invites.each do |invite|
            ContactMailer.delay.send_from_advisor(invite, advisor)
          end
          invites = []
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def csv_send_checked_emails(file, invitee_name, company_name)
    ActiveRecord::Base.connection_pool.with_connection do
      invites = []
      begin
          CSV.foreach(file.path, headers: false, :encoding => 'ISO-8859-1') do |row|
            begin
              invites << Invite.create!(name: row[0], email: row[1])
            rescue ActiveRecord::RecordInvalid => invalid
              puts invalid.record.errors
            end

          end # end CSV.foreach
          invites.each do |invite|
            ContactMailer.delay.csv_invite(invite, invitee_name, company_name)
          end
          invites = []
      rescue Exception => e
        SuckerPunch.logger.error("subscribe failed: due to #{e.message}")
        raise e
      end
    end
  end

  def csv_importer_gem(invite,user, email_template)
      ActiveRecord::Base.connection_pool.with_connection do

        paperclip_content =   Paperclip.io_adapters.for(invite.file).read.delete('"')
        import = ImportUserCSV.new(content: paperclip_content) do
        token = SecureRandom.uuid.gsub(/\-/, '').first(10)

          after_save do |invite|
              invite.token = token
              invite.save
          end
        end

        p import.report.message
        import.run!
        p  "Header is valid: #{import.valid_header?}"  # => true
        p "Success #{import.report.success?}" # => false
        p import.report.status # => :aborted
        p import.report.message # => "Import aborted"

        last_token = Invite.last.token
        new_invites = Invite.where(token: last_token)
        new_invites.update_all(user_id: user.id)

        new_invites.each do |invite|
          ContactMailer.delay.invite_to_sign_up(invite.email, invite.name) if email_template == 'from_Manny'
          ContactMailer.delay.csv_invite(invite, user) if email_template == 'from_Startup'
        end

      end

  end

end
