import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_project/object_box/transactions/entity.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key, required this.store});
  final Store store;
  @override
  TransactionsViewState createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  Box<Employee>? employeeBox;
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    employeeBox = widget.store.box<Employee>();
    _loadData(); // Load data initially
  }

  void _loadData() {
    setState(() {
      employees = employeeBox!.getAll(); // Get all persons from the database
    });
  }

  void performTransaction() {
    try {
      widget.store.runInTransaction(TxMode.write, () {
        final employee1 = Employee(name: 'John Doe', age: 30);
        final employee2 = Employee(name: 'Jane Doe', age: 28);
        employeeBox!.put(employee1);
        employeeBox!.put(employee2);
        final employee3 =
            employeeBox!.get(1); // Assuming person with id 1 exists
        if (employee3 != null) {
          employee3.age = 31;
          employeeBox!.put(employee3);
        }

        employeeBox!.remove(2); // Assuming person with id 2 exists
      });

      _loadData(); // Reload data after transaction

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction completed successfully')),
      );
    } catch (e) {
      print('Transaction failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectBox Transaction Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: performTransaction,
            child: const Text('Perform Transaction'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('Age: ${employee.age}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
