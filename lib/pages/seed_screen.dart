import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/Functions_and_route.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieeecrop/config/config.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class seed_screen extends StatefulWidget with DrawerStates{
  @override
  _seed_screenState createState() => _seed_screenState();
}

class _seed_screenState extends State<seed_screen> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(int amount,String p_name){
    var options = {
      "key" : "rzp_test_CYY7qC5KKthyFt",
      "amount" :amount*100,
      "name" : "IEEE Maati",
      "description":"Payment for $p_name",
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(){
    print("Pament success");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet", context);
  }
  @override
  Widget build(BuildContext context) {
    final Color background = Colors.deepOrange.withOpacity(0.8);
    final Color fill = Colors.orangeAccent;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = 58.23; // fills 56.23% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Container(
        child: FutureBuilder(
          future: getseed(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(), //Circular progress indicator
              );
            } else if (snapshot.data['Data'] != null) {
               //Storing token in local storage
              return Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data['Data'].length, //list view declaration
                              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        width: SizeConfig.screenWidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Colors.black.withOpacity(0.5),
                                                blurRadius: 7.0,
                                                offset: Offset(0, 3),
                                              ),
                                            ]),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 10, right: 10),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Seller: ${snapshot.data['Data'][index]['Seller name']}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Roberto",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),

                                                  ]),
                                            ),
                                            SizedBox(height: 10,),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 25, right: 15),
                                                      child: Container(
                                                        height: 140,
                                                        width:180,
                                                        child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(
                                                              snapshot.data['Data'][index]['Image Code']),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.only(right: 10, bottom: 10),
                                                      child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Column(children: [
                                                              Text(
                                                                snapshot.data['Data'][index]['Seed Name'],
                                                                style: TextStyle(
                                                                  color: Colors.green.withOpacity(0.8),
                                                                  fontSize: 18,
                                                                  fontFamily: "Roberto",
                                                                  fontWeight: FontWeight.w600
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                10,
                                                              ),
                                                              Column(children: [
                                                                Text(
                                                                  "M.R.P",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 12,
                                                                    fontFamily: "Roberto",
                                                                  ),
                                                                ),
                                                                Text(
                                                                  snapshot.data['Data'][index]['Cost'],
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    fontFamily: "Roberto",
                                                                  ),
                                                                ),
                                                              ]),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                "Quantity: 10 kg",
                                                                style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "Roberto",
                                                                ),
                                                              ),
                                                            ]),
                                                            SizedBox(
                                                              width: 10,
                                                            ),

                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Description:",
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "Roberto",
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                              snapshot.data['Data'][index]['Desciption'],
                                                              style: TextStyle(color: Colors.green)),
                                                        ],
                                                        style: DefaultTextStyle.of(context).style,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(top: 10, bottom: 10,left: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: <Widget>[
                                                                Text(
                                                                  "Rating:",
                                                                  style: TextStyle(
                                                                    color: Colors.black54,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontFamily: "Roberto",
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 10),
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap:(){
                                                                openCheckout(210,snapshot.data['Data'][index]['Seed Name']);
                                                              },
                                                              child: Container(
                                                                height:
                                                                40,
                                                                width:
                                                                100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.orange,
                                                                    borderRadius:
                                                                    BorderRadius.circular(5)),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.only(left: 7),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Buy now",
                                                                          style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            fontFamily: "Roberto",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                      width:
                                                                      15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              3,
                                                            ),
                                                            Text(
                                                              "Min. Order 10kg",
                                                              style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: "Roberto",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                );
                              })),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15,bottom: 15),
                      child: FloatingActionButton(
                        tooltip: "Maati smart search",
                        child: Icon(Icons.search),
                        backgroundColor: Colors.amberAccent,
                        onPressed: () {
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .cam);
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return NetworkGiffyDialog(
                image: Image.network(
                  "https://media.giphy.com/media/l4pLY0zySvluEvr0c/giphy.gif",
                  fit: BoxFit.cover,
                ),
                entryAnimation: EntryAnimation.TOP_LEFT,
                title: Text(
                  translations.text('login.er'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  translations.text('login.des'),
                  textAlign: TextAlign.center,
                ),
                onlyOkButton: true,
                onOkButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
        ));
  }
}
