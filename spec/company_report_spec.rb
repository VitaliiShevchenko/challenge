# frozen_string_literal: true

require 'rspec'
require_relative '../lib/company_report'
require_relative '../lib/user'
require_relative '../lib/company'

RSpec.describe 'CompanyReport' do
  let(:user1) do
    User.new(
      {		'id' => 1,
         'first_name' => 'Tanya',
         'last_name' => 'Nichols',
         'email' => 'tanya.nichols@test.com',
         'company_id' => 2,
         'email_status' => true,
         'active_status' => false,
         'tokens' => 23 }
    )
  end
  let(:user2) do
    User.new(
      {		'id' => 2,
         'first_name' => 'John',
         'last_name' => 'Conor',
         'email' => 'john.conor@test.com',
         'company_id' => 2,
         'email_status' => true,
         'active_status' => false,
         'tokens' => 70 }
    )
  end
  let(:company1) { Company.new('id' => 1, 'name' => 'No matter Company', 'top_up' => '100', 'email_status' => true) }
  let(:users_emailed) do
    [{ user: user1, prev_token_balance: 23, new_token_balance: 123 },
     { user: user2, prev_token_balance: 70, new_token_balance: 170 }]
  end
  let(:users_not_emailed) { [] }
  let(:total_amount) { 200 }
  let(:company_report) { CompanyReport.new(company1) }

  describe '#initialize' do
    it 'initializes with correct attributes' do
      users_emailed.map do |item|
        company_report.add_user_emailed(item[:user], item[:prev_token_balance].to_i, item[:new_token_balance].to_i)
      end
      users_not_emailed.map do |item|
        company_report.add_user_emailed(item[:user], item[:prev_token_balance].to_i, item[:new_token_balance].to_i)
      end
      expect(company_report.company.id).to eq(1)
      expect(company_report.company.name).to eq('No matter Company')
      expect(company_report.users_emailed).to eq(users_emailed)
      expect(company_report.users_not_emailed).to eq(users_not_emailed)
      expect(company_report.total_amount).to eq(total_amount)
    end
  end

  describe '#special_format' do
    it 'returns a correctly formatted report' do
      users_emailed.map do |item|
        company_report.add_user_emailed(item[:user], item[:prev_token_balance], item[:new_token_balance])
      end
      users_not_emailed.map do |item|
        company_report.add_user_emailed(item[:user], item[:prev_token_balance], item[:new_token_balance])
      end
      expect(company_report.special_format).to include('Nichols, Tanya, tanya.nichols@test.com')
      expect(company_report.special_format).to include('Previous Token Balance, 23')
      expect(company_report.special_format).to include('New Token Balance 123')
      expect(company_report.special_format).to include('Previous Token Balance, 70')
      expect(company_report.special_format).to include('New Token Balance 170')
      expect(company_report.special_format).to include('Total amount of top ups for No matter Company: 200')
    end
  end
end
