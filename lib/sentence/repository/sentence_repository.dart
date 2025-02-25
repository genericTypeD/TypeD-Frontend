import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SentenceRepository {
  final String baseUrl = "http://43.201.193.230"; // 실제 API 주소로 변경

  // 디바이스 ID 가져오기
  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = Uuid().v4();
      await prefs.setString('device_id', deviceId);
    }
    return deviceId;
  }

  // 문장 저장 (POST)
  Future<Map<String, dynamic>?> saveSentence(
      String content, bool isPublic) async {
    final String deviceId = await _getDeviceId();
    final response = await http.post(
      Uri.parse('$baseUrl/sentences'),
      headers: {"Content-Type": "application/json", "X-Device-Id": deviceId},
      body: jsonEncode({
        "content": content,
        "isPublic": isPublic,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print('문장 저장 실패: ${response.body}');
      return null;
    }
  }

  // 문장 목록 조회 (GET)
  Future<List<dynamic>?> fetchSentences() async {
    final String deviceId = await _getDeviceId();
    final response = await http.get(
      Uri.parse('$baseUrl/sentences'),
      headers: {"Content-Type": "application/json", "X-Device-Id": deviceId},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('문장 목록 조회 실패: ${response.body}');
      return null;
    }
  }

  // 문장 수정 (PUT)
  Future<bool> updateSentence(
      int sentenceId, String content, bool isPublic) async {
    final String deviceId = await _getDeviceId();
    final response = await http.put(
      Uri.parse('$baseUrl/sentences/$sentenceId'),
      headers: {"Content-Type": "application/json", "X-Device-Id": deviceId},
      body: jsonEncode({
        "content": content,
        "isPublic": isPublic,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('문장 수정 실패: ${response.body}');
      return false;
    }
  }

  // 문장 삭제 (DELETE)
  Future<bool> deleteSentence(int sentenceId) async {
    final String deviceId = await _getDeviceId();
    final response = await http.delete(
      Uri.parse('$baseUrl/sentences/$sentenceId'),
      headers: {"Content-Type": "application/json", "X-Device-Id": deviceId},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('문장 삭제 실패: ${response.body}');
      return false;
    }
  }
}
