class Course
  include Mongoid::Document

  has_and_belongs_to_many :users
  has_many :lectures
  
  field :CallNumber, type: Integer
  field :CourseTitle, type: String
  field :StartTime, type: String
  field :EndTime, type: String
  field :MeetsOn, type: String
  field :Building, type: String
  field :Room, type: String
  field :InstructorName, type: String
end