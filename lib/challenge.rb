# frozen_string_literal: true

require_relative '../lib/company'
require_relative '../lib/user'
require 'json'

# The main Class which performs all processes of the task according to certain algorithm
class Challenge
  attr_reader :companies, :users

  # load data from needy files
  def initialize
    company_path = 'data/input/companies.json'
    user_path = 'data/input/users.json'

    @companies = Company.loader(company_path)
    @users = User.loader(user_path)
  end

  def run
    puts 'Welcome to Challenge Game'
  end

end

# To run the challenge
if __FILE__ == $PROGRAM_NAME
  challenge = Challenge.new
  challenge.run
end
