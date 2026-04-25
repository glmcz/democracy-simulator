import 'dart:convert';
import 'package:democracy_simulator/models/story_chain.dart';

class StoryPersistence {
  static String serializeChain(StoryChain chain) {
    return jsonEncode(chain.toJson());
  }

  static StoryChain deserializeChain(String json) {
    try {
      final data = jsonDecode(json) as Map<String, dynamic>;
      return StoryChain.fromJson(data);
    } catch (e) {
      throw Exception('Failed to deserialize story chain: $e');
    }
  }

  static Map<String, dynamic> chainToJson(StoryChain chain) {
    return chain.toJson();
  }

  static String chainToJsonString(StoryChain chain) {
    return jsonEncode(chainToJson(chain));
  }

  static String prettifyJson(String jsonString) {
    try {
      final data = jsonDecode(jsonString);
      return jsonEncode(data); // Use JsonEncoder for pretty printing if needed
    } catch (e) {
      return jsonString;
    }
  }
}
