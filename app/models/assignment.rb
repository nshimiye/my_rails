class Assignment
  include Mongoid::Document

  embeds_many :uploads
  belongs_to :lecture

  field :number, :type => Integer
  field :content, :type => String
end
