class PodcastShow {
  PodcastShow({
    this.artistName,
    this.showName,
    this.imageUrl,
    this.feedUrl,
    this.releaseDate,
    this.contentAdvisoryRating,
    this.country,
    this.genres,
  });
  final String artistName;
  final String feedUrl;
  final String showName;
  final String imageUrl;
  final DateTime releaseDate;
  final String contentAdvisoryRating;
  final String country;
  Set<String> genres;
}
