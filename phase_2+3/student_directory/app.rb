require_relative 'lib/cohort_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new

cohort = repo.find_with_students(2)

puts "#{cohort.cohort_name}"
cohort.students.each{ |student|
  puts "#{student.name}"
}