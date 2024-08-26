import 'package:flutter/material.dart';
import 'package:riverpod_project/object_box/user/entity.dart';
import 'package:riverpod_project/objectbox.g.dart';

class UserListview extends StatefulWidget {
  const UserListview({super.key, required this.users, required this.userBox});
  final List<User> users;

  final Box<User> userBox;
  @override
  State<UserListview> createState() => _UserListviewState();
}

class _UserListviewState extends State<UserListview> {
  List<User> users = [];
  TextEditingController ageController = TextEditingController();
  @override
  void initState() {
    users = widget.users;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: ageController,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      // filterAge();
                      filterUserName();
                    },
                    child: const Text('Apply'))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Text(
                      "Name : ${users[index].name} , age : ${users[index].age} , email : ${users[index].emailAddress} , username : ${users[index].userName}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<User> filterAge() {
    final age = int.parse(ageController.text);
    if (ageController.text != '') {
      setState(() {
        users = widget.userBox
            .query(
                User_.age.equals(age).or(User_.name.equals(ageController.text)))
            .build()
            .find();
      });
      return users;
    } else {
      setState(() {
        users = widget.userBox.getAll();
      });
      return users;
    }
  }

  List<User> filterUserName() {
    if (ageController.text != '') {
      setState(() {
        users = widget.userBox
            .query(User_.userName.equals(ageController.text))
            .build()
            .find();
      });
      return users;
    } else {
      setState(() {
        users = widget.userBox.getAll();
      });
      return users;
    }
  }
}
