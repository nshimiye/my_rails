class Upload
  include Mongoid::Document

  embedded_in :assignment

  field :solution, :type => String
end
