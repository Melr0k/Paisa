import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/di/di.dart';
import 'src/domain/expense/repository/expense_repository.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  //await addDummyData();
  getIt.get<ExpenseRepository>().checkForRecurring();
  runApp(const PaisaApp());
}
