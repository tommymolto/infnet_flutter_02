import 'dart:convert';

import 'package:api_acessivel/infra/chamada_api.dart';
import 'package:api_acessivel/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ListaUserPageController extends ChangeNotifier{

  final url = 'https://reqres.in/api/users?page=2';
  final http.Client httpClient;
  final ChamadaApi chamadaApi;
  late List<UserModel>  listUserModel = <UserModel>[];
  ListaUserPageController({
    required this.httpClient,
    required this.chamadaApi}
      );
  Future getUsers() async{
    late http.Response retorno;
    try{
      retorno  = await chamadaApi.getData(url) as  http.Response;
    }catch(_){
      throw Error().toString();
    }
    final jsonRetorno = jsonDecode(retorno.body);// as Dados;
    // print(jsonRetorno);
    final temp = Dados.fromJson(jsonRetorno);
    listUserModel = temp.data;
    print(listUserModel);
    notifyListeners();

  }
  addUser(UserModel user){
    print(user);
    listUserModel.add(user);
    notifyListeners();

  }
  deleteUsers(){
    listUserModel = <UserModel>[];
    notifyListeners();

  }
  deleteUser(UserModel userModel){
    listUserModel.remove(userModel);
    notifyListeners();

  }
  editUser(int indice,UserModel user){
    listUserModel[indice] = user;
    notifyListeners();


  }



}