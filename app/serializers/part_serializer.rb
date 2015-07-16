class PartSerializer < ActiveModel::Serializer
  attributes :details

  belongs_to :computer

  url :parts
end
