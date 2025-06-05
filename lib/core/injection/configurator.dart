import 'package:chat_firebase/core/injection/get_it_instance.dart';
import 'package:injectable/injectable.dart';

import 'configurator.config.dart';

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}
