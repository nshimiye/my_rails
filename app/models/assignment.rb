class Assignment
  include Mongoid::Document

  has_many :upload
  belongs_to :lecture

  field :number, :type => Integer
  field :content, :type => String
end
