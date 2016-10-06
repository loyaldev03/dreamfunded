class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :company

    has_ancestry

    def comment_owner
        if comment_belongs_to_company_owner?
            self.company.name + "Team"
        end
    end

    def comment_belongs_to_company_owner?
        self.user.company == self.user.company
    end

end
