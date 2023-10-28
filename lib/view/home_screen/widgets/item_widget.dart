import 'package:flutter/material.dart';
import 'package:flutter_ab_test/controller/get_home_cubit/get_home_cubit.dart';
import 'package:flutter_ab_test/models/item_model.dart';
import 'package:flutter_ab_test/utils/app/my_app.dart';
import 'package:flutter_ab_test/utils/resources/app_fonts.dart';
import 'package:flutter_ab_test/view/edit_screen/edit_screen.dart';
import 'package:quickalert/quickalert.dart';

import '../../../common_widgets/cached_image.dart';

class ItemWidget extends StatelessWidget {
  final GetHomeCubit cubit;
  final ItemModel data;
  const ItemWidget({super.key, required this.data, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: CachedImageWidget(
                image: data.imgLink??'',
                height: 85,
              )),
           Text(
            data.title??'',
            style: AppFonts.headlineStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            data.description??'',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton.filledTonal(
                  onPressed: () {
                    QuickAlert.show(
                      context: navigatorKey.currentState!.context,
                      type: QuickAlertType.warning,
                      title: 'Delete ${data.title}',
                      text: 'Are you sure,',
                      onConfirmBtnTap: (){
                        cubit.deleteItem(context, data.id.toString()).then((value) {
                          Navigator.pop(navigatorKey.currentState!.context);
                        });
                      }
                    );
                  }, icon: const Icon(Icons.delete)),
              IconButton.filled(
                  onPressed: () {
                    Navigator.pushNamed(context, EditScreen.routeName, arguments: data);
                  },
                  icon: const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    );
  }
}
