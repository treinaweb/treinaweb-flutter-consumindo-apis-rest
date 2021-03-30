import 'package:http/http.dart';

import '../utils/rest_util.dart';
import '../models/conta.dart';

class ContaRestService {
  Future<Conta> addConta(Conta conta) async {
    final Response response = await RestUtil.addData('contas', conta.toJson());

  }
}