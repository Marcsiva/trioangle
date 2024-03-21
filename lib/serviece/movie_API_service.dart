import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trioangle/model/movie_API_model.dart';

class MovieService {
  String baseUrl = "https://api.jikan.moe/v4/anime?q=naruto&sfw";
  Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> result = data['data'];
      if (result.isNotEmpty) {
        return result.map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw Exception("error");
      }
    } else {
      throw Exception("fetching error");
    }
  }
}
