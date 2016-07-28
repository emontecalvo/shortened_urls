class Course < ActiveRecord::Base

  has_many :enrollments,
  primary_key: :id,
  foreign_key: :course_id,
  class_name: "Enrollment"

  has_many :students,
  through: :enrollments,
  source: :student


end
