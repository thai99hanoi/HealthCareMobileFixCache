import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/request.dart';
import 'package:heath_care/model/request_dto.dart';
import 'package:heath_care/model/request_type.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestRepository {
  Future<List<Request>> getAllRequest() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/request/get-by-doctor');
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(Api.authUrl + "/v1/api/request/get-by-doctor"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson as List)
          .map((request) => Request.fromJson(request))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<Request>> getRequestByUser() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/request/get-by-user');
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(Api.authUrl + "/v1/api/request/get-by-user"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson as List)
          .map((request) => Request.fromJson(request))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> createRequest(RequestDTO requestDTO) async {
    print('Api Post, url /v1/api/request/create');
    String token = await Auth().getToken();
    final fDob = new DateFormat('yyyy-MM-dd');
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(Api.authUrl + "/v1/api/request/create"),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "requestTypeId": requestDTO.requestTypeId,
            "description": requestDTO.description,
            "date": fDob.format(DateTime.now()),
          }));
      responseJson = json.encode(response.bodyBytes);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<List<RequestType>> getAllRequestType() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/request/request-type');
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(Api.authUrl + "/v1/api/request/request-type"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson as List)
          .map((request) => RequestType.fromJson(request))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
