import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:go_skiing/global/models/rank_model.dart';

class RankService {
  static const String fileName = 'ranking.json';

  Future<File> getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    if (!await file.exists()) {
      final assetData = await rootBundle.loadString('assets/data/ranking.json');
      await file.writeAsString(assetData);
    }

    log(file.path);
    return file;
  }

  Future<List<RankModel>> getRank() async {
    final file = await getFile();
    final content = await file.readAsString();

    if (content.trim().isEmpty) {
      return [];
    }

    final decoded = jsonDecode(content);

    if (decoded is! List) {
      return [];
    }

    return decoded.map((e) => RankModel.fromJson(e)).toList();
  }

  Future<void> save(List<RankModel> ranks) async {
    final file = await getFile();
    final temp = File('${file.path}.tmp');

    await temp.writeAsString(jsonEncode(ranks.map((e) => e.toJson()).toList()));

    await temp.rename(file.path);
  }

  Future<void> addRank(RankModel rank) async {
    final ranks = await getRank();
    ranks.add(rank);
    await save(ranks);
  }
}
