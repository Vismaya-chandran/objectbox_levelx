import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  String name;
  @Index()
  int age;
  @Unique(onConflict: ConflictStrategy.replace)
  String emailAddress;
  @Index(type: IndexType.hash)
  String userName;
  String _privateField;
  User(
      {this.id = 0,
      required this.name,
      required this.age,
      required this.emailAddress,
      required this.userName,
      String? privateField})
      : _privateField = privateField ?? '';

  String get privateField => _privateField;
  set privateField(String value) => _privateField = value;
}

class CustomType {
  int a;
  CustomType(this.a);
}
