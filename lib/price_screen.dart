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

  var price;
  var data;
  var bitcoinprice;
  Bitcoin bt = Bitcoin();

  @override
  void initState() {
    super.initState();
    getStart();
    updateUI(bitcoinprice);
  }

  void updateUI(dynamic bitcoinprice) {
    print(bitcoinprice);
    setState(() {
      if (bitcoinprice != null) {
        double tempPrice = double.parse(bitcoinprice['last'].toString());
        price = tempPrice.toInt();
      }
    });
  }

  void getStart() async {
    bitcoinprice = await bt.bitcoinPrice(selectCurrency);
    setState(() {
      updateUI(bitcoinprice);
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
                  '1 BTC = $price $selectCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
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
                  setState(() {
                    updateUI(bitcoinprice);
                    print(value);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
