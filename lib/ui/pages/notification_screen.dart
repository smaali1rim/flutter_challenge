import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload});

  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _playload = '';

  @override
  void initState() {
    super.initState();
    _playload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode ? Colors.white : Colors.black,)),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _playload.split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'hello emy',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode ? Colors.white : darkGreyClr),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'you have a reminder',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w200,
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: primaryClr),
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(children: [
                        Icon(Icons.text_format,size: 30,color: Colors.white,),
                        SizedBox(width: 10),
                        Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color:  Colors.white ),
                        ),

                      ],),
                      const SizedBox(height: 10),
                      Text(
                        _playload.split('|')[0],
                        style: TextStyle(color:  Colors.white ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.description,size: 30,color: Colors.white,),
                        SizedBox(width: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color:  Colors.white ),
                        ),

                      ],),
                      const SizedBox(height: 10),
                      Text(
                        _playload.split('|')[1],
                        style: TextStyle(color:  Colors.white,  ),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.calendar_today_outlined,size: 30,color: Colors.white,),
                        SizedBox(width: 10),
                        Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color:  Colors.white ),
                        ),

                      ],),
                      const SizedBox(height: 10),
                      Text(
                        _playload.split('|')[2],
                        style: TextStyle(color:  Colors.white,  ),textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ) ,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}
