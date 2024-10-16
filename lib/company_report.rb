# frozen_string_literal: false

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
    res = "\tCompany Id: #{@company_id}\n" +
          "\tCompany Name: #{@company_name}\n" +
          "\tUsers Emailed:\n"
    @users_emailed.each do |user|
      res += "\t\t#{user.to_s}" +
             "\t\t  Previous Token Balance, #{user.previous_token}" +
             "\t\t  New Token Balance #{user.new_token}"
    end
    res += "\tUsers Not Emailed:\n"
    @users_not_emailed.each do |user|
      res += "\t\t#{user.to_s}" +
             "\t\t  Previous Token Balance, #{user.previous_token}" +
             "\t\t  New Token Balance #{user.new_token}"
    end
    res += "\t\tTotal amount of top ups for #{@company_name}: #{@total_amount}"
  end
end
