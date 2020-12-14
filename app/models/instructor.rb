class Instructor

    attr_accessor :instructor_name

    @@all = []

    def initialize (instructor_name)
        @instructor_name = instructor_name
        @@all << self
    end

    def self.all
        @@all
    end

    def all_tests
        BoatingTest.all.select{|test| test.instuctor = self}
    end

    def all_students
        # 1. get all the instructor's tests
        # 2. from the instructor's tests, get all the students
        self.all_tests.map{|test| test.student = self}
    end

    def all_passed_tests
        self.all_tests.select{|test| test.test_status == "passed"}
    end

    def passed_students
        # self.all_tests 
        self.all_passed_tests.map{|test| test.student}
    end

    def find_student(name)
        # go to the student.all
        # find the student
        Student.all.find{|student| student.student_name == name}
    end

    def find_test(test_name_str)
        Boatingtest.all.find{|test| test.test_name = test_name_str}
    end

    def pass_student (name_str, test_name_str)
        test = find_test(test_name_str)

        if test && test.student.student_name == name_str
            test.test_status = "passed"
        else
            student = find_student(name_str)
            Boating.Test.new(student, test_name_str, "passed", self)
        end
    end

    def fail_student
        test = find_test(test_name_str)

        if test && test.student.student_name == name_str
            test.test_status = "failed"
        else
            student = find_student(name_str)
            Boating.Test.new(student, test_name_str, "failed", self)
        end
    end
end

# `Instructor` class:
# * initialize with a name
# * `Instructor.all` should return all instructors
# * `Instructor#passed_students` should return an array of students who passed a boating test with this specific instructor.

# * `Instructor#pass_student` should take in a student instance and test name. If there is a `BoatingTest` whose name and student match the values passed in, this method should update the status of that BoatingTest to 'passed'. If there is no matching test, this method should create a test with the student, that boat test name, and the status 'passed'. Either way, it should return the `BoatingTest` instance.

# * `Instructor#fail_student` should take in a student instance and test name. Like `#pass_student`, it should try to find a matching `BoatingTest` and update its status to 'failed'. If it cannot find an existing `BoatingTest`, it should create one with the name, the matching student, and the status 'failed'.

# * `Instructor#all_students` should return an array of students who took a boating test with this specific instructor. 