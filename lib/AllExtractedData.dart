import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HorizontalMoviesItems extends StatelessWidget {
  const HorizontalMoviesItems(
      {super.key,
      required this.name,
      required this.rating,
      required this.imageurl});

  final String name;
  final double rating;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 212,
          width: 143,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(blurRadius: 10.0, color: Colors.black38),
              ]),
          child: Image.network('https://image.tmdb.org/t/p/w342$imageurl'),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 15, fontFamily: 'Fonts'),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(
              'assets/Star.svg',
            ),
            const SizedBox(width: 10),
            Text(
              "$rating/10 IMDb",
              style: TextStyle(color: Color(0xff9C9C9C)),
            ),
          ],
        )
      ],
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem(
      {super.key,
      required this.title,
      required this.rating,
      required this.genres,
      required this.watchTime,
      required this.imageurl,
      this.onpress});

  final String title;
  final double rating;
  final List<String> genres;
  final String watchTime;
  final String imageurl;
  final GestureTapCallback? onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 85,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              onTap: onpress,
              child: Image.network(
                'https://image.tmdb.org/t/p/w342$imageurl',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/Star.svg'),
                      Text(' $rating/10 IMDb',
                          style: TextStyle(color: Color(0xff9C9C9C))),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: genres
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Moviesdecorate(geners: e),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/clock.svg'),
                      const Text(' 1h 47m'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Moviesdecorate extends StatelessWidget {
  const Moviesdecorate({
    super.key,
    required this.geners,
  });

  final String geners;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Color(0XFFDBE3FF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          geners,
          style: const TextStyle(
            color: Color(
              0XFF88A4E8,
            ),
          ),
        ),
      ),
    );
  }
}
