# frozen_string_literal: true

require_relative '../lib/company_report'

## Class which performs:
# Logic(LO)
# Calculation (CAL)
# Output (OUT) necessary data
# @@method: process [work with data of companies and their proper users]
# @@method: write_data(txt_data, pathFile) [ create/save txt file ]
class Localout
  attr_accessor :companies, :users

  def initialize(companies, users)
    @companies = companies
    @users     = users
  end

  # Calculation, create and output the list of records
  def process
    outputs = []
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

      outputs.push(company_report)
    end

    outputs
  end

  # Output received data to the file
  ## @param [outputs, path_file]
  # [String] :outputs  - text data in ASCII format
  # [] :path_file - includes path and name of the file. @example : "path/to/file/output.txt"
  def write_data(outputs, path_file)
    puts outputs
    File.write(path_file, outputs)
    puts "This report saved to the #{path_file}"
  end

  # convert Array Hashes of CompanyReport to the full list of blocks in special txt format
  def convert_to_txt(arr)
    res = ''
    arr.map do |item|
      res += CompanyReport.new(item.company,
                               item.users_emailed,
                               item.users_not_emailed,
                               item.total_amount)
                          .special_text_style
    end

    res
  end
end
