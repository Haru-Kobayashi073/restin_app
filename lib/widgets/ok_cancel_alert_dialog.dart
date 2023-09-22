import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class OkCancelAlertDialog extends HookConsumerWidget {
  const OkCancelAlertDialog({
    super.key,
    required this.title,
    this.message,
    required this.cancelLabel,
    required this.okLabel,
    required this.onTapCancel,
    required this.onTapOk,
  });

  final String title;
  final String? message;
  final String cancelLabel;
  final String okLabel;
  final void Function(BuildContext) onTapCancel;
  final void Function(BuildContext) onTapOk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: message != null
          ? Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorName.deepGrey,
                fontSize: 16,
              ),
            )
          : null,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: EdgeInsets.zero,
      actions: <Widget>[
        const Divider(
          height: 1,
          thickness: 1,
          color: ColorName.lightGrey,
        ),
        Row(
          children: [
            _buildAction(
              label: cancelLabel,
              onTap: onTapCancel,
              // context: context,
            ),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
                color: ColorName.lightGrey,
              ),
            ),
            _buildAction(
              label: okLabel,
              onTap: onTapOk,
              // context: context,
            )
          ],
        )
      ],
    );
  }

  Widget _buildAction({
    required String label,
    required void Function(BuildContext) onTap,
  }) {
    final context = useContext();
    return Expanded(
      child: InkWell(
        onTap: () => onTap(context),
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: ColorName.amber,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
