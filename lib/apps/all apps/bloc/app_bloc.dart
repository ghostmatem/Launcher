import 'package:launch/apps/all%20apps/data/app_repository.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_d_provider.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_repository.dart';

import 'app_event.dart' as e;
import 'app_states.dart' as s;
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<e.AppEvent, s.AppState> {
  AppBloc() : super(s.DontHasDataOfApps()) {

    on<e.StartLoadingApps>((event, emit) async { 
      emit(s.AppOnLoaded());
      try {
        print('Получаем апп');
        var data = await AppsRepository.getInstalledApps();
        emit(s.FavoriteAppFormating());
        var favoriteApps = await FavoriteDataProvider.getAllData();
        FavoriteAppsRepository.updateFavoriteList(favoriteApps);
        emit(s.AppsOperationIsSuccess(data));
      } catch(_) {
        emit(s.AppsOperationFailled());
      }
    });
  }
}