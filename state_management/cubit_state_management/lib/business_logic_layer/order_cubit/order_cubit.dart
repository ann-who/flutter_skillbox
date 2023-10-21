import 'dart:async';

import 'package:cubit_state_management/data_layer/models/created_order/created_order_model.dart';
import 'package:cubit_state_management/data_layer/models/product_model/product_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

class OrderCubit {
  var currentState = const OrderState(
    daysInMonth: {
      1: 31,
      2: 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31,
    },
  );

  final _stateController = StreamController<OrderState>.broadcast();

  Stream<OrderState> get state => _stateController.stream;

  void placeNewOrder(List<ProductModel> products) {
    var currentOrders = List<CreatedOrderModel>.from(currentState.orders);
    String creationDate =
        '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
    String deliveryDate() {
      var calculatedDate = '';
      var currentMonth = currentState.daysInMonth.entries
          .where((element) => element.key == DateTime.now().month)
          .first;

      if (DateTime.now().day + 10 <= currentMonth.value) {
        calculatedDate =
            '${DateTime.now().day + 10}.${DateTime.now().month}.${DateTime.now().year}';
      } else if (DateTime.now().day + 10 > currentMonth.value &&
          currentMonth.key != 12) {
        calculatedDate =
            '${DateTime.now().day - currentMonth.value + 10}.${DateTime.now().month + 1}.${DateTime.now().year}';
      } else {
        calculatedDate =
            '${DateTime.now().day - currentMonth.value + 10}.01.${DateTime.now().year + 1}';
      }

      return calculatedDate;
    }

    var updatedOrders = currentOrders;

    updatedOrders.add(
      CreatedOrderModel(
        products: products,
        creationDate: creationDate,
        deliveryDate: deliveryDate(),
      ),
    );

    currentState = currentState.copyWith(orders: updatedOrders);

    _stateController.add(currentState);
  }

  void dispose() {
    _stateController.close();
  }
}
