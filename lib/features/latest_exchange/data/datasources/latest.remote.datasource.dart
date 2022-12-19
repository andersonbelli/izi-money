import 'package:izi_money/core/http/http_manager.dart';
import 'package:izi_money/core/utils/server_config.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';

abstract class ILatestRemoteDataSource {
  Future<LatestExchangeModel> getLatestExchange(String base);

  Future<RatesModel> getNewCurrency(String currency);
}

class LatestRemoteDataSource extends ILatestRemoteDataSource {
  final HttpManager http;

  LatestRemoteDataSource({required this.http});

  @override
  Future<LatestExchangeModel> getLatestExchange(String base) async {
    if (http.mock) {
      return LatestExchangeModel(
        success: true,
        base: 'USD',
        date: '2022-12-03 12:25:19.922692',
        ratesModel: const RatesModel(
          BRL: 5.506377,
          BTC: 0.000062,
          CLP: 920.346155,
          EUR: 0.95,
          MXN: 19.954985,
          USD: 1,
        ),
      );
    }

    final response =
        await http.get('${ServerConfig.LATEST_ENDPOINT}base=$base');

    (response as Map<String, dynamic>)
        .update('date', (value) => DateTime.now().toString());
    return LatestExchangeModel.fromJson(response);
  }

  @override
  Future<RatesModel> getNewCurrency(String currency) async {
    final response =
        await http.get('${ServerConfig.LATEST_ENDPOINT}symbols=$currency');

    return RatesModel.fromJson((response as Map<String, dynamic>));
  }
}

/*
* {
   "motd":{
      "msg":"If you or your company use this project or like what we doing, please consider backing us so we can continue maintaining and evolving this project.",
      "url":"https://exchangerate.host/#/donate"
   },
   "success":true,
   "base":"EUR",
   "date":"2022-11-15",
   "rates":{
      "AED":3.793623,
      "AFN":91.079465,
      "ALL":117.085194,
      "AMD":407.340331,
      "ANG":1.855651,
      "AOA":513.405798,
      "ARS":167.062856,
      "AUD":1.541554,
      "AWG":1.858941,
      "AZN":1.755857,
      "BAM":1.957843,
      "BBD":2.065889,
      "BDT":105.286294,
      "BGN":1.956928,
      "BHD":0.3893,
      "BIF":2129.742089,
      "BMD":1.032988,
      "BND":1.41708,
      "BOB":7.113473,
      "BRL":5.506377,
      "BSD":1.033662,
      "BTC":0.000062,
      "BTN":83.623731,
      "BWP":13.368452,
      "BYN":2.599871,
      "BZD":2.074768,
      "CAD":1.37388,
      "CDF":2114.802502,
      "CHF":0.975141,
      "CLF":0.033872,
      "CLP":920.346155,
      "CNH":7.270731,
      "CNY":7.274036,
      "COP":4941.791076,
      "CRC":627.256767,
      "CUC":1.033345,
      "CUP":26.592701,
      "CVE":111.403475,
      "CZK":24.298884,
      "DJF":183.245894,
      "DKK":7.438415,
      "DOP":55.874209,
      "DZD":143.402628,
      "EGP":25.256954,
      "ERN":15.490518,
      "ETB":54.967895,
      "EUR":1,
      "FJD":2.304107,
      "FKP":0.877325,
      "GBP":0.877727,
      "GEL":2.78937,
      "GGP":0.877746,
      "GHS":14.924821,
      "GIP":0.877801,
      "GMD":63.356502,
      "GNF":8868.385318,
      "GTQ":8.049345,
      "GYD":215.344812,
      "HKD":8.090118,
      "HNL":25.439406,
      "HRK":7.544025,
      "HTG":139.312708,
      "HUF":408.646122,
      "IDR":16065.765891,
      "ILS":3.540878,
      "IMP":0.877125,
      "INR":84.047774,
      "IQD":1502.289553,
      "IRR":43786.637324,
      "ISK":150.889107,
      "JEP":0.877543,
      "JMD":158.137866,
      "JOD":0.732593,
      "JPY":144.851648,
      "KES":125.473522,
      "KGS":86.823105,
      "KHR":4257.17569,
      "KMF":495.542909,
      "KPW":929.43364,
      "KRW":1362.903778,
      "KWD":0.318377,
      "KYD":0.858299,
      "KZT":474.779093,
      "LAK":17801.27155,
      "LBP":1556.27089,
      "LKR":376.214422,
      "LRD":158.829826,
      "LSL":17.860637,
      "LYD":5.130665,
      "MAD":11.061857,
      "MDL":19.737869,
      "MGA":4417.687487,
      "MKD":61.667428,
      "MMK":2161.579854,
      "MNT":3518.38635,
      "MOP":8.308889,
      "MRU":39.09434,
      "MUR":45.387246,
      "MVR":15.914428,
      "MWK":1057.237028,
      "MXN":19.954985,
      "MYR":4.738023,
      "MZN":65.989624,
      "NAD":17.866303,
      "NGN":456.752342,
      "NIO":37.05416,
      "NOK":10.348979,
      "NPR":133.808503,
      "NZD":1.689498,
      "OMR":0.398484,
      "PAB":1.033111,
      "PEN":3.971153,
      "PGK":3.628701,
      "PHP":59.232623,
      "PKR":228.125265,
      "PLN":4.710563,
      "PYG":7243.023936,
      "QAR":3.748614,
      "RON":4.906348,
      "RSD":117.264935,
      "RUB":62.494512,
      "RWF":1100.840711,
      "SAR":3.881864,
      "SBD":8.493047,
      "SCR":13.805451,
      "SDG":588.125177,
      "SEK":10.82135,
      "SGD":1.418611,
      "SHP":0.877686,
      "SLL":18242.710904,
      "SOS":585.138025,
      "SRD":31.080049,
      "SSP":134.519959,
      "STD":23570.420655,
      "STN":25.043533,
      "SVC":9.008065,
      "SYP":2594.700133,
      "SZL":17.86267,
      "THB":36.844706,
      "TJS":10.344308,
      "TMT":3.614713,
      "TND":3.318792,
      "TOP":2.450476,
      "TRY":19.212388,
      "TTD":6.983714,
      "TWD":32.043579,
      "TZS":2400.392054,
      "UAH":38.016281,
      "UGX":3865.003683,
      "USD":1.033599,
      "UYU":41.307387,
      "UZS":11518.130177,
      "VES":9.585737,
      "VND":25599.998964,
      "VUV":126.258027,
      "WST":2.886038,
      "XAF":655.843353,
      "XAG":0.047233,
      "XAU":0.001514,
      "XCD":2.791149,
      "XDR":0.768814,
      "XOF":655.843371,
      "XPD":0.001992,
      "XPF":119.311514,
      "XPT":0.00159,
      "YER":258.43469,
      "ZAR":17.830044,
      "ZMW":16.917504,
      "ZWL":332.530408
   }
}
* */
