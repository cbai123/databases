require_relative './database_connection'
require_relative './cohort'
require_relative './student'

class CohortRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, cohort_name, start_date FROM cohorts;'
    result_set = DatabaseConnection.exec_params(sql,[])

    cohorts = []
    result_set.each {|result|
      cohort = Cohort.new
      cohort.id = result["id"].to_i
      cohort.cohort_name = result["cohort_name"]
      cohort.start_date = result["start_date"]
      cohorts << cohort
    }
    return cohorts
    # Returns an array of cohort objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, cohort_name, start_date FROM cohorts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)

    cohort = Cohort.new
    cohort.id = result[0]["id"].to_i
    cohort.cohort_name = result[0]["cohort_name"]
    cohort.start_date = result[0]["start_date"]

    return cohort

    # Returns a single cohort object.
  end

  def find_with_students(id)
    # Executes the SQL query:
    sql = 'SELECT cohorts.id, cohorts.cohort_name, cohorts.start_date, students.id AS student_id, students.name FROM cohorts JOIN students ON cohorts.id = students.cohort_id WHERE cohorts.id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql,params)

    cohort = Cohort.new
    cohort.id = result_set[0]["id"].to_i
    cohort.cohort_name = result_set[0]["cohort_name"]
    cohort.start_date = result_set[0]["start_date"]

    result_set.each{ |result|
      student = Student.new
      student.id = result["student_id"].to_i
      student.name = result["name"]

      cohort.students << student
    }

    return cohort
    # returns a cohort object with an array of cohort objects
  end
end