import 'alist.dart';
import 'package:uuid/uuid.dart';

class AlistV1 extends Alist {
  void addItem(String value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<String> getItems() {
    List<String> items = List<String>();
    for (String item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV1(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v1);
  }
}

AlistV1 newEmptyAlistV1() {
  var uuid = new Uuid();
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(title: '', listType: ListType.v1, labels: []),
      data: List<String>());
  return newAlistV1(aList);
}

AlistV1 newAlistV1(Alist aList) {
  AlistV1 temp = AlistV1(aList);
  return temp;
}
