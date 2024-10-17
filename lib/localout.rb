# frozen_string_literal: true

## Class which performs:
# Load (LO)
# Calculation (CAL)
# Output (OUT) necessary data
class Localout
  def initialize(companies, users)
    @companies = companies
    @users = users
  end

  # Calculation and store the data
  def process
    outputs = []

    @companies.sort(&:id).each do |company|
      company_report = CompanyReport.new(company)
      company_users = @users.select { |user| user.company_id == company.id && user.active_status }

      company_users.each do |user|
        previous_balance = user.tokens
        new_balance = previous_balance + company.top_up

        if user.email_status && company.email_status != new_balance.email_status
          company_report.add_user_emailed(user, previous_balance, new_balance)
        else
          company_report.add_user_not_emailed(user, previous_balance, new_balance) unless user.email_status
        end
      end

      outputs << company_report
    end
    outputs
  end

  # Output received data to the file
  def write_data(outputs)
    res = outputs.map do |output|

    end

  end
end
