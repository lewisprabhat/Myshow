import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:myshow/model/Movie.dart';

import 'AllExtractedData.dart';
import 'main.dart';

class MovieDetails extends StatelessWidget {
  Movie movie;
MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    double? rating = movie.voteAverage;
    String? imageurl = movie.posterPath;
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration:  BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage( 'https://image.tmdb.org/t/p/w342$imageurl'),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,top: 12,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 280,
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: SvgPicture.asset('assets/Button.svg'),
                ),
                SizedBox(height: 10,),
                const Text(
                  'Play Trailer',
                  style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600,),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          top: 250,
          left: 0,
          right: 0,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),topLeft: Radius.circular(15.0),),
              color: Colors.white,  ),

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movie.originalTitle ?? "n/a",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              fontFamily: 'Mulish'),
                        ),
                        Icon(Icons.bookmark_border),
                      ],
                    ),
                     SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset('assets/Star.svg'),  Text(' $rating/10 IMdb',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Moviesdecorate(geners: "Action"),
                        SizedBox(width: 8,),
                        Moviesdecorate(geners: "Adventure"),
                        SizedBox(width: 8,),
                        Moviesdecorate(geners: "Fantasy"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              ' Length',
                              style: TextStyle(
                                  color: Color(0xff9C9C9C),
                                  fontFamily: ' Mulish'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '2hr 45min',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Language',
                              style: TextStyle(
                                  color: Color(0xff9C9C9C),
                                  fontFamily: ' Mulish'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'English',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Rating',
                              style: TextStyle(
                                  color: Color(0xff9C9C9C),
                                  fontFamily: ' Mulish'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'PG-13',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            fontFamily: 'Merriweather',
                            color: Color(0xff110E47),
                              letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                         Text(
                            movie.overview ?? "n/a",
                          style: TextStyle(color: Color(0XFF9C9C9C), letterSpacing: 1.0),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Cast',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                fontFamily: 'Merriweather',
                                color: Color(0xff110E47),

                              ),
                            ),
                            SizedBox(height: 16,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  'see more',
                                  style: TextStyle(color: Color(0xffAAA9B1)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          width: 72,
                          child: Column(
                            children: [
                              Container(
                                height: 76,
                                width: 72,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                    'assets/tony.jpg',
                                  )),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Tony Stark",
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 16,),
                        SizedBox(
                          width: 72,
                          child: Column(
                            children: [
                              Container(
                                height: 76,
                                width: 72,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/tony.jpg',
                                      )),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text(
                                "tony stark ",
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
