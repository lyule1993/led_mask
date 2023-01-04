import 'package:flutter/material.dart';

class CommonSelectButtonWithArrow extends StatefulWidget {
  final String buttonStr;
  final String? titleStr;
  final GestureTapCallback? onTap;

  const CommonSelectButtonWithArrow({
    Key? key,
    this.titleStr,
    this.onTap,
    this.buttonStr = "Time",
  }) : super(key: key);

  @override
  _CommonSelectButtonWithArrowState createState() =>
      _CommonSelectButtonWithArrowState();
}

class _CommonSelectButtonWithArrowState
    extends State<CommonSelectButtonWithArrow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 24,
        padding: EdgeInsets.only(left: 10, right: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).dividerColor),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          children: [
            widget.titleStr != null
                ? Text(widget.titleStr!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.headline3!.color,
                    ))
                : Container(),
            Text(widget.buttonStr,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.headline1!.color,
                )),
            Icon(
              Icons.arrow_drop_down_outlined,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
