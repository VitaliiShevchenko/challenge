# frozen_string_literal: true

class User
  attr_accessor :id, :first_name, :last_name, :email, :company_id, :email_status, :active_status, :tokens

  def initialize(attributes)
    @id = attributes["id"]
    @first_name = attributes["first_name"]
    @last_name = attributes["last_name"]
    @email = attributes["email"]
    @company_id = attributes["company_id"]
    @email_status = attributes["email_status"]
    @is_active = attributes["active_status"]
    @token = attributes["tokens"]
  end

  def to_s
    "#{last_name}, #{first_name}, #{email}"
  end
end
