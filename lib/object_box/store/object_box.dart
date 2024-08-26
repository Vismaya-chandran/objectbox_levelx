import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_project/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  ObjectBox._create(this.store);
  static Future<ObjectBox> create() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final store =
        Store(getObjectBoxModel(), directory: '${appDocDir.path}/objectbox');
    return ObjectBox._create(store);
  }
}
