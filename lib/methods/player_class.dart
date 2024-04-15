class Player {
  final String email;
  final String profileImageUrl;

  Player({required this.email, this.profileImageUrl = '/profile.svg'});

  factory Player.fromEmail(String email) {
    return Player(email: email);
  }
}
