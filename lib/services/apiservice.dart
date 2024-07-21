import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; // Asegúrate de tener esta línea
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:5182/';

  Future<List<Map<String, dynamic>>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (kDebugMode) {
      print('$baseUrl$endpoint');
    }
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> agregarRegistro(
      Map<String, dynamic> nuevoRegistro, String endpoint) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(nuevoRegistro),
    );
    if (kDebugMode) {
      print(nuevoRegistro);
    }
    if (response.statusCode == 200) {
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Mensaje de error: ${response.body}');
      }
      throw Exception('Failed to add new visitor');
    }
  }

  Future<void> actualizarRegistro(
      Map<String, dynamic> actualizacion, String endpoint) async {
    final response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(actualizacion),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Se actualizó el registro correctamente');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Mensaje de error: ${response.body}');
      }
      throw Exception('Failed to update visitor record');
    }
  }

  Future<void> eliminarRegistro(
      Map<String, dynamic> eliminacion, String endpoint) async {
    final response = await http.delete(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(eliminacion),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Se actualizó el registro correctamente');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Mensaje de error: ${response.body}');
      }
      throw Exception('Failed to update visitor record');
    }
  }
}
