class Computer < ActiveRecord::Base
  belongs_to :user
  has_many :computer_parts
  has_many :parts, through: :computer_parts
  belongs_to :build_type
end
