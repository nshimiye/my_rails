class Course
  include Mongoid::Document

  has_many :user
  has_many :lecture

  field :name, :type => String
  field :number, :type => String

end
