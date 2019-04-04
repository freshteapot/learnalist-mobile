import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/storage/file.dart';
import 'learnalist.dart';

class ListsRepository extends Model {
  FileStorage storage;
  ListsRepository(this.storage);

  Set<Alist> _allLists = Set<Alist>();
  AlistDatabase _fromTheDatabase = AlistDatabase();

  void _addFakeData() {
    Alist a = Alist.fromJson(exampleListV1);
    Alist b = Alist.fromJson(exampleListV2);
    _allLists.add(a);
    _allLists.add(a);
    _allLists.add(b);
  }

  Future<bool> loadLists() async {
    try {
      storage.readDatabaseAsString().then((jsonAsString) {
        // Handles if there is no data.
        // TODO maybe it is better to write the file.
        if (jsonAsString == '{}') {
          jsonAsString = '{"items":[]}';
        }
        Map databaseMap = jsonDecode(jsonAsString);
        _fromTheDatabase = AlistDatabase.fromJson(databaseMap);
        print('Adding ${_fromTheDatabase.items.length} from the database.');
        _fromTheDatabase.items.forEach((aList) {
          _allLists.add(aList);
        });
        print('Adding fake.');
        _addFakeData();
        print('loaded');
        print(_allLists.length);
        return true;
      });
    } catch (e) {
      _addFakeData();
      return false;
    }
  }

  // Currently ordered by sort.
  List<Alist> get aLists {
    var temp = _allLists.toList();
    temp.sort(
        (Alist a, Alist b) => a.listInfo.title.compareTo(b.listInfo.title));
    return temp;
  }

  Alist getByUuid(String uuid) {
    return _allLists.singleWhere((current) => uuid == current.uuid,
        orElse: () => null);
  }

  void addList() {
    print('addList');
  }

  void updateAlist(Alist aList) {
    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    _allLists.add(aList);
    notifyListeners();
    _save();
  }

  void _save() {
    _fromTheDatabase.items = _allLists.toList();

    String json = jsonEncode(_fromTheDatabase);
    storage.saveDatabaseAsString(json).then((success) {
      print('Database updated.');
    });
  }
}
