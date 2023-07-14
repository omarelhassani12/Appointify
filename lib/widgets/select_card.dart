import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  final String label;
  final String imagePath;
  final Color selectedColor;
  final Color unselectedColor;
  final Color textColor;
  final bool isSelected;
  final VoidCallback onTap;
  final double imageWidth;
  final double imageHeight;

  const SelectableCard({
    required this.label,
    required this.imagePath,
    required this.selectedColor,
    required this.unselectedColor,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
    required this.imageWidth,
    required this.imageHeight,
    Key? key,
  }) : super(key: key);

  @override
  SelectableCardState createState() => SelectableCardState();
}

class SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color:
            widget.isSelected ? widget.selectedColor : widget.unselectedColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath,
                width: widget.imageWidth,
                height: widget.imageHeight,
                color: widget.isSelected ? null : widget.textColor,
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// class SelectableCard extends StatefulWidget {
//   final String label;
//   final String imagePath;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final Color textColor;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const SelectableCard({
//     required this.label,
//     required this.imagePath,
//     required this.selectedColor,
//     required this.unselectedColor,
//     required this.textColor,
//     required this.isSelected,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _SelectableCardState createState() => _SelectableCardState();
// }

// class _SelectableCardState extends State<SelectableCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Card(
//         color:
//             widget.isSelected ? widget.selectedColor : widget.unselectedColor,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 widget.imagePath,
//                 width: 40,
//                 height: 24,
//                 color: widget.isSelected ? null : widget.textColor,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 widget.label,
//                 style: TextStyle(
//                   color: widget.textColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
