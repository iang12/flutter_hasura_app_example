import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Modular.get();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller.getCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (controller.listCars.isEmpty) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            color: Colors.white,
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Hasura Connect Example'),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: controller.listCars.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(controller.listCars[index].id.toString()),
                ),
                title: Text(controller.listCars[index].name),
                subtitle: Text(controller.listCars[index].description),
              );
            },
          ),
          //novo widget adicionado
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context1) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      title: Text("Adicionar Novo"),
                      content: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                validator: (value) =>
                                    value!.isEmpty ? 'Preencha o campo' : null,
                                decoration: InputDecoration(
                                    labelText: "Nome do veículo"),
                                onChanged: controller.setName,
                              ),
                              TextFormField(
                                validator: (value) =>
                                    value!.isEmpty ? 'Preencha o campo' : null,
                                decoration:
                                    InputDecoration(labelText: "Descrição"),
                                onChanged: controller.setDescription,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(3.0),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ))),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      controller.addCar();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    "Salvar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
//https://blog.geekyants.com/flutter-graphql-with-hasura-d4d0b34621da
// https://medium.com/habilelabs/hasura-an-open-source-graphql-engine-82c0445ec682
// https://hasura.io/blog/getting-started-with-hasura-and-flutter/
// https://techcrunch.com/2020/06/22/hasura-launches-managed-cloud-service-for-its-open-source-graphql-api/
// https://blog.geekyants.com/flutter-graphql-with-hasura-d4d0b34621da
// https://dev.to/codingblocks/3factor-app-realtime-graphql
// https://medium.com/trainingcenter/graphql-para-iniciantes-a4cbe6c3da5d
