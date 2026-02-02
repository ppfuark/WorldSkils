class RankModel {
  String? playerName;
  int? coin;
  int? duration;

  RankModel({
    required this.coin,
    required this.playerName,
    required this.duration,
  });

  RankModel.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    playerName = json['player_name'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    return {'coin': coin, 'player_name': playerName, 'duration': duration};
  }
}
