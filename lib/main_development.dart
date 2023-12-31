import 'package:firebase_core/firebase_core.dart';
import 'package:institute_app/app/app.dart';
import 'package:institute_app/bootstrap.dart';
import 'package:institute_app/entrypoints/development/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(() => const App());
}
