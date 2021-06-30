import 'package:flutter/material.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Screens/ScreenArguments/VendorScreenArguments.dart';
import 'package:vegemarket/Screens/vendor_page/vendorPage.dart';
import 'package:vegemarket/Services/database/FetchShopList.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({ Key key }) : super(key: key);

  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String textMessage;

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return StreamBuilder<List<UserData>>(
      stream: SellerListGetter().sellerListData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        } else {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.amber[700],
            ),
            child: Column(
              children: [

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          key: formKey,
                          validator: (val){
                            if (val == null){
                              return "You did not enter anything in the freedom wall.";
                            } else {
                              textMessage = val;
                              return null;
                            }
                          },
                          controller: _controller,
                          onChanged: (text) {
                            //print("Current text is: $text");
                            textMessage = text;
                          },
                          cursorColor: Color(0xfff77272),
                            style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xffff8383),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.red[300]),
                              hintText: "Write anything here!",
                              fillColor: Colors.white,
                            ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextButton.icon(
                              onPressed: () {
                                if (_controller.value.text != "")
                                {
                                  // TODO: What happens if the send button is pressed?
                                }
                              },
                              icon: Icon(Icons.textsms_rounded, color: Colors.white),
                              label: Text("Write", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextButton.icon(
                              onPressed: () {
                                _controller.clear();
                              },
                              icon: Icon(Icons.clear_rounded, color: Colors.white),
                              label: Text("Clear", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                            )
                          ),
                        ]
                      ),

                    ],
                  ),

                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(12),
                    // Checks if snapshot.data is null,
                    // if yes then set itemCount to 0 
                    // else set itemCount to length
                    itemCount: (snapshot.data == null) ? 0 : snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            VendorPage.routeName, 
                            arguments: VendorScreenArguments(
                              uid: snapshot.data[index].uid,
                              name: snapshot.data[index].name,
                            )
                          );
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/img/default_profile_picture.jpg',
                                    image: snapshot.data[index].profilePictureLink,
                                  ),
                                ),
                                Text(snapshot.data[index].username),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            )
          )
        );
        }
        
      }
    );
  }
}