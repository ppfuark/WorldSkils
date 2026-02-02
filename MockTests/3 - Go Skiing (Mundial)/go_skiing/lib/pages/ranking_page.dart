import 'package:flutter/material.dart';
import 'package:go_skiing/global/models/rank_model.dart';
import 'package:go_skiing/services/rank_service.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final RankService rankService = RankService();

  late Future<List<RankModel>> futureRanking;

  @override
  void initState() {
    super.initState();
    futureRanking = rankService.getRank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ranking")),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)),

                Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),

                Text('Coins', style: TextStyle(fontWeight: FontWeight.bold)),

                Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: futureRanking,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro na busca dos cursos do estudante: ${snapshot.error}",
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        "Nenhum curso ministrado pelo estudante encontrado. ",
                      ),
                    );
                  }

                  final ranking = snapshot.data!;
                  ranking.sort((a, b) => b.duration!.compareTo(a.duration!));

                  return ListView.builder(
                    itemCount: ranking.length,
                    itemBuilder: (context, index) {
                      final rank = ranking[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text((index += 1).toString()),

                                Text(rank.playerName!),

                                Text(rank.coin!.toString()),

                                Text("${rank.duration!} S"),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
