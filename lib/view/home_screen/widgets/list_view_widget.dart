import 'package:flutter/material.dart';
import 'package:flutter_ab_test/controller/get_home_cubit/get_home_cubit.dart';
import 'package:flutter_ab_test/view/home_screen/widgets/item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../models/item_model.dart';

class ListViewWidget extends StatelessWidget {
  final GetHomeCubit cubit;
  final List<ItemModel> itemList;
  const ListViewWidget({super.key, required this.itemList, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: MediaQuery.of(context).size.width < 480 ? 2 : 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemBuilder: (context, index) {
        return ItemWidget(data: itemList[index],cubit: cubit,);
      },
      itemCount: itemList.length,
    );
  }
}
