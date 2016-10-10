class ImportUserCSV
    include CSVImporter

    model Invite # an active record like model

    column :email, as: [/e.?mail/i, "Email", "Emails"], to: ->(email) { email.downcase }
    column :name, as: [ /first.?name/i, /pr(é|e)nom/i, "first name", "last name", "FirstName", "LastName", "first_name", "last_name", "Name", "name" ], to: ->(name) { name.downcase }


    identifier :email # will update_or_create via :email
    when_invalid :skip # or :abort
end



