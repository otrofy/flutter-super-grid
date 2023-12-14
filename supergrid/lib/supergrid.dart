library supergrid;

import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {
  CustomGridView(
      {super.key,
      required this.color,
      required this.crossAxisCount,
      required this.crossAxisSpacing,
      required this.mainAxisSpacing,
      required this.padding,
      required this.list,
      required this.itemCount,
      required this.boxDecoration,
      required this.crossAxisAlignment,
      required this.onPressed,
      required this.onLikePressed,
      required this.icon,
      this.emptyIndicator = false});
  Color color;
  int crossAxisCount;
  late double crossAxisSpacing;
  late double mainAxisSpacing;
  EdgeInsets padding;
  List list;
  int itemCount;
  BoxDecoration boxDecoration;
  CrossAxisAlignment crossAxisAlignment;
  IconData icon;
  bool emptyIndicator;
  final void Function(int index)? onPressed;
  final void Function(int index, bool liked)? onLikePressed;
  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
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
                  visible: widget.list.isEmpty && widget.emptyIndicator,
                  child: const Center(
                      child: Text(
                    'No items',
                  ))),
              Visibility(
                visible: widget.list.isNotEmpty,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    crossAxisSpacing: widget.crossAxisSpacing,
                    mainAxisSpacing: widget.mainAxisSpacing,
                  ),
                  itemCount: widget.itemCount,
                  itemBuilder: (context, index) {
                    String photo = widget.list[index];
                    int id = widget.list[index].id;
                    bool isLiked = false;

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
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8.0),
                              ),
                              child: Image.network(
                                photo,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                fit: BoxFit.contain,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Text("error");
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isLiked
                                            ? Colors.black // Corazón lleno
                                            : null, // Corazón vacío (predeterminado)
                                      ),
                                      onPressed: () {
                                        if (widget.onLikePressed != null) {
                                          widget.onLikePressed!(id, isLiked);
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
