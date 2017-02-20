module CompaniesHelper
    def nl2br(s)
        s.gsub(/\n/, '<br>')
    end

    def nested_messages(messages)
        messages.map do |message, sub_messages|
            render(message) + content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
        end.join.html_safe
    end

    def raised_amount(company)
        if company.invested_amount == 0
            return 'TBA'
        else
            return number_to_currency company.invested_amount, precision: 0
        end
    end

end
