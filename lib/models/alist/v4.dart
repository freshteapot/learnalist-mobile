import 'alist.dart';
import 'package:uuid/uuid.dart';

class TypeV4Item {
  String content;
  String url;
  TypeV4Item(this.content, this.url);

  TypeV4Item.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'content': content, 'url': url};

  @override
  String toString() {
    return 'TypeV4Item{content: $content, url: $url}';
  }
}

class AlistV4 extends Alist {
  void addItem(TypeV4Item value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<TypeV4Item> getItems() {
    List<TypeV4Item> items = List<TypeV4Item>();
    for (TypeV4Item item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV4(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v4);
  }
}

AlistV4 newEmptyAlistV4() {
  var uuid = new Uuid();
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(title: '', listType: ListType.v4, labels: []),
      data: List<TypeV4Item>());
  return newAlistV4(aList);
}

AlistV4 newAlistV4(Alist aList) {
  AlistV4 temp = AlistV4(aList);
  return temp;
}
