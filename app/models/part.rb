class Part < ActiveRecord::Base
  serialize :details, JSON
  has_many :computer_parts
  has_many :computers, through: :parts
end
