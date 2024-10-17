# frozen_string_literal: true

require_relative '../lib/company'
require_relative '../lib/user'
require_relative '../lib/localout'
require 'json'

# The main Class which performs all processes of the task according to certain algorithm
class Challenge
  COMPANIES_PATH = 'data/input/companies.json'
  USERS_PATH = 'data/input/users.json'
  OUTPUT_PATH = 'data/output/'
  NAME_OUTPUT_FILE = 'output.txt'
  attr_reader :companies, :users

  # load data from needy files
  def initialize
    @companies = Company.loader(COMPANIES_PATH)
    @users = User.loader(USERS_PATH)
  end

  def run
    builder = Localout.new(@companies, @users)
    output_data = builder.process
    builder.write_data(output_data, "#{OUTPUT_PATH}#{NAME_OUTPUT_FILE}")
  end

end

# To run the challenge
if __FILE__ == $PROGRAM_NAME
  challenge = Challenge.new
  challenge.run
end
