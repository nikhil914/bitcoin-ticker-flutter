import 'networkHelper.dart';

class Bitcoin {
  Future<dynamic> bitcoinPrice(String currency) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currency');

    var bitcoinPrice = await networkhelper.getData();
    return bitcoinPrice;
  }

  Future<dynamic> etheriumPrice(String currency) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/ETH$currency');

    var bitcoinPrice = await networkhelper.getData();
    return bitcoinPrice;
  }

  Future<dynamic> literiumPrice(String currency) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/LTC$currency');

    var bitcoinPrice = await networkhelper.getData();
    return bitcoinPrice;
  }
}
