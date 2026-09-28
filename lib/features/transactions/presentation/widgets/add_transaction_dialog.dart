// features/transactions/presentation/widgets/add_transaction_dialog.dart
import 'package:flutter/material.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isIncome = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = _amountController.text.trim().isEmpty
        ? null
        : double.tryParse(_amountController.text.trim().replaceAll(',', '.'));

    if (amount == null || amount <= 0) {
      return;
    }

    final entry = TransactionEntry(
      title: _titleController.text.trim(),
      amount: amount,
      isIncome: _isIncome,
      date: _selectedDate,
    );

    Navigator.of(context).pop(entry);
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Buchung anlegen'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Titel',
                  hintText: 'z. B. Gehalt',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bitte einen Titel eingeben.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Betrag',
                  suffixText: '€',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bitte einen Betrag eingeben.';
                  }

                  final amount = double.tryParse(
                    value.trim().replaceAll(',', '.'),
                  );

                  if (amount == null) {
                    return 'Bitte eine gültige Zahl eingeben.';
                  }

                  if (amount <= 0) {
                    return 'Der Betrag muss größer als 0 sein.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text('Ausgabe'),
                    icon: Icon(Icons.arrow_upward),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Einnahme'),
                    icon: Icon(Icons.arrow_downward),
                  ),
                ],
                selected: {_isIncome},
                onSelectionChanged: (selection) {
                  setState(() {
                    _isIncome = selection.first;
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: const Text('Datum'),
                subtitle: Text(
                  '${_selectedDate.day}.'
                  '${_selectedDate.month}.'
                  '${_selectedDate.year}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _selectDate,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Speichern')),
      ],
    );
  }
}
