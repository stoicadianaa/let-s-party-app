import 'package:flutter/material.dart';
import 'package:lets_party/app/components/category_widget.dart';
import 'package:lets_party/app/items_page/items_page_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {
  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late ItemsPageBloc bloc;

  @override
  void initState() {
    bloc = ItemsPageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "what is needed".i18n(),
              style: AppStyles.appBarStyle,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: TextButton(
              child: Text("Back".i18n()),
              onPressed: () {},
            ),
          ),
          body: Consumer<ItemsPageBloc>(
            builder: (context, itemsBloc, child) {
              if (!bloc.loadingDone) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(AppDimens.padding_2x),
                child: ListView.builder(
                  itemCount: bloc.listOfCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryWidget(category: bloc.listOfCategories[index], enableItemSelect: false,);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
