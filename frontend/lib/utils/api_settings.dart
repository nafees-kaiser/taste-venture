import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_input/image_input.dart';

class ApiSettings {
  String endPoint;
  late final String baseUrl = baseUri;
  late final String uri = baseUrl + endPoint;

  ApiSettings({required this.endPoint});

  Future<http.Response> postMethod(String data) async {
    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> postMethodWithDiffEndPoint(
      String data, String ep) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + ep),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getMethod() async {
    try {
      final response = await http.get(
        Uri.parse(uri),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getMethodWithDiffEndPoint(String ep) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ep),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> postMultiPartForm(
      {required Map<String, dynamic> data, XFile? image}) async {
    var req = http.MultipartRequest('POST', Uri.parse(uri));

    data.forEach((key, value) {
      req.fields[key] = value;
    });

    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split("/").last,
      );
      req.files.add(multipartFile);
    }

    try {
      var streamedResponse = await req.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addRestaurant(
      {required Map<String, dynamic> data, XFile? image}) async {
    var req = http.MultipartRequest('POST', Uri.parse(uri));
    List<Map<String, dynamic>> menu = data.remove('menu_item');
    data.forEach((key, value) {
      req.fields[key] = value;
    });

    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split("/").last,
      );
      req.files.add(multipartFile);
    }

    List<XFile?> images = [];
    images = menu.map((m) => m.remove('image') as XFile).toList();

    for (int i = 0; i < menu.length; i++) {
      menu[i]
          .forEach((key, value) => req.fields['menu_item[$i][$key]'] = value);
    }

    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) {
        var stream = http.ByteStream(images[i]!.openRead());
        var length = await images[i]!.length();
        var multipartFile = http.MultipartFile(
          "menu_item[$i][image]",
          stream,
          length,
          filename: images[i]!.path.split("/").last,
        );
        req.files.add(multipartFile);
      }
    }

    try {
      var streamedResponse = await req.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addPicture(XFile? image, [String end = '']) async {
    var req;

    if (end != '') {
      req = http.MultipartRequest('POST', Uri.parse(baseUrl + end));
    } else {
      req = http.MultipartRequest('POST', Uri.parse(uri));
    }

    // if(id != null){
    //   req.fields['id'] = id.toString();
    // }

    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split("/").last,
      );
      req.files.add(multipartFile);
    }

    try {
      var streamedResponse = await req.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String getUri() {
    return uri;
  }

  String getBaseUri() {
    return baseUrl;
  }
}
