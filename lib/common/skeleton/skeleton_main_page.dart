import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomePageSkeleton extends StatelessWidget {
  final BuildContext context;
  const HomePageSkeleton({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth =  MediaQuery.of(context).size.width;
    return Column(
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            padding: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              height: 24,
              width: screenWidth * 161 / 375,
              borderRadius: BorderRadius.circular(2)),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              padding: EdgeInsets.only(top: 13,bottom: 23),
              alignment: Alignment.center,
              height: 13,
              width: screenWidth * 248 / 375,
              borderRadius: BorderRadius.circular(2)),
        ),
        SkeletonItem(
          child: Container(
            width: screenWidth,
            height: screenWidth * 232 / 375,
            child: SkeletonAvatar(),
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              padding: EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              height: 24,
              width: screenWidth * 295 / 375,
              borderRadius: BorderRadius.circular(2)),
        ),
        SkeletonParagraph(style: const SkeletonParagraphStyle(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 28),
          spacing: 10,
          lineStyle: SkeletonLineStyle(height: 13)
        ),),
        SkeletonItem(
          child: Container(
            width: screenWidth,
            height: screenWidth * 232 / 375,
            child: SkeletonAvatar(),
          ),
        ),
      ],
    );
  }
}

class SkeletonMainPage {
  /// Member主页的Skeleton
  Widget getSkeletonView() => ListView.builder(
      // padding: padding,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) {
        double screenWidth = MediaQuery.of(context).size.width;
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(8.0),
              child: SkeletonItem(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: screenWidth * 0.13,
                            height: screenWidth * 0.13,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              alignment: Alignment.center,
                              height: 16,
                              width: screenWidth * 0.2,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              alignment: Alignment.center,
                              height: 10,
                              width: screenWidth * 0.16,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        alignment: Alignment.center,
                        height: 24,
                        width: screenWidth * 0.14,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              )),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              margin: const EdgeInsets.only(top: 20),
              child: SkeletonItem(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 25,
                              width: screenWidth * 0.3,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                              height: 10,
                              width: screenWidth * 0.6,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 12,
                                  width: screenWidth * 0.16,
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                            Expanded(child: SizedBox()),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  alignment: Alignment.centerRight,
                                  height: 30,
                                  width: screenWidth * 0.2,
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        }
      });
}
