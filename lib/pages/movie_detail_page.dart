import 'package:cinema_concept/models/movie.dart';
import 'package:cinema_concept/widgets/blur_background.dart';
import 'package:cinema_concept/widgets/custom_app_bar.dart';
import 'package:cinema_concept/widgets/custom_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage({this.movie});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  Animation<double> _opacity;
  Animation<double> _offset;
  AnimationController _animationController;

  PageController _pageController = PageController(viewportFraction: 0.85);
  var currentPage = 0.0;
  var scrollDirection = ScrollDirection.reverse;

  var width, height;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacity = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _offset = Tween<double>(begin: -5, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
        scrollDirection = _pageController.position.userScrollDirection;
      });
    });

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlurBackground(assets: widget.movie.image),
          Column(
            children: <Widget>[
              CustomAppBar(
                  title: widget.movie.title,
                  onBackPress: () {
                    Navigator.of(context).pop();
                  },
                  onMenuPress: () {}),
              Flexible(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[_trilerList(), _movieDetails()],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _trilerList() {
    return Container(
      height: height * 0.35,
      child: Stack(
        children: <Widget>[
          _pageIndicator(),
          PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            controller: _pageController,
            itemBuilder: (context, index) {
              return _trilerStack(index);
            },
          )
        ],
      ),
    );
  }

  Widget _trilerStack(int index) {
    var rotatex = 0.0;

    if (scrollDirection == ScrollDirection.reverse) {
      if (currentPage < (currentPage.ceil() - 0.2)) {
        rotatex = -0.3;
      }
    } else if (scrollDirection == ScrollDirection.forward) {
      if (currentPage > (currentPage.floor() + 0.2)) {
        rotatex = 0.3;
      }
    }

    Offset _offset = Offset(rotatex, 0.0);

    return Transform(
        child: _trilerCard(index),
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_offset.dy)
          ..rotateY(_offset.dx));
  }

  Widget _trilerCard(int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: CustomHero(
          tag: widget.movie.image + (index == 0 ? '' : index.toString()),
          child: Container(
              width: width * .8,
              height: height * .3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: ExactAssetImage(widget.movie.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 1, blurRadius: 2)
                  ])),
        ),
      ),
    );
  }

  Widget _movieDetails() {
    return Padding(
      padding: EdgeInsets.only(
          left: width * .1, right: width * .1, top: 12, bottom: 34),
      child: CustomHero(
        tag: widget.movie.image + 'content',
        child: Container(
          width: width * .8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 2)
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                        widget.movie.title,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 4),
                        Text(
                          widget.movie.display,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "IMDB: ${widget.movie.imdb.toString()}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(widget.movie.gendres,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Opacity(
                  opacity: _opacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _offset.value),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            color: Colors.blueGrey,
                            onPressed: () {},
                            child: Text(
                              "SESSION TIMES",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          InkWell(
                            child: Container(child: Icon(Icons.share)),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(widget.movie.desc,
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Stars:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(widget.movie.desc,
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageIndicator() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SliderIndicator(
          length: 4,
          activeIndex: currentPage.round(),
          displayIndicatorSize: 6,
          displayIndicatorColor: Colors.black38,
        ));
  }
}
