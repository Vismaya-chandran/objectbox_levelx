import 'package:objectbox/objectbox.dart';

@Entity()
class TempEntity {
  int id;
  int tempId;
/*   @Transient()
  CustomType customData; */

  TempEntity({
    this.id = 0,
    required this.tempId,
    /*  required this.customData */
  });

/*   String get customType => jsonEncode({
        'a': customData.a,
      });

  set customType(String value) {
    final map = jsonDecode(value);

    final obj = CustomType(map['a'] as int);
    customData = obj;
  } */
}
