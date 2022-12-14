import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

    DateTime? _selectedDate  ;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 || _selectedDate==null){
      return;
    }

    //widget property lets us use methods of widget class inside state class
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
    // Navigator is used to close the topmost screen that is displaced; ie the model sheet here.
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2011),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Title'
              ),
              controller: _titleController,
              onSubmitted: (_)=>_submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Amount'
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted:(_)=> _submitData(),
            ),

            Container(
              height: 90,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                        _selectedDate == null ? 'No date chosen    '
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',)),
                  ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w300
                        ),)
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
