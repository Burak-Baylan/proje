import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  String filmId;
  String filmBannerLink;
  String userId;
  int ticketCount;
  String ticketDate;
  String filmName;
  Timestamp purchaseDate;

  TicketModel({
    required this.filmId,
    required this.userId,
    required this.filmBannerLink,
    required this.ticketCount,
    required this.ticketDate,
    required this.filmName,
    required this.purchaseDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        filmId: json['film_id'] as String,
        userId: json['user_id'] as String,
        ticketCount: json['ticket_count'] as int,
        ticketDate: json['ticket_date'] as String,
        filmName: json['film_name'] as String,
        purchaseDate: json['purchase_date'] as Timestamp,
        filmBannerLink: json['film_banner_link'] as String,
      );

  Map<String, dynamic> toJson() => {
        'film_id': filmId,
        'user_id': userId,
        'ticket_count': ticketCount,
        'ticket_date': ticketDate,
        'film_name': filmName,
        'purchase_date': purchaseDate,
        'film_banner_link': filmBannerLink,
      };
}
