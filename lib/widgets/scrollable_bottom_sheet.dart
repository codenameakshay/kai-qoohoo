import 'package:flutter/material.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/services/path_service.dart';
import 'package:provider/provider.dart';

class ScrollableBottomSheet extends StatelessWidget {
  const ScrollableBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.disabled = false,
  }) : super(key: key);
  final String title;
  final Widget Function(ScrollController) child;
  final bool disabled;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final PathController _pathController = Provider.of<PathController>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.0001),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 1,
          builder: (context, scrollController) => Container(
              padding: EdgeInsets.fromLTRB(
                  24, 24, 24, MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            width: 48,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.2),
                            ),
                          ),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                        ),
                        _pathController.docState == DocState.loading
                            ? LinearProgressIndicator(
                                color: Theme.of(context).colorScheme.secondary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              )
                            : Container(),
                        // const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: padding,
                            child: child(scrollController),
                          ),
                        ),
                        // const Spacer(),
                      ]),
                ],
              )),
        ),
      ),
    );
  }
}
