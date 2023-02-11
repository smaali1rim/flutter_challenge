import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatefulWidget {
   TaskTile(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool? isChecked=false;
  void checkboxCallback(bool? checkboxState) {
    setState(() {
      // Return checkboxState. If it's null, return false
      isChecked = checkboxState ?? false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20),
        ),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(widget.task.color),
          ),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.task.startTime}-${widget.task.endTime}',
                          style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.task.note!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              Checkbox(
                activeColor: Colors.white,
                checkColor:_getBGClr(widget.task.color),
                value: isChecked,
                onChanged: (bool? value){
                  //value returned when checkbox is clicked
                  setState(() {
                    isChecked = value;
                  });
                }
              ),
              // RotatedBox(
              //   quarterTurns: 3,
              //   child: Text(
              //     task.isCompleted == 0 ? 'To Do' : 'Compeleted',
              //     style: GoogleFonts.lato(
              //       textStyle: TextStyle(
              //           fontSize: 10,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
