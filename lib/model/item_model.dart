
class Item {
  final String game;
  final String name;
  final int score;

  const Item({
    required this.game,
    required this.name,
    required this.score,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      game: json['game'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
    );
  }
}
