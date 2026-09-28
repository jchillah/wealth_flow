import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_repository.dart';

/// Feature: transactions – presentation logic (bloc).
///
/// The bloc depends ONLY on the domain contract [TransactionRepository].
/// Whether the data comes from the mock, Hive, Firebase or Supabase is
/// decided in exactly ONE place: the composition root (root_shell.dart).
/// That is the Dependency Inversion Principle in action.

/// Everything the UI or the system can "request" from this feature.
/// `sealed` (Dart 3): the compiler knows ALL subtypes – switches over
/// events become exhaustive, forgotten cases are compile errors.
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
/// Equatable → value equality: tests can assert states by value, and
/// the bloc dedupes identical states (no useless rebuilds).
class TransactionState extends Equatable {
  const TransactionState({this.transactions = const []});

  /// Immutable by convention: the bloc always emits NEW lists.
  final List<TransactionEntry> transactions;

  TransactionState copyWith({List<TransactionEntry>? transactions}) =>
      TransactionState(transactions: transactions ?? this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  /// Dependency injection: the repository comes from outside.
  /// Tests can pass any implementation they like – that is the seam.
  TransactionBloc(this._repository) : super(const TransactionState()) {
    on<TransactionListStarted>(_onStarted);
    on<TransactionAdded>(_onAdded);
    on<TransactionRemoved>(_onRemoved);
  }

  final TransactionRepository _repository;

  // Handlers are async: real backends are async, the mock is not –
  // the bloc cannot tell the difference. That is the point.

  Future<void> _onStarted(
    TransactionListStarted event,
    Emitter<TransactionState> emit,
  ) async {
    final entries = await _repository.getTransactions();
    emit(state.copyWith(transactions: entries));
  }

  Future<void> _onAdded(
    TransactionAdded event,
    Emitter<TransactionState> emit,
  ) async {
    await _repository.addTransaction(event.entry);
    // NEVER mutate: we build a NEW list, so every listener can
    // detect the change. [old..., new] = spread operator.
    emit(
      state.copyWith(transactions: [...state.transactions, event.entry]),
    );
  }

  Future<void> _onRemoved(
    TransactionRemoved event,
    Emitter<TransactionState> emit,
  ) async {
    await _repository.removeTransaction(event.entry);
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
