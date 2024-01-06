import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/random_card.dart';
import 'package:http/http.dart' as http;

class DashboardViewModel with ChangeNotifier{

  Future<RandomCard> fetchCardInfo() async {
    final response = await http.get(Uri.parse('https://tarotapi.dev/api/v1/cards/random?n=1'));
    if (response.statusCode == 200) {
      return RandomCard.fromJson(jsonDecode(response.body)['cards'][0]);
    } else {
      throw Exception('Failed to load card info');
    }
  }
}