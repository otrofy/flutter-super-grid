library supergrid;

import 'package:flutter/material.dart';

class SectionGridView extends StatefulWidget {
  const SectionGridView(
      {super.key,
      required this.color,
      required this.crossAxisCount,
      required this.crossAxisSpacing,
      required this.mainAxisSpacing,
      required this.padding,
      required this.sections,
      required this.renderItem,
      required this.itemCount,
      required this.boxDecoration,
      required this.crossAxisAlignment,
      required this.onPressed,
      required this.onLikePressed,
      required this.icon,
      this.emptyIndicator = false});
  final Color color;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final List sections;
  final Widget Function(Object data) renderItem;
  final int itemCount;
  final BoxDecoration boxDecoration;
  final CrossAxisAlignment crossAxisAlignment;
  final IconData icon;
  final bool emptyIndicator;
  final void Function(int index)? onPressed;
  final void Function(int index, bool liked)? onLikePressed;
  @override
  State<SectionGridView> createState() => _SectionGridViewState();
}

class _SectionGridViewState extends State<SectionGridView> {
  List<bool> likedStates = [];
  @override
  void initState() {
    super.initState();
    likedStates = List<bool>.filled(widget.itemCount, false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: widget.padding,
        child: Container(
          color: widget.color,
          child: Stack(
            children: [
              Visibility(
                  visible: widget.sections.isEmpty && widget.emptyIndicator,
                  child: const Center(
                      child: Text(
                    'No items',
                  ))),
              Visibility(
                visible: widget.sections.isNotEmpty,
                child: ListView.builder(
                  itemCount: widget.sections.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = widget.sections[sectionIndex];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.crossAxisCount,
                            crossAxisSpacing: widget.crossAxisSpacing,
                            mainAxisSpacing: widget.mainAxisSpacing,
                          ),
                          itemCount: section.data.length,
                          itemBuilder: (context, index) {
                            final data = section.data[index];

                            return InkWell(
                              onTap: () {
                                if (widget.onPressed != null) {
                                  widget.onPressed!(index);
                                }
                              },
                              child: Container(
                                decoration: widget.boxDecoration,
                                child: Column(
                                  crossAxisAlignment: widget.crossAxisAlignment,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(8.0),
                                        ),
                                        child: widget.renderItem(data)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
