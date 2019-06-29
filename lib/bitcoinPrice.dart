import 'networkHelper.dart';

class Bitcoin {
  Future<dynamic> bitcoinPrice(String currency) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currency');

    var bitcoinPrice = await networkhelper.getData();
    return bitcoinPrice;
  }
}
