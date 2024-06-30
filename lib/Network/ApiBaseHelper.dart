import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jtable/Helpers/Constants.dart';
import 'package:jtable/Helpers/auth_service.dart';
import 'package:jtable/Network/AppException.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jtable/Network/AppException.dart';
import 'dart:async';

import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';

class ApiBaseHelper {

  final String _baseUrl = baseUrl;

  Future<dynamic>
  get(String url, BuildContext context) async {
    var responseJson;
    try {
      String? token = "";

      if(context != null){
        token = Provider.of<NetworkProvider>(context, listen: false).users?.token ?? "qqq";
        print("the tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn: " + token);
      }
      print(token);
      var header = {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token" };
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(true, null) : print("context null");
      final response = await http.get(Uri.parse(_baseUrl + url), headers: header);
      print(response.body);
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, null): print("c null");
      responseJson = _returnResponse(response, context);
    }  catch(ex) {
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, ex.toString() ?? ""): print("c null");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> post(String url, dynamic body, BuildContext context) async {

    print("the url: ------------");
    print(_baseUrl + url);
    var responseJson;
    try {
      String? token = "";
      if(context != null){
        token = Provider.of<NetworkProvider>(context, listen: false).users?.token;
      }
      print(token);
      var header = {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token" };
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(true, null) : print("context null");
      print(body);
      final response = await http.post(Uri.parse(_baseUrl + url), body: json.encode(body), headers: header);
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, null): print("c null");
      responseJson = _returnResponse(response, context);
    } catch(ex) {
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, ex.toString() ?? ""): print("c null");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

  }


  dynamic _returnResponse(http.Response response, BuildContext context) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        Provider.of<NetworkProvider>(context, listen: false).clearAll();
        AuthService auth = new AuthService();
        auth.logout(context);
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}