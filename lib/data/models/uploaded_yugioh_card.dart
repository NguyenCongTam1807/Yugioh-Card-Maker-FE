import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

class UploadedYugiohCard {
  final String? id;
  final YugiohCard? yugiohCard;
  final int? uploadedAt;

  const UploadedYugiohCard({
    this.id,
    this.yugiohCard,
    this.uploadedAt,
  });

  factory UploadedYugiohCard.fromJson(Map<String, dynamic> json) {
    return UploadedYugiohCard(
        id: json['id'],
        yugiohCard: YugiohCard.fromJson(
            {
              'name': json['name'],
              'attribute': json['attribute'],
              'imagePath': json['imagePath'],
              'monsterType': json['monsterType'],
              'description': json['description'],
              'atk': json['atk'],
              'def': json['def'],
              'creatorName': json['creatorName'],
              'cardType': json['cardType'],
              'level': json['level'],
              'effectType': json['effectType'],
              'linkArrows': json['linkArrows'],
              'thumbnailUrl': json['thumbnailUrl'],
              'fullCardImageUrl': json['fullCardImageUrl'],
            }
        ),
        uploadedAt: json['uploadedAt']
    );
  }
}