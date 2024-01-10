import 'dart:async';
import 'dart:convert';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import '../Model/random_card.dart';
import 'package:http/http.dart' as http;

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

Future<List<User>> getAllReaders(int limit) async {
  List<User> readersList = [];

  Completer<List<User>> completer = Completer();

  try {
    UsersRequest usersRequest = (UsersRequestBuilder()
      ..limit = limit
      ..roles = ['2']
    ).build();

    await usersRequest.fetchNext(onSuccess: (List<User> userList) {
      readersList.addAll(userList);
      completer.complete(readersList);
    }, onError: (CometChatException e) {
      debugPrint("User List Fetch Failed: ${e.message}");
      completer.completeError(e);
    });
  } catch (e) {
    debugPrint('Error: $e');
    completer.completeError(e);
  }

  return completer.future;
}
}
