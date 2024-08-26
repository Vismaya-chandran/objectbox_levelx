import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_project/object_box/user/entity.dart';
import 'package:riverpod_project/object_box/user/user_listview.dart';

class ObjectboxView extends StatefulWidget {
  const ObjectboxView({super.key, required this.store});
  final Store store;
  @override
  State<ObjectboxView> createState() => _ObjectboxViewState();
}

class _ObjectboxViewState extends State<ObjectboxView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  late Box<User> userBox;
  @override
  void initState() {
    userBox = widget.store.box<User>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final users = userBox.getAll();
    return Scaffold(
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: nameController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: ageController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: emailController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: userNameController,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.purple.shade100),
                  onPressed: () {
                    addUser(nameController.text, int.parse(ageController.text),
                        emailController.text, userNameController.text);
                  },
                  child: const Text("Add User")),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return UserListview(
                        userBox: userBox,
                        users: users,
                      );
                    },
                  ));
                },
                child: const Text(
                  'navigate home screen',
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }

  void addUser(String name, int age, String email, String userName) {
    try {
      final user =
          User(name: name, age: age, emailAddress: email, userName: userName);
      userBox.put(user);
      setState(() {
        nameController.clear();
        ageController.clear();
        emailController.clear();
        userNameController.clear();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User added')));
    } on UniqueViolationException catch (_, e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('email already exists')));
    } catch (e) {
      print(e.toString());
    }
  }
}
