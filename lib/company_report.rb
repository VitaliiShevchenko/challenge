# frozen_string_literal: false

require_relative '../lib/user'

# Class which create special data format according the requirement
# @param :company_id, :company_name, :users_emailed, :users_not_emailed, :total_amount
class CompanyReport
  attr_accessor :company, :users_emailed, :users_not_emailed, :total_amount

  def initialize(company)
    @company = company
    @users_emailed = []
    @users_not_emailed = []
    @total_amount = 0
  end

  def special_format
    res = "\tCompany Id: #{@company_id}\n" \
          "\tCompany Name: #{@company_name}\n" \
          "\tUsers Emailed:\n"
    res += users_list(@users_emailed)
    res += "\tUsers Not Emailed:\n"
    res += users_list(@users_not_emailed)
    res + "\t\tTotal amount of top ups for #{@company_name}: #{@total_amount}\n\n"
  end

  # Create special output format for users
  def users_list(obj)
    res = ''
    obj.each do |o|
      res += "\t\t#{o[:user].to_s}\n"\
             "\t\t  Previous Token Balance, #{o[:previous_token]}\n"\
             "\t\t  New Token Balance #{o[:new_token]}\n"
    end

    res
  end

  # Create list of users which will be send email
  def add_user_emailed(user, prev_token_balance, new_token_balance)
    @users_emailed.push({ user: user, prev_token_balance: prev_token_balance, new_token_balance: new_token_balance })
    @total_amount += @company.top_up

    # TODO: create send e-mail
  end

  # Create list of users which will not be send email
  def add_user_not_emailed(user, prev_token_balance, new_token_balance)
    @users_not_emailed.push({ user: user, prev_token_balance: prev_token_balance, new_token_balance: new_token_balance })
    @total_amount += @company.top_up
  end
end
