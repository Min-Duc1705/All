import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_enlish/data/models/BackendResponse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:magic_enlish/data/models/file/ResponseUploadFile.dart';

class FileService {
  Future<BackendResponse<ResponseUploadFile>> uploadFile(
    String token,
    List<int> fileBytes,
    String fileName,
    String folder,
  ) async {
    final String url = dotenv.env['Backend_URL'] ?? '';

    var request = http.MultipartRequest('POST', Uri.parse('$url/api/v1/files'));

    request.headers['Authorization'] = 'Bearer $token';

    // Add file as multipart
    request.files.add(
      http.MultipartFile.fromBytes('file', fileBytes, filename: fileName),
    );

    // Add folder as form field
    request.fields['folder'] = folder;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final jsonData = jsonDecode(response.body);

    return BackendResponse<ResponseUploadFile>.fromJson(
      jsonData,
      (data) => ResponseUploadFile.fromJson(data as Map<String, dynamic>),
    );
  }
}
