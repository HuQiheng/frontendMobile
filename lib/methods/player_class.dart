class Player {
  final String email;
  final String profileImageUrl;
  final String name;

  Player(
      {required this.email,
      this.profileImageUrl = '/profile.svg',
      required this.name});

  factory Player.fromEmailNamePicture(
      String email, String name, String picture) {
    return Player(email: email, name: name, profileImageUrl: picture);
  }
}
