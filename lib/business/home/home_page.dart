import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/home/widget/home_drawer.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:awesome_layer_mask/global/home_media_model.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletons/skeletons.dart';

import 'logic/home_page_logic.dart';
import 'widget/home_list_cell.dart';

class HomePage extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage(this.scaffoldKey,{Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageLogic homePageLogic = Get.find<HomePageLogic>();
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  final refreshController = RefreshController();
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homePageLogic.loadHomePageListData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            onRefresh: () async {
              homePageLogic.homeMediaModelList.clear();
              await homePageLogic.loadHomePageListData();
              refreshController.refreshCompleted();
            },
            onLoading: () async {},
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  delegate: SliverTabBarDelegate(context, widget.scaffoldKey),
                  pinned: true,
                  floating: true,
                ),
                Obx(() {
                  if (homePageLogic.homeMediaModelList.isEmpty == true) {
                    return SliverToBoxAdapter(
                        child: Skeleton(
                      shimmerGradient: shimmerGradient,
                      isLoading: true,
                      skeleton: HomePageSkeleton(
                        context: context,
                      ),
                      child: Container(),
                    ));
                  } else {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (content, index) {
                          HomeMediaModel model =
                              homePageLogic.homeMediaModelList.value[index];
                          return HomeListCell(model, index);
                        },
                        //行数
                        childCount: homePageLogic.homeMediaModelList.length,
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        )),
        Obx(() {
          if (homePageLogic.homeMediaModelList.isEmpty == false &&
              globalLogic.isDrawerOpen.value == false) {
            return Positioned(
                bottom: 24,
                left: 32,
                right: 32,
                child: Obx((){
                  if(blueToothLogic.deviceStatus.value == DeviceStatus.connected){
                    return CommonTextButton(
                      text: S.of(context).home_start_treatment,
                      onPressed: () {
                        globalLogic.tabbarIndex.value = 1;
                      },
                    );
                  }else{
                    return CommonTextButton(
                      text: S.of(context).home_go_to_progress,
                      onPressed: () {
                        globalLogic.tabbarIndex.value = 2;
                      },
                    );
                  }

                }));
          } else {
            return Container();
          }
        })
      ],
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SliverTabBarDelegate(this.context, this.scaffoldKey);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CommonAppBar().getMainPageAppBar(context, scaffoldKey);
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent =>
      adaptToPoint(context, 80) + MediaQuery.of(context).padding.top;

  @override
  double get minExtent => adaptToPoint(context, 80);
}
