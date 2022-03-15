import 'package:flutter/material.dart';
import 'package:movie_app/utils/global_style.dart';
import 'package:movie_app/widgets/favourite_page.dart';
import 'package:movie_app/widgets/movie_page.dart';
import 'package:movie_app/widgets/tv_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selected = "movie";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'Series',
                        style: _selected == "tv"
                            ? GlobalStyle.primaryTextButtonColor(context)
                            : GlobalStyle.whiteTextButtonColor(),
                      ),
                      onPressed: () {
                        _setSelected("tv");
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        _setSelected("movie");
                      },
                      child: Text(
                        "Movie",
                        style: _selected == "movie"
                            ? GlobalStyle.primaryTextButtonColor(context)
                            : GlobalStyle.whiteTextButtonColor(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _setSelected("list");
                      },
                      child: Text(
                        "Favourite",
                        style: _selected == "list"
                            ? GlobalStyle.primaryTextButtonColor(context)
                            : GlobalStyle.whiteTextButtonColor(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildBody()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setSelected(String selected) {
    setState(() {
      _selected = selected;
    });
  }

  Widget _buildBody() {
    if (_selected == 'movie') {
      return MoviePage();
    } else if (_selected == 'tv') {
      return TvPage();
    } else {
      return FavouritePage();
    }
  }
}
