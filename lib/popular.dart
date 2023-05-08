import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'AllExtractedData.dart';
import 'model/Movie.dart';
import 'movie_details.dart';
import 'network.dart';

class Popular extends StatefulWidget {
  const Popular({required this.playing});

  final String playing;

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  List<Movie> movies = [];
  NetworkHelper helper = NetworkHelper();
  bool isLoading = false;
  int page = 1;
  ScrollController _scrollController = ScrollController();

  Future<void> getmoviedata() async {
    List<Movie> newmovies = await helper.getpopulardata(page, widget.playing);
    setState(() {
      movies.addAll(newmovies);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmoviedata();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        getmoviedata();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "FilmKu",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xff110E47),
              fontFamily: 'Merriweather',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 24, top: 18, bottom: 18),
            child: SvgPicture.asset(
              'assets/Union.svg',
              color: Color(0xff110E47),
            ),
          ),
          leadingWidth: 48,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/Notif.svg',
                  width: 25,
                )),
          ],
        ),
        body: Builder(builder: (context) {
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: movies.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: MovieItem(
                      imageurl: movies[index].posterPath!,
                      title: movies[index].originalTitle ?? "n/a",
                      rating: movies[index].voteAverage ?? 0.0,
                      genres: ['Horror', 'Mystery', 'Thriller'],
                      watchTime: '1hr 47m',
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetails(movie: movies[index])));
                      },
                    ),
                  );
                }
              });
        }));
  }
}
//
