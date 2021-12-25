import 'package:equatable/equatable.dart';

import 'package:launch/apps/all%20apps/data/app_title.dart';

class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DontHasDataOfApps extends AppState { }
class AppOnLoaded extends AppState { }
class FavoriteAppFormating extends AppState { }
class AppsOperationIsSuccess extends AppState { 

  final List<AppTitle> data;
  AppsOperationIsSuccess(this.data);
}

class AppsOperationFailled extends AppState { }