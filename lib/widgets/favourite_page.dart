import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/models/movie_detail_response.dart';
import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/screens/movie_detail.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesBox = Hive.box('favourites');
    final savedDatas = favouritesBox.values;

    return _buildListView(savedDatas);
  }

  SizedBox _buildListView(Iterable<dynamic> data) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => _buildListItem(
              context,
              data.elementAt(index) as Map<String, dynamic>,
            )),
      ),
    );
  }

  SizedBox _buildListItem(BuildContext context, Map<String, dynamic> jsonData) {
    MovieDetailResponse data = MovieDetailResponse.fromJson(jsonData);

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
