import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../component/touchableopacity.dart';
import '../../designsystem/theme/base_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageStatBox extends StatelessWidget {
  const MainPageStatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              offset: Offset(0, 5), // changes position of shadow
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
                      '5월 2주차 합산',
                      style: TextStyle(
                        color: BaseColor.warmGray900,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    //SizedBox(height: 6),
                    Text(
                      '12,000 원',
                      style: TextStyle(
                        color: BaseColor.defaultGreen,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
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
                          '5/8 ~ 5/14 사이의 내역이에요!',
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
            SizedBox(height: 8),
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
                      Expanded(
                          child: const VerticalDivider(
                            color: BaseColor.warmGray200,
                          )),
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
        ));
  }
}
