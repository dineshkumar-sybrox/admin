import 'package:flutter_bloc/flutter_bloc.dart';

enum DriverTab { total, active, newDrivers, suspended }

class DriversManagementCubit extends Cubit<DriverTab> {
  DriversManagementCubit() : super(DriverTab.total);

  void selectTab(DriverTab tab) {
    emit(tab);
  }
}
