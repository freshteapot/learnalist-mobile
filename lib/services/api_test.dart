import 'package:learnalist/models/alist.dart';
import 'package:learnalist/services/api.dart';

void main() async {
  var api = Api();
  /*
  //var items = await api.getUsersLists();
  //print(items);
  // List<String> labels = ['norwegian'];
  //var items = await api.getUsersLists(labels: ['norwegian']);
  //print(items);
  //var items = await api.getUsersLists(type: ListType.v2);
  //print(items);

  var items = await api
      .getUsersLists(labels: ['days of the week'], type: ListType.v1);
  print(items);
  */
  var item = await api.getAlistByUUID('cc019754-f8d9-5560-9001-74e5d43ae65f');
}
