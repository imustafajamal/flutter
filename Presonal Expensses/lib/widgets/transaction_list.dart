import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      Text('No Transactions add yet!'),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.7,
                          child: Image.asset('assets/images/waiting.png',
                              fit: BoxFit.cover))
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount}',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            )),
                      ),
                      title: Text(transactions[index].title,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(
                          DateFormat.yMMMMd().format(transactions[index].date)),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              label: Text('Delete'))
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
