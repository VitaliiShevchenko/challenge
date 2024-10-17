# frozen_string_literal: true

require 'rspec'
require_relative '../lib/company_report'
require_relative '../lib/user'

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
  let(:users_emailed) do
    [{ user: user1, previous_token: 23, new_token: 123 },
     { user: user2, previous_token: 70, new_token: 170 }]
  end
  let(:users_not_emailed) { [] }
  let(:total_amount) { 200 }
  let(:company_report) { CompanyReport.new(1, 'No matter Company', users_emailed, users_not_emailed, total_amount) }

  describe '#initialize' do
    it 'initializes with correct attributes' do
      expect(company_report.company_id).to eq(1)
      expect(company_report.company_name).to eq('No matter Company')
      expect(company_report.users_emailed).to eq(users_emailed)
      expect(company_report.users_not_emailed).to eq(users_not_emailed)
      expect(company_report.total_amount).to eq(total_amount)
    end
  end

  describe '#special_format' do
    it 'returns a correctly formatted report' do
      expect(company_report.special_format).to include('Nichols, Tanya, tanya.nichols@test.com')
      expect(company_report.special_format).to include('Previous Token Balance, 23')
      expect(company_report.special_format).to include('New Token Balance 123')
      expect(company_report.special_format).to include('Previous Token Balance, 70')
      expect(company_report.special_format).to include('New Token Balance 170')
      expect(company_report.special_format).to include('Total amount of top ups for No matter Company: 200')
    end
  end
end
