import 'package:flutter/material.dart';
import 'package:flutter_ab_test/common_widgets/input_field.dart';
import 'package:flutter_ab_test/controller/add_item_cubit/add_item_cubit.dart';
import 'package:flutter_ab_test/controller/add_item_cubit/add_item_state.dart';
import 'package:flutter_ab_test/utils/resources/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatelessWidget {
  static const routeName = '/AddScreen';

  AddScreen({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddItemCubit>(
      create: (context) => AddItemCubit(),
      child: BlocBuilder<AddItemCubit, AddItemState>(builder: (context, state) {
        var cubit = AddItemCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Screen'),
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
                    if (value!.isEmpty) {
                      return 'This Field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 17,
                ),
                MyInputFiled(
                  hint: 'Title',
                  label: 'Title',
                  controller: titleController,
                  inputIcon: Icons.bookmark,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 17,
                ),
                MyInputFiled(
                  hint: 'description',
                  label: 'description',
                  controller: descriptionController,
                  inputIcon: Icons.description,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: state is AddItemLoadingState ? const LinearProgressIndicator() : InkWell(
            onTap: () {
              cubit.addItem(
                context,
                imageLink: imageLinkController.text,
                title: titleController.text,
                description: descriptionController.text,
              );
            },
            child: const BottomAppBar(
              child: Center(child: Text('Add')),
            ),
          ),
        );
      }),
    );
  }
}
