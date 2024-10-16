# frozen_string_literal: true

class CompanyReport
  attr_accessor :company_id, :company_name, :users_emailed, :users_not_emailed, :total_amount

  def initialize(company_id, company_name, users_emailed, users_not_emailed, total_amount)
    @company_id = company_id
    @company_name = company_name
    @users_emailed = users_emailed
    @users_not_emailed = users_not_emailed
    @total_amount = total_amount
  end
end
