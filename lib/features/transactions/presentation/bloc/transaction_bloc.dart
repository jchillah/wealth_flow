import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wealth_flow/features/transactions/data/demo_transaction_data.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';

/// Feature: transactions – presentation logic (bloc).
///
/// BLoC = Business Logic Component. The contract:
///   UI sends events  →  bloc computes a NEW state  →  UI rebuilds.
/// One direction only. The UI can never mutate data directly –
/// which is exactly why this logic is testable WITHOUT any widgets.

/// Everything the UI or the system can "request" from this feature.
///
/// `sealed` (Dart 3): the compiler knows ALL subtypes. A `switch`
/// over events becomes exhaustive – forgotten cases are compile
/// errors instead of runtime surprises.
sealed class TransactionEvent {
  const TransactionEvent();
}

/// Fired once at startup: load the initial list.
final class TransactionListStarted extends TransactionEvent {
  const TransactionListStarted();
}

final class TransactionAdded extends TransactionEvent {
  const TransactionAdded(this.entry);

  final TransactionEntry entry;
}

final class TransactionRemoved extends TransactionEvent {
  const TransactionRemoved(this.entry);

  final TransactionEntry entry;
}

/// The single source of truth for the transaction list.
///
/// Extends Equatable → value equality: two states with the same list
/// are "equal". Two effects:
/// 1. bloc_test can assert emitted states by VALUE.
/// 2. The bloc skips emitting identical states → no useless rebuilds.
class TransactionState extends Equatable {
  const TransactionState({this.transactions = const []});

  /// Immutable by convention: the bloc always emits NEW lists.
  /// `state.transactions.add(...)` is forbidden by design.
  final List<TransactionEntry> transactions;

  TransactionState copyWith({List<TransactionEntry>? transactions}) =>
      TransactionState(transactions: transactions ?? this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<TransactionListStarted>(_onStarted);
    on<TransactionAdded>(_onAdded);
    on<TransactionRemoved>(_onRemoved);
  }

  void _onStarted(
    TransactionListStarted event,
    Emitter<TransactionState> emit,
  ) {
    // M3 will call the repository (async) here instead.
    emit(state.copyWith(transactions: DemoTransactionData.transactions));
  }

  void _onAdded(TransactionAdded event, Emitter<TransactionState> emit) {
    // NEVER mutate: we build a NEW list, so every listener can
    // detect the change. [old..., new] = spread operator.
    emit(
      state.copyWith(transactions: [...state.transactions, event.entry]),
    );
  }

  void _onRemoved(TransactionRemoved event, Emitter<TransactionState> emit) {
    // Identity-based removal: the UI passes the exact instance from
    // the list (the entity has no `==` override). M3 introduces IDs.
    emit(
      state.copyWith(
        transactions:
            state.transactions.where((e) => e != event.entry).toList(),
      ),
    );
  }
}
