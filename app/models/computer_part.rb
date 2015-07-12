class ComputerPart < ActiveRecord::Base
  belongs_to :computer
  belongs_to :part
end
