class Lecture
  include Mongoid::Document

  has_many :assignments
  belongs_to :course

  field :number, :type => Integer
  field :content, :type => String
end
