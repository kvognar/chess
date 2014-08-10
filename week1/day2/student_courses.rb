class Student
  attr_reader :courses
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name
    "#{@first_name} #{@last_name}"
  end
  
  def enroll(course)
    unless @courses.include?(course)
      @courses << course
      return true
    end
    false
  end
  
  def course_load
    credits = Hash.new(0)
    @courses.each do |course|
      credits[course.department] += course.credits
    end
    credits
  end
  
end



class Course
  
  attr_reader :students, :course_name, :department, :credits
  
  def initialize(course_name, department, credits)
    @course_name = course_name
    @department = department
    @credits = credits
    @students = []
  end
  
  def add_student(student)
    @students << student if student.enroll(self)
  end
  
end
  
      
    
#test stuff

chemistry_101 = Course.new("Chemistry 101", "Science", 3)
physics_200 = Course.new("Physics 200", "Science", 5)
discovering_yourself = Course.new("Discovering Yourself", "Social Studies", 1)

jimmy = Student.new("Jimmy", "Taylor")
suzy = Student.new("Suzy", "Harbinger")


chemistry_101.add_student(jimmy)
chemistry_101.add_student(suzy)

physics_200.add_student(suzy)
discovering_yourself.add_student(jimmy)

puts jimmy.course_load
puts suzy.course_load
    

