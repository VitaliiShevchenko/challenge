# frozen_string_literal: true

class Company
  attr_accessor  :id, :name, :top_up, :email_status

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @top_up = attributes['top_up']
    @email_status = attributes['email_status']
  end
end
