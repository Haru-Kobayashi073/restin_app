import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class AuthContentsStatus extends StatelessWidget {
  const AuthContentsStatus({
    super.key,
    required this.index,
    required this.isDone,
    required this.currentContent,
  });
  final int index;
  final bool isDone;
  final bool currentContent;

  @override
  Widget build(BuildContext context) {
    return index == 2
        ? Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: ColorName.darkGrey,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: currentContent ? ColorName.black : ColorName.white,
                  shape: BoxShape.circle,
                  border: currentContent
                      ? null
                      : Border.all(
                          color: ColorName.darkGrey,
                        ),
                ),
                child: isDone
                    ? const Icon(Icons.check, color: ColorName.darkGrey)
                    : Text(
                        index.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: currentContent
                              ? ColorName.white
                              : ColorName.darkGrey,
                        ),
                      ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: ColorName.darkGrey,
                ),
              ),
            ],
          ),
        )
        : Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: currentContent ? Colors.black : ColorName.white,
              shape: BoxShape.circle,
              border:
                  currentContent ? null : Border.all(color: ColorName.darkGrey),
            ),
            child: isDone
                ? const Icon(Icons.check, color: ColorName.darkGrey)
                : Text(
                    index.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color:
                          currentContent ? ColorName.white : ColorName.darkGrey,
                    ),
                  ),
          );
  }
}
