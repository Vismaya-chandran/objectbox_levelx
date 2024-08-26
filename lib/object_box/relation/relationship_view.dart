import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_project/object_box/relation/relation.dart';

class RelationshipsScreen extends StatefulWidget {
  final Store store;

  const RelationshipsScreen({super.key, required this.store});

  @override
  State<RelationshipsScreen> createState() => _RelationshipsScreenState();
}

class _RelationshipsScreenState extends State<RelationshipsScreen> {
  Person? person;

  Teacher? teacher;

  List<Student> students = [];

  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    // Load data from ObjectBox in initState
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relationships Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // One-to-One: Person and Passport
            if (person != null) ...[
              Text('Person: ${person!.name}'),
              Text(
                  'Passport Number: ${person!.passport.target?.passportNumber ?? "No Passport"}'),
            ],

            const SizedBox(height: 20),

            // One-to-Many: Teacher and Students
            if (teacher != null) ...[
              Text('Teacher: ${teacher!.name}'),
              const Text('Students:'),
              ...students.map((student) => Text('- ${student.name}')).toList(),
            ],

            const SizedBox(height: 20),

            // Many-to-Many: Students and Courses
            Text('Courses:'),
            ...courses.map((course) {
              final enrolledStudents =
                  course.students.map((s) => s.name).join(', ');
              return Text('${course.title}: $enrolledStudents');
            }).toList(),
          ],
        ),
      ),
    );
  }

  void loadData() {
    final boxPerson = widget.store.box<Person>();
    final boxTeacher = widget.store.box<Teacher>();
    final boxCourse = widget.store.box<Course>();

    person = boxPerson.getAll().firstOrNull;
    teacher = boxTeacher.getAll().firstOrNull;

    if (teacher != null) {
      students = teacher!.students.toList();
    }

    courses = boxCourse.getAll();
  }
}
