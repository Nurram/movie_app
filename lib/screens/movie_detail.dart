import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/utils/api_provider.dart';
import 'package:movie_app/utils/global_style.dart';
import 'package:movie_app/widgets/error_text.dart';

import '../models/movie_detail_response.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  final String category;

  const MovieDetail({Key? key, required this.movieId, required this.category})
      : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  String _category = "";

  @override
  void initState() {
    _category = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiProvider();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _category == 'movie'
              ? apiClient.getMovieDetail(widget.movieId)
              : apiClient.getTvDetail(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MovieDetailResponse data = snapshot.data as MovieDetailResponse;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          "https://image.tmdb.org/t/p/original${data.posterPath}",
                          height: 480,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        GlobalStyle.buildGradientBottomToTop(480),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    _buildDetailBody(data, context),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ErrorText(
                errrorMsg: snapshot.error.toString(),
              );
            }
          },
        ),
      ),
    );
  }

  Padding _buildDetailBody(MovieDetailResponse data, BuildContext context) {
    final favouritesBox = Hive.box('favourites');
    final Map<String, dynamic>? savedMovie =
        favouritesBox.get('$_category${data.id}');
    bool isFavourite = savedMovie == null ? false : true;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              data.adult ? _buildCardWidget(null, 'Adult') : const Text(''),
              _buildCardWidget(null, data.genres[0].name),
              _buildCardWidget(
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  data.voteAverage.toString()),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    isFavourite
                        ? {
                            favouritesBox.delete('$_category${data.id}'),
                            _showSnackbar(
                              Text('Success delete $_category!'),
                            )
                          }
                        : {
                            favouritesBox.put(
                                '$_category${data.id}', data.toJson()),
                            _showSnackbar(
                              Text('Success save $_category!'),
                            )
                          };

                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(data.overview)
        ],
      ),
    );
  }

  Card _buildCardWidget(Icon? leading, String text) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            leading != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: leading,
                  )
                : const Text(''),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }

  _showSnackbar(Widget contentToShow) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: contentToShow,
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
