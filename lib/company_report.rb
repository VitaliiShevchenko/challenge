# frozen_string_literal: true

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
    "	Company Id: 2
	Company Name: Yellow Mouse Inc.
	Users Emailed:
		Boberson, Bob, bob.boberson@test.com
		  Previous Token Balance, 23
		  New Token Balance 60
		Boberson, John, john.boberson@test.com
		  Previous Token Balance, 15
		  New Token Balance 52
		Simpson, Edgar, edgar.simpson@notreal.com
		  Previous Token Balance, 67
		  New Token Balance 104
	Users Not Emailed:
		Gordon, Sara, sara.gordon@test.com
		  Previous Token Balance, 22
		  New Token Balance 59
		Weaver, Sebastian, sebastian.weaver@fake.com
		  Previous Token Balance, 66
		  New Token Balance 103
		Total amount of top ups for Yellow Mouse Inc.: 185"
  end
end
