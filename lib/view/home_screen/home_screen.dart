import 'package:flutter/material.dart';
import 'package:flutter_ab_test/controller/get_home_cubit/get_home_cubit.dart';
import 'package:flutter_ab_test/controller/get_home_cubit/get_home_state.dart';
import 'package:flutter_ab_test/utils/resources/constants.dart';
import 'package:flutter_ab_test/view/add_screen/add_screen.dart';
import 'package:flutter_ab_test/view/home_screen/widgets/list_view_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetHomeCubit>(
      create: (context) => GetHomeCubit()..getHomeData(context),
      child: BlocBuilder<GetHomeCubit, GetHomeState>(builder: (context, state) {
        var cubit = GetHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
          ),
          body: state is GetHomeDataLoadingState || cubit.itemList == null
              ? const Center(child: CircularProgressIndicator.adaptive()) : cubit.itemList!.isEmpty ? const Center(
            child: Text('Empty List'),
          )
              : Padding(
                padding: const EdgeInsets.all(AppConstants.pagePadding),
                child: ListViewWidget(itemList: cubit.itemList!, cubit: cubit,),
              ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddScreen.routeName,
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
