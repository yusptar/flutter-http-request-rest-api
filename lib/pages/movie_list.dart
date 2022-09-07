import 'package:flutter/material.dart';
import 'package:flutter_http_request_rest_api/pages/movie_detail.dart';
import 'package:flutter_http_request_rest_api/service/http_service.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int? moviesCount;
  List? movies;
  HttpService service = HttpService();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = "https://image.tmdb.org/t/p/w500";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: ListView.builder(
        itemCount: moviesCount ?? 0,
        itemBuilder: (context, int position) {
          return Card(
            margin: const EdgeInsets.all(10),
            color: Colors.blueGrey[700],
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(image + movies![position].posterPath),
              ),
              title: Text(
                movies![position].title,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.arrow_right_alt_sharp),
              subtitle: Text(
                movies![position].voteAverage.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => MovieDetail(movies![position]));
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}
