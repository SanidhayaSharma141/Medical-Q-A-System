import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getAnswer(String question, String context) async {
  final response = await http.post(
    Uri.parse(
        'http://127.0.0.1:5000/answer'), // Replace with your server address
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'question': question, 'context': context}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['answer'];
  } else {
    throw Exception('Failed to get answer');
  }
}
