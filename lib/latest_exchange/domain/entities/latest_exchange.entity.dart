import 'package:izi_money/latest_exchange/domain/entities/rates.entity.dart';

class LatestExchange {
  Motd? motd;
  bool? success;
  String? base;
  String? date;
  Rates? rates;

  LatestExchange({this.motd, this.success, this.base, this.date, this.rates});
}

class Motd {
  String? msg;
  String? url;

  Motd({this.msg, this.url});

  Motd.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['url'] = url;
    return data;
  }
}
