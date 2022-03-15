import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/models/movie_detail_response.dart';
import 'package:movie_app/screens/movie_detail.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesBox = Hive.box('favourites');
    final savedDatas = favouritesBox.toMap();

    return _buildListView(context, savedDatas);
  }

  SizedBox _buildListView(BuildContext context, Map<dynamic, dynamic> data) {
    Iterable<dynamic> keys = data.keys;

    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 300,
          maxCrossAxisExtent: 250,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 8,
        ),
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          String currentKey = keys.elementAt(index);

          return _buildListItem(context, data[currentKey],
              currentKey.contains("movie") ? "movie" : "tv");
        }),
      ),
    );
  }

  InkWell _buildListItem(
      BuildContext context, Map<dynamic, dynamic> jsonData, String category) {
    MovieDetailResponse data = MovieDetailResponse.fromJson(jsonData);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              MovieDetail(category: category, movieId: data.id),
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
}
