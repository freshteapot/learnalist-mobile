import 'dart:convert';
import 'dart:io';
import 'package:learnalist/models/alist.dart';

import 'package:http/http.dart' as http;

var basicAuth = '';

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://learnalist.net/api/v1';

  var client = new http.Client();
  // TODO add timeout
  // client.connectionTimeout = const Duration(seconds: 5);

  Future<List<Alist>> getUsersLists({List<String> labels, String type}) async {
    var endpointUri = Uri.parse(endpoint);
    Map<String, dynamic> q = Map();
    if (labels != null) {
      q['labels'] = labels.join(',');
    }
    if (type != null) {
      q['list_type'] = type;
    }

    var suffix = '/alist/by/me';
    var path = endpointUri.path + suffix;

    var uri = Uri(
        scheme: endpointUri.scheme,
        host: endpointUri.host,
        path: path,
        queryParameters: q);

    var items = List<Alist>();
    var headers = {HttpHeaders.authorizationHeader: "Basic $basicAuth"};
    var response = await client.get(uri, headers: headers);

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var alist in parsed) {
      items.add(Alist.fromJson(alist));
    }

    return items;
  }

  Future<Alist> getAlistByUUID(String uuid) async {
    var endpointUri = Uri.parse(endpoint);
    var suffix = '/alist/$uuid';
    var path = endpointUri.path + suffix;

    var uri =
        Uri(scheme: endpointUri.scheme, host: endpointUri.host, path: path);

    var headers = {HttpHeaders.authorizationHeader: "Basic $basicAuth"};
    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Alist.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load list');
    }
  }

  Future<Alist> postAlist(Alist aList) async {
    var endpointUri = Uri.parse(endpoint);
    var suffix = '/alist';
    var path = endpointUri.path + suffix;

    var uri =
        Uri(scheme: endpointUri.scheme, host: endpointUri.host, path: path);

    var headers = {
      HttpHeaders.authorizationHeader: "Basic $basicAuth",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = json.encode(aList);
    var response = await client.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return Alist.fromJson(json.decode(response.body));
    }

    print('Failed to post');
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to post list :(');
  }

  Future<Alist> putAlist(Alist aList) async {
    var endpointUri = Uri.parse(endpoint);
    var suffix = '/alist/' + aList.uuid;
    var path = endpointUri.path + suffix;

    var uri =
        Uri(scheme: endpointUri.scheme, host: endpointUri.host, path: path);

    var headers = {
      HttpHeaders.authorizationHeader: "Basic $basicAuth",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = json.encode(aList);
    var response = await client.put(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Alist.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 400) {
      print('How to handle error messages back up the stack');
    }
    print('Failed to post');
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to put list :(');
  }

  Future<void> removeAlist(Alist aList) async {
    var endpointUri = Uri.parse(endpoint);
    var suffix = '/alist/' + aList.uuid;
    var path = endpointUri.path + suffix;

    var uri =
        Uri(scheme: endpointUri.scheme, host: endpointUri.host, path: path);

    var headers = {
      HttpHeaders.authorizationHeader: "Basic $basicAuth",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var response = await client.delete(uri, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 404) {
      print(response.body);
      return true;
    }

    print('Failed to remove list');
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to remove list :(');
  }
}
