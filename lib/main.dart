import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myshow/model/Login.dart';
import 'package:myshow/model/forget.dart';
import 'package:myshow/movie_details.dart';
import 'package:myshow/network.dart';
import 'package:myshow/popular.dart';

import 'AllExtractedData.dart';
import 'model/Movie.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/Signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: forget(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];
  NetworkHelper helper = NetworkHelper();
  List<Movie> movie2 = [];

  @override
  void initState() {
    super.initState();
    getmoviedata();
    getpopulardata();
  }

  Future<void> getmoviedata() async {
    movies = await helper.getpopulardata(1, 'now_playing');
    setState(() {
      print(movies);
    });
  }

  Future<void> getpopulardata() async {
    movie2 = await helper.getpopulardata(1, 'popular');
    setState(() {
      print(movie2);
    });
  }
  _signOut() async {
    await _firebaseAuth.signOut();
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
              onPressed: () {
               _signOut();
               Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
              },
              icon: SvgPicture.asset(
                'assets/Notif.svg',
                width: 25,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 22,
                    child: Text(
                      'Now Showing',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Color(0xff110E47),
                          fontFamily: 'Merriweather'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Popular(
                                    playing: 'now_playing',
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          'see more',
                          style: TextStyle(
                              color: Color(0xffAAA9B1), fontFamily: 'Mulish'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movies
                    .map((mov) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                          movie: mov,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 24.0,
                                left: movies.indexOf(mov) == 0 ? 24 : 0),
                            child: HorizontalMoviesItems(
                                imageurl: mov.posterPath!,
                                name: mov.originalTitle ?? "N/a",
                                rating: mov.voteAverage ?? 0.0),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Color(0xff110E47),
                        fontFamily: 'Merriweather'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Popular(
                                    playing: 'popular',
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          'see more',
                          style: TextStyle(color: Color(0xffAAA9B1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movie2
                    .map(
                      (index) => MovieItem(
                        imageurl: index.posterPath!,
                        title: index.originalTitle ?? "n/a",
                        rating: index.voteAverage ?? 0.0,
                        genres: ['Horror', 'Mystery', 'Thriller'],
                        watchTime: '1hr 47m',
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetails(movie: index)));
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/Book.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/sybl.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/saa.svg'), label: ''),
        ],
      ),
    );
  }
}
