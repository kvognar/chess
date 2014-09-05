var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
};

var cat = new Cat("CatBus", "Miyazaki");
// console.log(cat.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
};

// console.log(cat.cuteStatement());

Cat.prototype.meow = function() {
  return "mew";
};

var betterCat = new Cat("KittenBus", "Hayao");
betterCat.meow = function() {
  return "Next Stop: Castle in the Sky";
};

// console.log(cat.meow());
// console.log(betterCat.meow());


var Student = function(fName, lName) {
  this.fName = fName;
  this.lName = lName;
  this.courses = [];
};

Student.prototype.name = function() {
  return this.fName + " " + this.lName;
};
Student.prototype.enroll = function(course) {
  this.courses.push(course);
  course.students.push(this);
}
Student.prototype.courseLoad = function() {
  var courseLoad = {};
  for (var i = 0; i < this.courses.length; i++) {
    // var dept = this.courses[i].department;
//     courseLoad[dept] = courseLoad[dept] || 0;
    if (courseLoad[this.courses[i].department]){
      courseLoad[this.courses[i].department] += this.courses[i].credits 
    } else {
      courseLoad[this.courses[i].department] = this.courses[i].credits
    }
  }
  return courseLoad;
};

var Course = function(courseName, department, credits){
  this.name = courseName;
  this.department = department;
  this.credits = credits;
  this.students = [];
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};


var student1 = new Student("Bob", "Bobson");
var student2 = new Student("Job", "Jobson");
var student3 = new Student("Lob", "Lobson");
var student4 = new Student("Kob", "Kobson");

var course1 = new Course("batman", "history", 1000);
var course2 = new Course("calc", "math", 1);
var course3 = new Course("combinatorics", "math", 2);

course1.addStudent(student1);
course1.addStudent(student2);
course1.addStudent(student3);

course2.addStudent(student1);
course3.addStudent(student1);

// console.log(student1.courses);
// console.log(student1.coursesLoad);
 console.log(course1.students);
// console.log(course3.students);


