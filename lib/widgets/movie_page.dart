import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/screens/movie_detail.dart';
import 'package:movie_app/utils/api_provider.dart';
import 'package:movie_app/utils/global_style.dart';
import 'package:movie_app/widgets/error_text.dart';

class MoviePage extends StatelessWidget {
  final ApiProvider _apiProvider = ApiProvider();

  MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _apiProvider.getUpcomingMovie(),
        _apiProvider.getTopRatedMovie(),
        _apiProvider.getTrendingMovie()
      ]),
      builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
          return ErrorText(errrorMsg: snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          MovieResponse upcomingMovie = snapshot.data![0] as MovieResponse;
          MovieResponse trendingMovie = snapshot.data![2] as MovieResponse;
          MovieResponse topRatedMovie = snapshot.data![1] as MovieResponse;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coming Soon',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upcomingMovie.results.length,
                  itemBuilder: ((context, index) {
                    List<Result> result = upcomingMovie.results;
                    return _buildHeaderItem(
                        context, Theme.of(context), result[index]);
                  }),
                ),
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
              _buildListView(context, trendingMovie),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Top Rated',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildListView(context, topRatedMovie),
            ],
          );
        }
      }),
    );
  }

  SizedBox _buildHeaderItem(
      BuildContext context, ThemeData theme, Result data) {
    return SizedBox(
      width: 325,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MovieDetail(category: "movie", movieId: data.id),
          ),
        ),
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
                  width: 325,
                  fit: BoxFit.cover,
                ),
              ),
              GlobalStyle.buildGradientTopToBottom(),
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
      ),
    );
  }

  SizedBox _buildListView(BuildContext context, MovieResponse data) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .33,
      child: ListView.builder(
        itemCount: data.results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) =>
            _buildListItem(context, data.results[index])),
      ),
    );
  }

  SizedBox _buildListItem(BuildContext context, Result data) {
    return SizedBox(
      width: 140,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MovieDetail(category: "movie", movieId: data.id),
          ),
        ),
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
      ),
    );
  }
}
