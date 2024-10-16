# frozen_string_literal: true

class Challenge
  attr_reader :companies, :users

  # load data from needy files
  def initialize
    company_path = '../data/input/companies.json'
    user_path = '../data/input/users.json'

    @companies = Company.new(company_path)
    @users = User.new(user_path)
  end

  def run
    puts "Welcome to Challenge Game"
  end
end

# To run the challenge
if __FILE__ == $0
  challenge = Challenge.new
  challenge.run
end