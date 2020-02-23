import 'package:cinema_concept/models/movie.dart';
import 'package:cinema_concept/pages/movie_detail_page.dart';
import 'package:cinema_concept/widgets/blur_background.dart';
import 'package:cinema_concept/widgets/custom_app_bar.dart';
import 'package:cinema_concept/widgets/custom_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  var _width, _height;
  List<Movie> _movieData = Movie().movieData;
  var currentPage = 0.0;
  PageController _pageController = PageController();

  Movie _displayMovie;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    _displayMovie = _movieData[currentPage.round()];

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlurBackground(assets: _displayMovie.image),
          Column(
            children: <Widget>[
              CustomAppBar(
                  title: "Session", onBackPress: () {}, onMenuPress: () {}),
              Expanded(child: _movieList())
            ],
          )
        ],
      ),
    );
  }

  Widget _movieList() {
    return GestureDetector(
      onVerticalDragStart: (details) {
        if ((details.globalPosition.dx > (_width / 2 - 50) &&
                details.globalPosition.dx < (_width / 2 + 50)) &&
            details.globalPosition.dy > (_width / 2 + 100)) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MovieDetailPage(movie: _displayMovie)));
        }
      },
      child: Stack(
        children: <Widget>[
          _movieStack(),
          _pageIndicator(),
          PageView.builder(
            controller: _pageController,
            itemCount: _movieData.length,
            itemBuilder: (context, index) {
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _movieStack() {
    List<Widget> _movies = [];

    for (int i = _movieData.length - 1; i >= 0; i--) {
      var sizeOffset = (15.0 * i) - (currentPage * 15);
      var topOffset = (15.0 * i) - (currentPage * 15);
      _movies.add(Positioned.fill(
          top: topOffset,
          left: currentPage > (i) ? -(currentPage - i) * (_width * 4) : 0,
          child: _movieCard(
              _movieData[i], _width - sizeOffset, _height - sizeOffset)));
    }

    return Stack(
      children: _movies,
    );
  }

  Widget _movieCard(Movie displayMovie, double width, double height) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Container(
          width: width * .8,
          height: height * .75,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 2)
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: <Widget>[
              CustomHero(
                tag: displayMovie.image,
                child: Container(
                  height: height * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: ExactAssetImage(displayMovie.image),
                          fit: BoxFit.cover)),
                ),
              ),
              CustomHero(
                tag: displayMovie.image + 'content',
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),
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
                                displayMovie.title,
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 24),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  displayMovie.display,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "IMDB: ${displayMovie.imdb.toString()}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            displayMovie.gendres,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            displayMovie.desc,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.drag_handle,
                                color: Colors.grey,
                              ),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageIndicator() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SliderIndicator(
            length: _movieData.length,
            activeIndex: currentPage.round(),
            displayIndicatorSize: 6,
            displayIndicatorColor: Colors.black38,
          ),
        ));
  }
}
