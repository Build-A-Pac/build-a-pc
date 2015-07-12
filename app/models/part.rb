class Part < ActiveRecord::Base
  has_many :computer_parts
  has_many :computers, through: :parts
end
