import 'package:api_acessivel/infra/chamada_api.dart';
import 'package:api_acessivel/model/user_model.dart';
import 'package:api_acessivel/pages/lista_user_page_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaUserPage extends StatefulWidget {
  const ListaUserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListaUserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late http.Client httpClient; //  = http.Client as http.Client;

  late ChamadaApi chamadaApi; // = ChamadaApi(httpClient: httpClient);
  late ListaUserPageController
      listaUserPageController; //= ListaUserPageController(httpClient: httpClient);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpClient = http.Client();
    chamadaApi = ChamadaApi(httpClient: httpClient);
    listaUserPageController =
        ListaUserPageController(httpClient: httpClient, chamadaApi: chamadaApi);
    listaUserPageController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Acessivel'),
        actions: [
          IconButton(
              onPressed: () {
                final faker = Faker();

                final user = UserModel(
                    id: hashCode,
                    email: faker.internet.email(),
                    firstName: faker.person.firstName(),
                    lastName: faker.person.lastName(),
                    avatar: 'https://source.unsplash.com/${faker.hashCode}');
                listaUserPageController.addUser(user);
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                listaUserPageController.deleteUsers();
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: Container(
        color: Colors.black12,
        padding: const EdgeInsets.all(2.0),
        child: AnimatedBuilder(
          animation: listaUserPageController,
          builder: (context, child) {
            return ListView.builder(
                itemCount: listaUserPageController.listUserModel.length,
                itemBuilder: (context, index) {
                  final listRanking = listaUserPageController.listUserModel;
                  return Slidable(
                      key: Key(listRanking[index].id.toString()),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            listRanking[index].avatar,
                            //fit: BoxFit.fitWidth,
                          )
                        )
                         ,
                        contentPadding: const EdgeInsets.only(left: 20),
                        tileColor: Colors.black12,
                        title: Text(
                          '${listRanking[index].firstName} ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        subtitle: Text(listRanking[index].lastName,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14)),
                      ),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            label: 'Atualizar',
                            backgroundColor: Colors.pink,
                            icon: Icons.update,
                            onPressed: (BuildContext context) async{
                              final updateRanking = listRanking[index];
                              updateRanking.firstName = Faker().person.firstName();

                              await listaUserPageController.editUser(index, updateRanking);

                              showSnackBar(scaffoldKey.currentState, 'Atualizado');

                            },
                          ),
                          SlidableAction(
                            label: 'Remover',
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            onPressed: (BuildContext context) async{
                              final deleteRanking = listRanking[index];
                              await listaUserPageController.deleteUser(deleteRanking);
                              showSnackBar(scaffoldKey.currentState, 'Removido');
                            },
                          )
                        ],
                      ),);

                });
          },
        ),
      ),
    );
  }
  void showSnackBar(ScaffoldState? currentState, String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 1),
    );
    currentState?.showSnackBar(snackBar);
  }
}
