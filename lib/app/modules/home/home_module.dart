import 'package:flutter_hasura_app_example/app/modules/home/pages/home_controller.dart';
import 'package:flutter_hasura_app_example/app/modules/home/repositories/car_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeController(i())),
    Bind((i) => CarRepository(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
