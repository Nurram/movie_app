import 'package:flutter/material.dart';
import 'package:movie_app/app_client.dart';
import 'package:movie_app/error_text.dart';
import 'package:movie_app/movie_response.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selected = "movie";
  late AppClient _appClient;

  @override
  void didChangeDependencies() {
    _appClient = AppClient();
    super.didChangeDependencies();
  }

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
                            ? _primaryTextButtonColor()
                            : _whiteTextButtonColor(),
                      ),
                      onPressed: () {
                        setSelected("tv");
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setSelected("movie");
                      },
                      child: Text(
                        "Movie",
                        style: _selected == "movie"
                            ? _primaryTextButtonColor()
                            : _whiteTextButtonColor(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setSelected("list");
                      },
                      child: Text(
                        "My List",
                        style: _selected == "list"
                            ? _primaryTextButtonColor()
                            : _whiteTextButtonColor(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  _selected != "tv" ? 'Coming Soon' : 'Airing Today',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                  future: _appClient.getUpcoming(_selected),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      MovieResponse data = snapshot.data as MovieResponse;

                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.results.length,
                          itemBuilder: ((context, index) {
                            List<Result> result = data.results;
                            return _buildHeaderItem(
                                Theme.of(context), result[index]);
                          }),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ErrorText(
                        errrorMsg: snapshot.error.toString(),
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Trending Now',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                    future: _appClient.getTrending(_selected),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        MovieResponse data = snapshot.data as MovieResponse;

                        return SizedBox(
                          height: 270,
                          child: ListView.builder(
                            itemCount: data.results.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) =>
                                _buildListItem(data.results[index])),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ErrorText(
                          errrorMsg: snapshot.error.toString(),
                        );
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildHeaderItem(ThemeData theme, Result data) {
    return SizedBox(
      width: 325,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${data.backdropPath}",
                width: MediaQuery.of(context).size.width - 36,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black45,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ]),
              ),
            ),
            ListTile(
              title: Text(
                data.title,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _buildListItem(Result data) {
    return SizedBox(
      width: 140,
      child: Card(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${data.posterPath}",
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                Text(
                  data.voteAverage.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data.title,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _primaryTextButtonColor() {
    return TextStyle(color: Theme.of(context).colorScheme.primary);
  }

  TextStyle _whiteTextButtonColor() {
    return const TextStyle(color: Colors.white);
  }

  void setSelected(String selected) {
    setState(() {
      _selected = selected;
    });
  }
}
