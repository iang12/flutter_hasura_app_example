import 'package:hasura_connect/hasura_connect.dart';
import 'package:flutter_hasura_app_example/app/modules/home/models/car_model.dart';

class CarRepository {
  final HasuraConnect _hasuraConnect;

  CarRepository(this._hasuraConnect);

  Future<List<CarModel>> getCars() async {
    List<CarModel> listCars = [];
    CarModel carModel;
    var query = '''
      query getCars {
        cars {
          id
          name
          description
        }
      }
    ''';

    var snapshot = await _hasuraConnect.query(query);
    for (var json in (snapshot['data']['cars']) as List) {
      carModel = CarModel.fromJson(json);
      listCars.add(carModel);
    }
    return listCars;
  }
  // novo método adicionado
  Future<String> addCard(String name, String description) async {
    var query = """

      mutation addCars(\$name:String!, \$description:String!) {
      insert_cars(objects: {name: \$name, description: \$description}) {
        affected_rows
        returning {
          name
        }
      }
    }

    """;
    var data = await _hasuraConnect.mutation(query, variables: {
      "name": name,
      "description": description,
    });
    return data["data"]['insert_cars']['returning'][0]['name'];
  }
}
