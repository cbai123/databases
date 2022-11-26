require 'cohort_repository'
require 'cohort'
require 'student'

def reset_cohorts_table
  seed_sql = File.read('spec/seeds_cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

RSpec.describe CohortRepository do
  before(:each) do 
    reset_cohorts_table
  end

  # 1
  it "Get all cohorts" do
    repo = CohortRepository.new

    cohorts = repo.all

    expect(cohorts.length).to eq 2

    expect(cohorts[0].id).to eq 1
    expect(cohorts[0].start_date).to eq '2022-01-10'
    expect(cohorts[0].cohort_name).to eq 'January 2022'

    expect(cohorts[1].id).to eq 2
    expect(cohorts[1].start_date).to eq '2022-02-10'
    expect(cohorts[1].cohort_name).to eq 'February 2022'
  end
  # 2
  it "Get a single cohort" do
    repo = CohortRepository.new

    cohort = repo.find(1)

    expect(cohort.id).to eq 1
    expect(cohort.cohort_name).to eq 'January 2022'
    expect(cohort.start_date).to eq '2022-01-10'
  end
  # Add more examples for each method

  # 3
  it "Get a cohort with all its students" do
    repo = CohortRepository.new

    cohort = repo.find_with_students(1)

    expect(cohort.id).to eq 1
    expect(cohort.cohort_name).to eq 'January 2022'
    expect(cohort.students.length).to eq 3
    expect(cohort.students.first.name).to eq 'David'
    expect(cohort.students.last.id).to eq 5
    expect(cohort.students.last.name).to eq 'Pat'
  end
end