import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../model/movie_API_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel? data;
  const MovieDetailScreen({super.key, this.data});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Container(
            height: screenHeight * 0.5,
            width: screenWidth * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.data?.imageUrl ?? ""),
                  fit: BoxFit.fill),
            ),
          ),
          ListTile(
            title: Text(
              widget.data?.title ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            trailing: const Icon(Icons.share,color: Colors.white,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              widget.data?.description ?? "",
              expandText: "Read more",
              collapseText: 'Read less',
              maxLines: 5,
              linkColor: Colors.blue,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
