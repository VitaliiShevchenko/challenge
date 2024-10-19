# frozen_string_literal: false

require_relative '../lib/user'

# Class which create special data format according the requirement
# @param :company_id 1, :company_name 'Blue Cat Inc.', :users_emailed [], :users_not_emailed [], :total_amount 142
class CompanyReport
  attr_accessor :company, :users_emailed, :users_not_emailed, :total_amount

  def initialize(company, users_emailed = [], users_not_emailed = [], total_amount = 0)
    @company           = company
    @users_emailed     = users_emailed
    @users_not_emailed = users_not_emailed
    @total_amount      = total_amount
  end

  # Convert `instance` of the CompanyReport class to the `text block` in the defined style
  def special_text_style
    "\tCompany Id: #{@company.id}\n"           \
    "\tCompany Name: #{@company.name}\n"       \
    "\tUsers Emailed:\n"                         \
    "#{text_users_list(@users_emailed)}"       \
    "\tUsers Not Emailed:\n"                     \
    "#{text_users_list(@users_not_emailed)}"   \
    "\t\tTotal amount of top ups for #{@company.name}: #{@total_amount}\n\n"
  end

  # Create users list from the array of [Hash] with the key [{:user, :prev_token_balance, :new_token_balance}] in the text format
  def text_users_list(obj)
    res = ''
    obj.each do |o|
      res << "\t\t#{o[:user].to_s}\n"\
             "\t\t  Previous Token Balance, #{o[:prev_token_balance]}\n"\
             "\t\t  New Token Balance #{o[:new_token_balance]}\n"
    end

    res
  end

  # Create list of users which will be send email (Users Emailed:)
  def add_user_emailed(user, prev_token_balance, new_token_balance)
    @users_emailed.push({ user: user,
                          prev_token_balance: prev_token_balance,
                          new_token_balance: new_token_balance })
    @total_amount += @company.top_up.to_i
  end

  # Create list of users which will not be send email (Users Not Emailed:)
  def add_user_not_emailed(user, prev_token_balance, new_token_balance)
    @users_not_emailed.push({ user: user,
                              prev_token_balance: prev_token_balance,
                              new_token_balance: new_token_balance })
    @total_amount += @company.top_up.to_i
  end

  # Create function fo added financial information to the CompanyReport by quarter
  def add_financial_quarter(financial)
    @financial_quarter = financial
  end

  # create financial report for year
  def financial_report
    profit_quarter = @financial_quarter[:revenue].each { |k| @financial_quarter[:revenue][x].to_i - @financial_quarter[:expenses][k].to_i }.sum
    revenue  = @financial_quarter[:revenue].sum
    expenses = @financial_quarter[:expenses].sum
    profit   = revenue - expenses
    "Financial Report for #{@company[:name]}\n"            \
    "_____________________#{'_' * @company[:name].size}\n" \
    "Total Revenue: #{revenue}\n"                          \
    "Total Expenses: #{expenses}\n"                        \
    "Total Profit: #{profit}\n"                            \
    "Highest Profit Quarter: #{profit_quarter.max}\n"
  end
end
