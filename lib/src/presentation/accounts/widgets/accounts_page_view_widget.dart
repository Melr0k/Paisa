import 'package:flutter/material.dart';
import 'package:flutter_paisa/src/presentation/widgets/paisa_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/enum/card_type.dart';
import '../../../data/accounts/model/account.dart';
import '../bloc/accounts_bloc.dart';
import 'account_card.dart';

class AccountPageViewWidget extends StatelessWidget {
  AccountPageViewWidget({
    Key? key,
    required this.accounts,
    required this.accountBloc,
  }) : super(key: key);

  final PageController _controller = PageController();
  final List<Account> accounts;
  final AccountsBloc accountBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: PageView.builder(
            key: const Key('accounts_page_view'),
            controller: _controller,
            itemCount: accounts.length,
            onPageChanged: (index) =>
                accountBloc.add(AccountSelectedEvent(accounts[index])),
            itemBuilder: (_, index) {
              final account = accounts[index];
              return AccountCard(
                key: ValueKey(account.hashCode),
                cardHolder: account.name,
                cardNumber: account.number,
                bankName: account.bankName,
                cardType: account.cardType ?? CardType.bank,
                onDelete: () => paisaAlertDialog(
                  context,
                  title: const Text('Permanently confirmation'),
                  child: Text(
                      'Deleting the account deletes all expenses which tied to this account ${account.name}'),
                  confirmationButton: ElevatedButton(
                    onPressed: () {
                      accountBloc.add(DeleteAccountEvent(account));
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                ),
                onTap: () => GoRouter.of(context).goNamed(
                  editAccountPath,
                  params: <String, String>{'aid': account.superId.toString()},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
