import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../presenter/feature/main_screen/main_screen_stat_box_state.dart';
import '../../../../presenter/feature/main_screen/main_screen_stat_box_store.dart';
import '../../../designsystem/theme/base_color.dart';

class MainPageStatBox extends BaseView<MainPageStatBox, MainPageStatBoxAction, MainPageStatBoxState> {
  @override
  MainPageStatBoxAction initAction() => MainPageStatBoxAction();

  @override
  Widget render(BuildContext context, MainPageStatBoxAction action, MainPageStatBoxState state) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.only(
              top: 20.sp, bottom: 20.sp, left: 23.sp, right: 23.sp),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.sp),
            color: BaseColor.warmGray100,
            boxShadow: [
              BoxShadow(
                color: BaseColor.warmGray400.withOpacity(0.25),
                spreadRadius: 0.1,
                blurRadius: 30,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: BaseColor.warmGray600,
                    size: 14.sp,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.title,
                        style: TextStyle(
                          color: BaseColor.warmGray900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      //SizedBox(height: 6),
                      Text(
                        state.money,
                        style: TextStyle(
                          color: BaseColor.defaultGreen,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                        ) ,
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4.sp,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            color: BaseColor.warmGray400,
                            size: 10.sp,
                          ),
                          Text(
                            state.subTitle,
                            style: TextStyle(
                              color: BaseColor.warmGray400,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: BaseColor.warmGray600,
                    size: 14.sp,
                  )
                ],
              ),
              const SizedBox(height: 18),
              const Divider(
                color: BaseColor.warmGray200,
              ),
              const SizedBox(height: 8),
              Padding(
                  padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8.sp,
                            children: [
                              Icon(
                                Icons.list_alt_outlined,
                                color: BaseColor.warmGray400,
                                size: 13.sp,
                              ),
                              Text(
                                '내역 보기',
                                style: TextStyle(
                                  color: BaseColor.warmGray400,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Expanded(
                            child: VerticalDivider(
                              color: BaseColor.warmGray200,
                            )
                        ),
                        Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.sp,
                              children: [
                                Icon(
                                  Icons.insert_chart,
                                  color: BaseColor.warmGray400,
                                  size: 13.sp,
                                ),
                                Text(
                                  '통계 보기',
                                  style: TextStyle(
                                    color: BaseColor.warmGray400,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ))
            ],
          )),
    )
    ;
  }
}
