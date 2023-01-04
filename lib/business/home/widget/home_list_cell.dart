
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/home_media_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeListCell extends StatefulWidget {
  final HomeMediaModel model;
  final int idx;
  const HomeListCell(this.model, this.idx, {Key? key}) : super(key: key);

  @override
  State<HomeListCell> createState() => _HomeListCellState();
}

class _HomeListCellState extends State<HomeListCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.idx == 0 ? const WelcomeBannerWidget() : Container(height: 32,color: Theme.of(context).backgroundColor,),
        Center(child: CommonFadeInImage(widget.model.imageUrl?.s ?? "",fit: BoxFit.cover,)),
        // Padding(
        //   padding: const EdgeInsets.only(left: 25,top: 24),
        //   child: Text( "•  "+ (widget.model.title?.s ?? ""),style: TextStyle(
        //       fontFamily: FontFamily.montserrat,
        //       fontWeight: FontWeightExtension.light,
        //       fontSize: 17,
        //       color: Theme.of(context).textTheme.headline1?.color
        //   ),textAlign: TextAlign.left,),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 25,top: 16),
          child: RichText(text: TextSpan(children: [
            TextSpan(
                text: "• ", style: TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: FontWeightExtension.light,
                fontSize: 27,
                color: Theme.of(context).textTheme.headline1?.color,
            )),
            TextSpan(
                text: (widget.model.title?.s ?? ""), style: TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: FontWeightExtension.light,
                fontSize: 17,
                color: Theme.of(context).textTheme.headline1?.color,
            )),
          ]),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25,top: 8,right: 15,bottom: 28),
          child: Text(widget.model.content?.s ?? "",style: TextStyle(
              fontFamily: FontFamily.montserrat,
              fontWeight: FontWeightExtension.light,
              fontSize: 13,
              color: Theme.of(context).textTheme.headline4?.color
          ),textAlign: TextAlign.left,),
        ),
      ],
    );
  }
}

class WelcomeBannerWidget extends StatelessWidget {
  const WelcomeBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Column(
        children:  [
          const SizedBox(height: 40,),
          Obx((){
            return AutoSizeText(
              S.of(context).home_welcome_name(CognitoManager.instance.name.value),
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 20,
                  color: Theme.of(context).textTheme.headline1?.color
              ),
              maxLines: 1,
            );
          }),
          const SizedBox(height: 9,),
          Text(
              S.of(context).home_welcome_subtitle,
            style: TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: FontWeightExtension.light,
                fontSize: 13,
              color: Theme.of(context).textTheme.headline3?.color

            ),
          ),
        ],
      ),
    );
  }
}
