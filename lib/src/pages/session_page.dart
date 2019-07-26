import 'package:cinema_concept/src/models/movie.dart';
import 'package:cinema_concept/src/pages/movie_detail_page.dart';
import 'package:cinema_concept/src/widgets/blur_background.dart';
import 'package:cinema_concept/src/widgets/bullet_list.dart';
import 'package:cinema_concept/src/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  var width, height;
  var currentPage = 0.0;

  PageController _pageController = PageController();

  List<Movie> _movieData = Movie().movieData;
  Movie _displayMovie;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    _displayMovie = _movieData[currentPage.round()];

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlurBackground(asset: _displayMovie.image),
          Column(
            children: <Widget>[
              CustomAppBar(
                  title: "Session", onBackPress: () {}, onMenuPress: () {}),
              Expanded(child: _movieList()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _movieList() {
    return Stack(children: <Widget>[
      _movieStack(),
      _movieListBullet(),
      PageView.builder(
        controller: _pageController,
        itemCount: _movieData.length,
        itemBuilder: (context, index) {
          return Container();
        },
      )
    ]);
  }

  Widget _movieStack() {
    List<Widget> _movies = [];

    for (int i = _movieData.length - 1; i >= 0; i--) {
      var sizeOffset = (15.0 * i) - (currentPage * 15);
      var topOffset = (15.0 * i) - (currentPage * 15);
      _movies.add(Positioned.fill(
        child:
            _movieCard(_movieData[i], width - sizeOffset, height - sizeOffset),
        top: topOffset,
        left: currentPage > (i) ? -(currentPage - i) * (width * 4) : 0,
      ));
    }

    return Stack(
      children: _movies,
    );
  }

  Widget _movieCard(Movie movie, double width, double height) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          width: width * .8,
          height: height * .75,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 2)
          ], borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Stack(children: <Widget>[
            Container(
              height: height * .75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: height * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: ExactAssetImage(movie.image),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: height * .45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150,
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(height: 4),
                                Text(
                                  movie.display,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "IMDB: ${movie.imdb.toString()}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(movie.gendres,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16, top: 8),
                            child: Text(movie.desc,
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        Center(
                          child: IconButton(
                              icon: Icon(Icons.drag_handle, color: Colors.grey),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _movieListBullet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: BulletList(
              length: _movieData.length, activeIndex: currentPage.round())),
    );
  }
}
