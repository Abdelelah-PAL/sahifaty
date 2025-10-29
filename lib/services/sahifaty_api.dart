import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'app_exception.dart';

class SahifatyApi {
  final String _baseURL = 'https://api.sahifati.org/';
  final Duration _timeout = const Duration(seconds: 30);

  // Get headers with token
  Future<Map<String, String>> _getHeaders({bool auth = true}) async {
    if (!auth) return {'Content-Type': 'application/json'};

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';
    final refreshToken = prefs.getString('refreshToken') ?? '';

    return {
      'Authorization': 'Bearer $token',
      'X-Refresh-Token': refreshToken,
      'Content-Type': 'application/json',
    };
  }

  // Generic request handler
  Future<dynamic> _request(
      String url, {
        String method = 'GET',
        dynamic body,
        bool auth = true,
      }) async {
    try {
      final headers = await _getHeaders(auth: auth);
      http.Response response;

      final uri = Uri.parse(_baseURL + url);

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers).timeout(_timeout);
          break;
        case 'POST':
          response = await http
              .post(uri, headers: headers, body: json.encode(body))
              .timeout(_timeout);
          break;
        case 'PUT':
          response = await http
              .put(uri, headers: headers, body: json.encode(body))
              .timeout(_timeout);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers).timeout(_timeout);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return processedResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  // Public methods
  Future<dynamic> get(String url) => _request(url, method: 'GET');
  Future<dynamic> fetch(Uri uri) async {
    try {
      final response = await http.get(uri, headers: await _getHeaders(auth: false)).timeout(_timeout);
      return processedResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post({required String url, required dynamic body}) =>
      _request(url, method: 'POST', body: body);

  Future<dynamic> put({required String url, required dynamic body}) =>
      _request(url, method: 'PUT', body: body);

  Future<dynamic> delete(String url) => _request(url, method: 'DELETE');

  // Response handler
  dynamic processedResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: Please login again');
      case 403:
        throw Exception('Forbidden: Access denied');
      case 404:
        throw Exception('Not Found: ${response.body}');
      case 422:
        throw Exception('Validation Error: ${response.body}');
      case 500:
        throw Exception('Server Error: Something went wrong');
      case 503:
        throw Exception('Service Unavailable: Please try again later');
      default:
        throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
