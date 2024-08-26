import 'package:flutter/material.dart';
import 'package:riverpod_project/object_box/relation/relation.dart';
import 'package:riverpod_project/object_box/relation/relationship_view.dart';
import 'package:riverpod_project/object_box/store/object_box.dart';
import 'package:riverpod_project/objectbox.g.dart';

import 'object_box/transactions/transactions_view.dart';

late ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();
  createSampleData(objectBox.store);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Object Box',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TransactionsView(store: objectBox.store),
      // home: RelationshipsScreen(store: objectBox.store)
      /*    home: TempEntityScreen(
        store: objectBox.store,
      ), */
      // home: ObjectboxView(store: objectBox.store),
    );
  }
}

void createSampleData(Store store) {
  // Create entities
  final person = Person(name: 'John Doe');
  final passport = Passport(passportNumber: 'X1234567');

  final teacher = Teacher(name: 'Mr. Smith');
  final student1 = Student(name: 'Alice');
  final student2 = Student(name: 'Bob');

  final course1 = Course(title: 'Math 101');
  final course2 = Course(title: 'Science 101');

  // Establish one-to-one relationship
  person.passport.target = passport;
  passport.person.target = person;

  // Establish one-to-many relationship
  teacher.students.add(student1);
  teacher.students.add(student2);
  student1.teacher.target = teacher;
  student2.teacher.target = teacher;

  // Establish many-to-many relationship
  student1.courses.add(course1);
  student1.courses.add(course2);
  student2.courses.add(course1);
  course1.students.add(student1);
  course1.students.add(student2);
  course2.students.add(student1);

  // Store data in ObjectBox
  store.box<Person>().put(person);
  store.box<Passport>().put(passport);
  store.box<Teacher>().put(teacher);
  store.box<Student>().put(student1);
  store.box<Student>().put(student2);
  store.box<Course>().put(course1);
  store.box<Course>().put(course2);
}
