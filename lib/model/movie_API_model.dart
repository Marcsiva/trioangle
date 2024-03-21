class MovieModel{
  String title;
  String imageUrl;
  String description;

  MovieModel({
    required this.title,
    required this.imageUrl,
    required this.description,
});
  factory MovieModel.fromJson(Map<String,dynamic>json){
    return MovieModel(
        title: json['title']??"",
        imageUrl: json['images']['jpg']['image_url']??"",
        description: json['synopsis']??"");
  }

}