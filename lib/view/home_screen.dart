import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:trioangle/model/movie_API_model.dart';
import 'package:trioangle/serviece/movie_API_service.dart';
import 'package:trioangle/serviece/phone_auth_service.dart';
import 'package:trioangle/view/movie_details_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chooseIndex = 1;
  final InfiniteScrollController _controller = InfiniteScrollController();
  final PhoneAuthService _authService = PhoneAuthService();
  final MovieService _service = MovieService();
  List<MovieModel> movieList = [];
  final videoURL = "https://youtu.be/4xkhPieAbq0?si=J5NDDd9KNJLiW6_k";

 late YoutubePlayerController controller;

  Future<void> movieFetching() async {
    final movie = await _service.fetchMovies();
    setState(() {
      movieList = movie;
    });
  }

  @override
  void initState() {
    movieFetching();
    final videoId = YoutubePlayer.convertUrlToId(videoURL);

    controller = YoutubePlayerController(initialVideoId: videoId!,
    flags: const YoutubePlayerFlags(
      autoPlay: false
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textButton("Series", 0),
              textButton("File", 1),
              textButton("My List", 2),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Coming Soon",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Container(
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 25),
            child: Text(
              "Trending Now",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: screenHeight * 0.4,
            width: screenWidth * 1,
            child: FutureBuilder(
              future: _service.fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child:
                        Text('User is not logged in or data is unavailable.'),
                  );
                } else {
                  return InfiniteCarousel.builder(
                      itemCount: movieList.length,
                      itemExtent: 200,
                      center: true,
                      anchor: 0.0,
                      velocityFactor: 0.3,
                      onIndexChanged: (index) {},
                      controller: _controller,
                      loop: false,
                      axisDirection: Axis.horizontal,
                      itemBuilder: (context, itemIndex, realIndex) {
                        final data = movieList[itemIndex];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(data: data,)));
                            },
                            child: Container(
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(data.imageUrl),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget textButton(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          chooseIndex = index;
          _authService.signOut();
        });
      },
      child: Text(
        title,
        style:
            TextStyle(color: chooseIndex == index ? Colors.red : Colors.white),
      ),
    );
  }
}
