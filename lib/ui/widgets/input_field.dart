import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.note,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String note;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: headingStyle),
            Container(
              padding: EdgeInsets.only(left: 14),
              margin: const EdgeInsets.only(top: 8),
              width: SizeConfig.screenWidth,
              height: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        cursorColor: Get.isDarkMode? Colors.grey[100]:Colors.grey[700],
                    controller: controller,
                    readOnly: widget != null ? true:false,
                    autofocus: false,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: note,
                      hintStyle: subTitleStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.theme.backgroundColor,width: 0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: context.theme.backgroundColor,width: 0),
                      ),
                    ),
                  )),
                  widget ?? Container(),
                ],
              ),
            ),
          ],
        ));
  }
}
