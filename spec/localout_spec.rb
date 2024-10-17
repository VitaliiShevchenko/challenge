# frozen_string_literal: true

require 'rspec'
require_relative '../lib/localout'
require_relative '../lib/company'
require_relative '../lib/user'
require_relative '../lib/company_report'

RSpec.describe 'Localout' do
  let(:company1) { Company.new('id' => 2, 'name' => 'Blue Cat Inc.', 'top_up' => 71, 'email_status' => 'false') }
  let(:company2) { Company.new('id' => 4, 'name' => 'Gray Cat Inc.', 'top_up' => 111, 'email_status' => 'true') }
  let(:company3) { Company.new('id' => 6, 'name' => 'White Cat Inc.', 'top_up' => 200, 'email_status' => 'true') }
  let(:companies) { [company1, company2] }
  let(:three_companies) { [company1, company2, company3] }
  let(:user1) { User.new({ 'id' => 1, 'first_name' => 'Tanya', 'last_name' => 'Nichols', 'email' => 'tanya.nichols@test.com', 'company_id' => 2, 'email_status' => false, 'active_status' => true,  'tokens' => 23  }) }
  let(:user2) { User.new({ 'id' => 2, 'first_name' => 'Brent', 'last_name' => 'Rodriquez', 'email' => 'brent.rodriquez@test.com', 'company_id' => 4, 'email_status' => false, 'active_status' => true, 'tokens' => 96 }) }
  let(:user3) { User.new({ 'id' => 3, 'first_name' => 'Tanya', 'last_name' => 'Grosu', 'email' => 'tanya.grosu@test.com', 'company_id' => 2, 'email_status' => false, 'active_status' => true,  'tokens' => 46  }) }
  let(:user4) { User.new({ 'id' => 4, 'first_name' => 'Brent', 'last_name' => 'Graves', 'email' => 'brent.graves@test.com', 'company_id' => 4, 'email_status' => false, 'active_status' => true, 'tokens' => 192 }) }

  let(:users) { [user1, user2] }
  let(:localout) { Localout.new(companies, users) }

  let(:four_users) { [user1, user2, user3, user4] }
  let(:localout1) { Localout.new(three_companies, four_users) }

  describe '#process' do
    it 'processes users and generates company reports' do
      reports = localout.process
      reports2 = localout1.process

      expect(reports.size).to eq(2)
      company_report1 = reports.find { |report| report.company.id == company1.id }
      puts company_report1.inspect
      expect(company_report1.users_emailed.size).to eq(0)
      expect(company_report1.users_not_emailed.size).to eq(1) # user_id:1
      expect(company_report1.total_amount).to eq(company1.top_up.to_i)

      company_report2 = reports.find { |report| report.company.id == company2.id }
      expect(company_report2.users_emailed.size).to eq(0)
      expect(company_report2.users_not_emailed.size).to eq(1) # user_id:2
      expect(company_report2.total_amount).to eq(company2.top_up.to_i)

      # reports for three companies
      expect(reports2.size).to eq(3)
      company_report1 = reports2.find { |report| report.company.id == company1.id }
      puts company_report1.inspect
      expect(company_report1.users_emailed.size).to eq(0)
      expect(company_report1.users_not_emailed.size).to eq(2) # user_id:1,3
      expect(company_report1.total_amount).to eq(company1.top_up.to_i * 2)

      company_report2 = reports2.find { |report| report.company.id == company2.id }
      expect(company_report2.users_emailed.size).to eq(0)
      expect(company_report2.users_not_emailed.size).to eq(2) # user_id:2,4
      expect(company_report2.total_amount).to eq(company2.top_up.to_i * 2)

      company_report3 = reports2.find { |report| report.company.id == company3.id }
      expect(company_report3.users_emailed.size).to eq(0)
      expect(company_report3.users_not_emailed.size).to eq(0)
      expect(company_report3.total_amount).to eq(company3.top_up.to_i * 0)
    end
  end

  describe '#write_data' do
    it 'writes data to the output file' do
      outputs = localout.process
      expect { localout.write_data(outputs) }.not_to raise_error
    end
  end
end
