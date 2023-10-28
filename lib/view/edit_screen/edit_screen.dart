import 'package:flutter/material.dart';
import 'package:flutter_ab_test/controller/edit_item_cubit/edit_item_cubit.dart';
import 'package:flutter_ab_test/controller/edit_item_cubit/edit_item_state.dart';
import 'package:flutter_ab_test/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/input_field.dart';
import '../../utils/resources/constants.dart';

class EditScreen extends StatelessWidget {
  static const routeName = '/EditScreen';
   EditScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as ItemModel;
    imageLinkController.text = data.imgLink!;
    titleController.text = data.title!;
    descriptionController.text = data.description!;
    return BlocProvider<EditItemCubit>(
      create: (context) => EditItemCubit(),
      child: BlocBuilder<EditItemCubit, EditItemState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Screen'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppConstants.pagePadding),
              child: Column(
                children: [
                  MyInputFiled(
                    hint: 'Image link',
                    label: 'Image link',
                    controller: imageLinkController,
                    inputIcon: Icons.image,
                    validate: (value) {
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 17,),
                  MyInputFiled(
                    hint: 'Title',
                    label: 'Title',
                    controller: titleController,
                    inputIcon: Icons.bookmark,
                    validate: (value) {
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 17,),
                  MyInputFiled(
                    hint: 'description',
                    label: 'description',
                    controller: descriptionController,
                    inputIcon: Icons.description,
                    validate: (value) {
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                      return null;
                    },),
                ],
              ),
            ),
            bottomNavigationBar: state is EditItemLoadingState ? const LinearProgressIndicator() : InkWell(
              onTap: () {
                EditItemCubit.get(context).editItem(
                  context,
                  id: data.id.toString(),
                  imageLink: imageLinkController.text,
                  title: titleController.text,
                  description: descriptionController.text,
                );
              },
              child: BottomAppBar(
                child: Center(child: Text('Edit')),
              ),
            ),
          );
        }
      ),
    );
  }
}
