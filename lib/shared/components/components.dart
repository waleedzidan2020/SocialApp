import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget LogInButton(
        {@required double width = double.infinity,
        Color colorbutton = Colors.blue,
        @required Function()? fun,
        double horizontalPadding = 8.0,
          String? TextButton,
        Color colortext = Colors.white}) =>
    Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        color: colorbutton,
        onPressed: fun,
        child: Text(
          "${TextButton}",
          style: TextStyle(
            color: colortext,
          ),
        ),
      ),
    );

Widget Textfield(
        {TextEditingController? passwordtext,
        @required String? Function(String?)? valid,
        TextInputType? KeyboardType,
        @required String? Label,
        double raduis = 10.0,
        Widget? prefixIcons,
        Widget? suffixIcons,
        Function()? ontap,
        Function(String)? onchange,
        double padding = 8.0,
        Function(String)? Onsubmitted,
        bool HidePass = false}) =>
    Padding(
        padding: EdgeInsets.all(padding),
        child: TextFormField(
          onFieldSubmitted: Onsubmitted,
          onChanged: onchange,
          controller: passwordtext,
          validator: valid,
          onTap: ontap,
          //     (value) {
          //   if (value == "") {
          //     return "El pass ya 5ara  ";
          //   } else {
          //     return null;
          //   }
          // }
          keyboardType: KeyboardType,

          decoration: InputDecoration(
            labelText: Label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(raduis),
            ),
            prefixIcon: prefixIcons,
            suffixIcon: suffixIcons,

            // IconButton(
            //   onPressed: ,
            //   icon: Icon(
            //     Icons.remove_red_eye,
            //     color: Colors.black,
            //   ),
            // )),
          ),
          obscureText: HidePass,
        ));

Widget ItemNews(var s, context) => InkWell(
      onTap: () {
        // Navigateto(context, webview(s["url"]));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,

                  end: Alignment(0.8, 1),

                  colors: <Color>[
                    Color(0xff1f005c),
                    Color(0xff5b0060),
                    Color(0xff870160),
                    Color(0xffac255e),
                    Color(0xffca485c),
                    Color(0xffe16b5c),
                    Color(0xfff39060),
                    Color(0xffffb56b),
                  ],
                  // Gradient from https://learnui.design/tools/gradient-generator.html

                  tileMode: TileMode.mirror,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${s['urlToImage']}"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${s['title']}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: "Oswald",
                            ),
                          ),
                          Text(
                            " ${s['publishedAt']}",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Oswald",
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

void Navigateto(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NaviatAndPush(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

void MessageShop ({@required String? message,Color? BackgroundColor}){
   Fluttertoast.showToast(
      msg: '$message',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BackgroundColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
