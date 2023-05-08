import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myshow/model/Movie.dart';
class NetworkHelper{

  Future<List<Movie>> getpopulardata(int page, String playing ) async{
    http.Response response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$playing?api_key=6b512ee123bdab940aff8d7d3adf4718&language=en-US&page=$page'));
    List<Movie> movie2 =[];
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var movie in data['results']) {
        movie2.add(Movie.fromJson(movie));
      }
      return movie2;
    }else{
      print(response.statusCode);
      }
    return [];
    }

  }

