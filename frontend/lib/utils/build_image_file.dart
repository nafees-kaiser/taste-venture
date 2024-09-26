import 'dart:io';
import 'dart:typed_data';
import 'package:frontend/utils/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<File> fetchAndStoreImage(String imageUrl) async {
  final http.Response response = await ApiSettings(endPoint: urlModify(imageUrl)).getMethod();
  if (response.statusCode == 200) {
    Uint8List imageBytes = response.bodyBytes;
    Directory tempDir = await getTemporaryDirectory();
    
    String fileName = path.basename(imageUrl);
    File file = File('${tempDir.path}/$fileName');
    
    await file.writeAsBytes(imageBytes);
    
    return file;
  } else {
    throw Exception('Failed to load image');
  }
}

String urlModify(String url){
  if(url[0]=='/'){
    return url.substring(1);
  }
  return url;
}
