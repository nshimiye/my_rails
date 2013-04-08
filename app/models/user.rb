class User
  include Mongoid::Document

  belongs_to :course
  has_many :upload

  field :field_name, :type => String
  field :last_name, :type => String
  field :email, :type => String

end
