namespace :import do
	desc "Importing courses from CSV file"
	task :get_courses => :environment do
		require 'csv'
		csv_file = 'courses.csv'
		puts "starting to read CSV"

		CSV.foreach(csv_file, :headers => true) do |row|
			for i in 0..row.length-1
				if row[i] != nil then
					row[i].strip
				end
			end
			course = Course.create(:CallNumber => row[0], :CourseTitle => row[1], :StartTime => row[2], :EndTime => row[3], :MeetsOn => row[4], :Building => row[5], :Room => row[6], :InstructorName => row[7])
      course.save
    end
		puts "done reading CSV"
	end
end
