import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:xrpay/features/authentication/data/data_source/auth_data_source.dart';
import 'package:xrpay/features/authentication/data/data_source/auth_data_source_impl.dart';
import 'package:xrpay/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:xrpay/features/authentication/domain/usecases/signup.dart';
import 'package:xrpay/features/authentication/presentation/bloc/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseAuth,);

  // Authentication Firebase Auth
  sl.registerLazySingleton(() => AuthDataSourceImpl(sl<FirebaseAuth>()),);

  sl.registerLazySingleton(() => AuthRepositoryImpl(sl<AuthDataSourceImpl>()),);

  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepositoryImpl>()),);

  sl.registerLazySingleton(() => AuthenticationBloc(sl<SignUpUseCase>()),);
}