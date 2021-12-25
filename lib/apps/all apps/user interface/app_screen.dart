import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/apps/all%20apps/bloc/app_bloc.dart';
import 'package:launch/apps/all%20apps/bloc/app_event.dart' as e;
import 'package:launch/apps/all%20apps/bloc/app_states.dart' as s;
import 'package:launch/apps/all%20apps/search/search_delegate.dart';
import 'package:launch/apps/favorite%20apps/user%20interface/favorite_screen.dart';
import 'package:launch/widget_screen/weather/user%20interface/error_widget.dart';
import 'app_item_list.dart';


class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold( 
      appBar: AppBar(centerTitle: true, 
      backgroundColor: 
      Colors.blue[300],
      title: const MyTextForAppBar('Приложения'),
      actions: [
        Container(
          child: IconButton(icon: Icon(Icons.manage_search_sharp, size: 40, 
              color: Colors.grey[850] ),
              onPressed: () => showSearch(context: context, delegate: MySearchDelegate())),
              padding: const EdgeInsets.fromLTRB(0,0,20,20),
        )
      ],),
      body: const AppWidget());
}


class AppWidget extends StatelessWidget {
const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return BlocBuilder<AppBloc, s.AppState>(
        builder: (context, state) {
          if (state is s.DontHasDataOfApps) {
            context.read<AppBloc>().add(e.StartLoadingApps());
          }
          if (state is s.FavoriteAppFormating) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else if (state is s.AppsOperationIsSuccess) {
            var data = state.data;
            return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AppListItem(app: data[index], needStar: true);
            });
            }     
          else if (state is s.AppsOperationFailled) {
           return MyErrorWidget(text: 'Не удалось загрузить список приложений',
            onPressed: () => context.read<AppBloc>().
            add(e.StartLoadingApps()));
          }   
            return const Center(child: CircularProgressIndicator());                    
        });
         
    
  }

}
