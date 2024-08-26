import 'package:objectbox/objectbox.dart';

// ObjectBox entity classes

@Entity()
class Person {
  int id;
  String name;
  final ToOne<Passport> passport = ToOne<Passport>();

  Person({this.id = 0, required this.name});
}

@Entity()
class Passport {
  int id;
  String passportNumber;
  final ToOne<Person> person = ToOne<Person>();

  Passport({this.id = 0, required this.passportNumber});
}

@Entity()
class Teacher {
  int id;
  String name;
  final ToMany<Student> students = ToMany<Student>();

  Teacher({this.id = 0, required this.name});
}

@Entity()
class Student {
  int id;
  String name;
  final ToOne<Teacher> teacher = ToOne<Teacher>();
  final ToMany<Course> courses = ToMany<Course>();

  Student({this.id = 0, required this.name});
}

@Entity()
class Course {
  int id;
  String title;
  final ToMany<Student> students = ToMany<Student>();

  Course({this.id = 0, required this.title});
}
