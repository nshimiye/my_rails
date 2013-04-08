class Upload
  include Mongoid::Document

  embedded_in :assignment
  belongs_to :user

  field :solution, :type => String
end
