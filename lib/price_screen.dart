import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'bitcoinPrice.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'USD';
  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItem.add(newItem);
    }
    return dropDownItem;
  }

  var btcrate;
  var ethrate;
  var ltcrate;
  var data;
  var bitcoinprice;
  var ethPrice;
  var ltcPrice;
  Bitcoin bt = Bitcoin();

  @override
  void initState() {
    super.initState();
    getStart();
    updateUI(bitcoinprice, ethPrice, ltcPrice);
  }

  void updateUI(dynamic bitcoinprice, dynamic ethPrice, dynamic ltcPrice) {
    setState(() {
      if (bitcoinprice != null || ethPrice != null || ltcPrice != null) {
        double tempbtcPrice = double.parse(bitcoinprice['last'].toString());
        double tempethPrice = double.parse(ethPrice['last'].toString());
        double templtcPrice = double.parse(ltcPrice['last'].toString());
        btcrate = tempbtcPrice.toInt();
        ethrate = tempethPrice.toInt();
        ltcrate = templtcPrice.toInt();
      }
    });
  }

  void getStart() async {
    bitcoinprice = await bt.bitcoinPrice(selectCurrency);
    ethPrice = await bt.etheriumPrice(selectCurrency);
    ltcPrice = await bt.literiumPrice(selectCurrency);
    setState(() {
      updateUI(bitcoinprice, ethPrice, ltcPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcrate $selectCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.yellowAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethrate $selectCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightGreenAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcrate $selectCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectCurrency,
                items: getDropDownItems(),
                onChanged: (value) async {
                  selectCurrency = value;
                  bitcoinprice = await bt.bitcoinPrice(selectCurrency);
                  ethPrice = await bt.etheriumPrice(selectCurrency);
                  ltcPrice = await bt.literiumPrice(selectCurrency);

                  setState(() {
                    updateUI(bitcoinprice, ethPrice, ltcPrice);
                    print(value);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
