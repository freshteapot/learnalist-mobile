import 'package:learnalist/models/server_credentials.dart';
import 'package:learnalist/services/credentials.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/storage/database.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/services/api.dart';

class ListsRepository extends Model {
  DatabaseStorage storage;
  Credentials credentials;
  Api api;
  ListsRepository({this.storage, this.credentials, this.api});

  Set<Alist> _allLists = Set<Alist>();
  Future<bool> loadLists() async {
    try {
      _allLists.clear();
      var lists = await api.getUsersLists();
      lists.forEach((aList) {
        _allLists.add(aList);
      });
      notifyListeners();
    } catch (e) {
      return false;
    }
    return true;
  }

  // Currently ordered by sort.
  List<Alist> get aLists {
    var temp = _allLists.toList();
    temp.sort((Alist a, Alist b) =>
        a.info.title.toLowerCase().compareTo(b.info.title.toLowerCase()));
    return temp;
  }

  Alist getByUuid(String uuid) {
    return _allLists.singleWhere((current) => uuid == current.uuid,
        orElse: () => null);
  }

  Future<Alist> addAlist(Alist aList) async {
    // TODO how should we handle the exception.
    // Currently letting it bubble up.
    var serverAlist = await api.postAlist(aList);
    _allLists.add(serverAlist);
    notifyListeners();

    return serverAlist;
  }

  Future<Alist> updateAlist(Alist aList) async {
    // Currently only supporting the happy path.
    var serverAlist = await api.putAlist(aList);
    print(serverAlist);

    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    _allLists.add(aList);
    notifyListeners();

    return aList;
  }

  Future<void> removeAlist(Alist aList) async {
    await api.removeAlist(aList);

    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    notifyListeners();
  }

  // TODO move to its own model
  Future<bool> saveCredentials(ServerCredentials input) async {
    await credentials.save(input);
    await loadLists();
    return true;
  }
}
