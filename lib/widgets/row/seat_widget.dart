import 'package:flutter/material.dart';

import '../../model/seats.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;
  final bool isSelected;
  const SeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    if (seat.seatName == null || seat.seatName!.isEmpty) {
      return const FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 30,
          width: 30,
        ),
      );
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: InkWell(
        onTap: canSelect()?onTap:null,
        child: Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : getColor(),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                seat.seatName!,
                style: textTheme.bodySmall!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor() {

    if(seat.status == "Sold Out"){
      return Colors.grey;
    }else if(seat.status == "Reserve"){
      return Colors.orange;
    }else if(seat.status == "Available"){
      return Colors.green;
    }else{
      return Colors.grey;
    }

  }

  bool canSelect(){
    if(seat.status == "Sold Out"){
      return false;
    }else if(seat.status == "Reserve"){
      return false;
    }else if(seat.status == "Available"){
      return true;
    }else{
      return false;
    }
  }

}
