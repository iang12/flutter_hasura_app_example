import 'package:mobx/mobx.dart';

import 'package:flutter_hasura_app_example/app/modules/home/models/car_model.dart';
import 'package:flutter_hasura_app_example/app/modules/home/repositories/car_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late CarRepository repository;
  _HomeControllerBase(this.repository);
  @observable
  String name = '';
  @action
  setName(value) => name = value;
  @observable
  String description = '';
  @action
  setDescription(value) => description = value;
  @observable
  List<CarModel> listCars = <CarModel>[].asObservable();

  @action
  getCars() async {
    listCars = await repository.getCars();
  }

  //novo método adicionado
  @action
  addCar() async {
    await repository.addCard(name, description);
    await getCars();
  }
}
