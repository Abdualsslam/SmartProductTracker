import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/database/cache/cache_helper.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import 'package:smart_product_tracker/featuers/alerts/data/datasources/alert_remote_data_source_impl.dart';
import 'package:smart_product_tracker/featuers/alerts/data/models/price_alert_model.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class AlertRepositoryImpl implements AlertRepository {
  final AlertRemoteDataSource remoteDataSource;
  final CacheHelper cacheHelper;

  AlertRepositoryImpl({required this.remoteDataSource, required this.cacheHelper});

  @override
  Future<void> addAlert(PriceAlert alert) {
    final userId = cacheHelper.getData(key: "uId");
    final model = PriceAlertModel(productId: alert.productId, targetPrice: alert.targetPrice);
    return remoteDataSource.addAlert(userId, model);
  }

  @override
  Future<void> deleteAlert(String productId) {
    final userId = cacheHelper.getData(key: "uId");
    return remoteDataSource.deleteAlert(userId, productId);
  }

  @override
  Future<Either<Failure, List<PriceAlert>>> getAllAlerts() async {
    try {
      final userId = cacheHelper.getData(key: "uId");
      final alerts = await remoteDataSource.getAllAlerts(userId);
      return Right(alerts);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
