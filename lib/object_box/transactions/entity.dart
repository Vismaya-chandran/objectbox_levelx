import 'package:objectbox/objectbox.dart';

@Entity()
class Employee {
  int id;
  String name;
  int age;

  Employee({this.id = 0, required this.name, required this.age});
}
