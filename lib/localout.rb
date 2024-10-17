# frozen_string_literal: true

require_relative '../lib/company_report'

## Class which performs:
# Load (LO)
# Calculation (CAL)
# Output (OUT) necessary data
# @@method: process [work with data of companies and their proper users]
# @@method: write_data(txt_data, pathFile) [ create/save txt file ]
class Localout
  attr_accessor :companies, :users

  def initialize(companies, users)
    @companies = companies
    @users = users
  end

  # Calculation and store the data
  def process
    # outputs = [] # THIS FOR FUTURE CHANGES
    outputs = ''

    @companies.sort_by(&:id).each do |company|
      company_report = CompanyReport.new(company)
      company_users = @users.sort_by(&:last_name).select { |user| user.company_id == company.id && user.active_status }
      company_users.each do |user|
        previous_balance = user.tokens
        new_balance = previous_balance + company.top_up
        if user.email_status && company.email_status
          company_report.add_user_emailed(user, previous_balance, new_balance)
        else
          company_report.add_user_not_emailed(user, previous_balance, new_balance)
        end
      end

      # outputs.push(company_report) # THIS FOR FUTURE CHANGES
      outputs += company_report.special_format
    end

    outputs
  end

  # Output received data to the file
  ## @param [outputs, path_file]
  # [String] :outputs  - text data in ASCII format
  # [] :path_file - includes path and name of the file. @example : "path/to/file/output.txt"
  def write_data(outputs, path_file)
    res = outputs
    # THIS FOR FUTURE CHANGES
    # res = ''
    # outputs.map do |output|
    #   # puts "Output: #{output.company.id}"
    #   company_report = CompanyReport.new(output.company)
    #   puts "report:" + company_report.inspect
    #   res += company_report.special_format
    # end
    puts res
    File.write(path_file, res)
    puts "This report saved to the #{path_file}"
  end
end
