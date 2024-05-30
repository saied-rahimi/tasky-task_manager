import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = 'https://todo.iraqsapp.com';
  Future signUpUser(
    String phoneNumber,
    String password,
    String name,
    int expYear,
    String address,
    String level,
  ) async {
    const String signUpEndpoint = '/auth/register';

    try {
      final url = Uri.parse(baseUrl + signUpEndpoint);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'phone': phoneNumber,
          'password': password,
          'displayName': name,
          'experienceYears': expYear,
          'address': address,
          'level': level,
        }),
      );

      return response;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future signInUser(
    String phoneNumber,
    String password,
  ) async {
    const String signUpEndpoint = '/auth/login';

    try {
      final url = Uri.parse(baseUrl + signUpEndpoint);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'phone': phoneNumber,
          'password': password,
        }),
      );

      return response;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
