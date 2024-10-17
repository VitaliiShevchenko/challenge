# frozen_string_literal: false

require_relative '../lib/user'

# Class which create special data format according the requirement
class CompanyReport
  attr_accessor :company_id, :company_name, :users_emailed, :users_not_emailed, :total_amount

  def initialize(company_id, company_name, users_emailed, users_not_emailed, total_amount)
    @company_id = company_id
    @company_name = company_name
    @users_emailed = users_emailed
    @users_not_emailed = users_not_emailed
    @total_amount = total_amount
  end

  def special_format
    res = "\tCompany Id: #{@company_id}\n" \
          "\tCompany Name: #{@company_name}\n" \
          "\tUsers Emailed:\n"
    res += users_list(@users_emailed)
    res += "\tUsers Not Emailed:\n"
    res += users_list(@users_not_emailed)
    res + "\t\tTotal amount of top ups for #{@company_name}: #{@total_amount}"
  end

  # Create special output format for users
  def users_list(obj)
    res = ''
    obj.each do |o|
      res += "\t\t#{o[:user].to_s}"\
             "\t\t  Previous Token Balance, #{o[:previous_token]}"\
             "\t\t  New Token Balance #{o[:new_token]}"
    end

    res
  end
end
