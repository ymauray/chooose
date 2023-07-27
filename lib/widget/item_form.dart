import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/model/item.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemForm extends ConsumerWidget {
  const ItemForm(
    this.listLabel, {
    this.item,
    super.key,
  });

  final String listLabel;
  final Item? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final linkController = TextEditingController();

    if (item != null) {
      nameController.text = item!.label;
      descriptionController.text = item!.description ?? '';
      linkController.text = item!.link ?? '';
    }

    return AlertDialog(
      title: Text(item != null ? context.t.editElement : context.t.addElement),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: nameController,
            decoration: InputDecoration(
              hintText: context.t.name,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: context.t.description,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          TextField(
            controller: linkController,
            decoration: InputDecoration(
              hintText: context.t.link,
            ),
            keyboardType: TextInputType.url,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        TextButton(
          onPressed: () {
            if (item != null) {
              ref.read(itemListsProvider.notifier).updateItem(
                    listLabel,
                    item!,
                    nameController.text,
                    descriptionController.text,
                    linkController.text,
                  );
            } else {
              ref.read(itemListsProvider.notifier).addItem(
                    listLabel,
                    nameController.text,
                    descriptionController.text,
                    linkController.text,
                  );
            }
            Navigator.of(context).pop();
          },
          child: Text(item != null ? context.t.save : context.t.add),
        ),
      ],
    );
  }
}
