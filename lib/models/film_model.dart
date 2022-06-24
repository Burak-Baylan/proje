class FilmModel {
  String bannerLink;
  double imdb;
  String name;
  String subject;
  String cast;
  double duration;
  String type;
  String director;
  String publishedDate;
  String trailerLink;
  String filmId;

  FilmModel({
    required this.bannerLink,
    required this.imdb,
    required this.name,
    required this.subject,
    required this.cast,
    required this.duration,
    required this.type,
    required this.director,
    required this.publishedDate,
    required this.trailerLink,
    required this.filmId,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
        bannerLink: json['afis_link'] as String,
        imdb: json['imdb'] as double,
        name: json['isim'] as String,
        subject: json['konu'] as String,
        cast: json['oyuncular'] as String,
        duration: json['sure'] as double,
        type: json['tur'] as String,
        director: json['yonetmen'] as String,
        publishedDate: json['vizyon_tarihi'] as String,
        trailerLink: json['fragman_link'] as String,
        filmId: json['film_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'afis_link': bannerLink,
        'imdb': imdb,
        'isim': name,
        'konu': subject,
        'oyuncular': cast,
        'sure': duration,
        'tur': type,
        'yonetmen': director,
        'vizyon_tarihi': publishedDate,
        'fragman_link': trailerLink,
        'film_id': filmId,
      };
}
