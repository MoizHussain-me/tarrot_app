import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/random_card.dart';
import 'package:http/http.dart' as http;

import '../Model/readers_model.dart';

class DashboardViewModel with ChangeNotifier {
  Future<List<RandomCard>> fetchCards({required int numberOfCards}) async {
    final response = await http.get(
        Uri.parse('https://tarotapi.dev/api/v1/cards/random?n=$numberOfCards'));

    if (response.statusCode == 200) {
      List<dynamic> cardsJson = jsonDecode(response.body)['cards'];
      List<RandomCard> cards =
          cardsJson.map((cardJson) => RandomCard.fromJson(cardJson)).toList();
      return cards;
    } else {
      throw Exception('Failed to load card info');
    }
  }

  Future<RandomCard> fetchSingleCard() async {
    final response = await http
        .get(Uri.parse('https://tarotapi.dev/api/v1/cards/random?n=1'));

    if (response.statusCode == 200) {
      dynamic cardJson = jsonDecode(response.body)['cards'][0];
      RandomCard card = RandomCard.fromJson(cardJson);
      return card;
    } else {
      throw Exception('Failed to load card info');
    }
  }

  Future<List<ReadersModel>> getAllReaders() async {
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('Readers');
    List<ReadersModel> readersList = [];

    try {
      QuerySnapshot querySnapshot = await categories.get();
      if (querySnapshot != null) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
          if (data != null) {
            if (data["status"] == "approve") {
              ReadersModel category = ReadersModel.fromJson(data);
              readersList.add(category);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    print(readersList);
    return readersList;
  }
}
