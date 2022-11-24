// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data_source/animal_data_source.dart' as _i3;
import 'repository/animal_repository.dart' as _i4;
import 'repository/animal_repository_implementation.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AnimalDataSource>(() => _i3.AnimalDataSource());
  gh.lazySingleton<_i4.AnimalRepository>(() =>
      _i5.AnimalRepositoryImplementation(
          animalDataSource: get<_i3.AnimalDataSource>()));
  return get;
}
