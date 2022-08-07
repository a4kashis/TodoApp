import 'package:flutter/material.dart';

import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/base/shimmer.dart';

class TodoShimmer extends StatelessWidget {
  const TodoShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerContainer(
              borderRadius: 50.0,
              height: 50,
              width: 50,
            ),
            SizedBox(width: Dimens.gapX2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(),
                  SizedBox(height: 4.0),
                  ShimmerContainer(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ],
              ),
            ),
            // SizedBox(width: Dimens.gapX2),
          ],
        ),
      ),
      separatorBuilder: (ctx, i) => Divider(height: 0.0),
    );
  }
}
