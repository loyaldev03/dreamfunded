namespace :db do

  desc "Upload users profiles"
  task :upload_users => :environment do |t, args|
    require 'csv'
    csv_file = File.read(Rails.root.join("db/investors.csv"), encoding: "iso-8859-1:UTF-8")
    csv = CSV.parse(csv_file, :headers => true)
    csv.each do |row|
      User.create(email: row['Email'], first_name: row['First'], last_name: row['Last'], confirmed: true, authority: 2)
    end
  end

end

