import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';

class CommonTextSliver extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? voidCallBack;
  final Widget? rightIconWidget;
  const CommonTextSliver({Key? key,this.text = "",this.isSelected = false,this.voidCallBack,this.rightIconWidget}) : super(key: key);

  @override
  _CommonTextSliverState createState() => _CommonTextSliverState();
}

class _CommonTextSliverState extends State<CommonTextSliver> {
  @override
  Widget build(BuildContext context) {
    Widget rightIconWidget = Container();
    if(widget.rightIconWidget == null){
      if(widget.isSelected == false){
        rightIconWidget =  Image.asset(
          Assets.images.common.rightArrowBlack1.path,
          width: 15,
          height: 15,
        );
      }else{
        rightIconWidget =  Icon(Icons.check,color: Theme.of(context).primaryColor,size: 18,);
      }
    }else{
      rightIconWidget = widget.rightIconWidget!;
    }



    return GestureDetector(
      onTap: (){
        if(widget.voidCallBack != null){
          widget.voidCallBack!();
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  color: widget.isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.headline1!.color, fontSize: 15,
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400),
            ),
            Spacer(),
            rightIconWidget
          ],
        ),
      ),
    );
  }
}
