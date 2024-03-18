
List<Seat> seatsFromJson(List<dynamic> seatsJson) => List<Seat>.from(
    seatsJson.map((seatJson) => Seat.fromJson(seatJson)));

class Seat {
  int? seatId;
  String? seatName;
  int? rowNo;
  int? columnNo;
  String? status;
  String? ticketNumber;

  Seat({this.seatId, this.seatName, this.rowNo, this.columnNo, this.status});

  Seat.fromJson(Map<String, dynamic> json) {
    seatId = json['seat_id'];
    seatName = json['seat_name'];
    rowNo = json['row_no'];
    columnNo = json['column_no'];
    status = json['status'];
    ticketNumber = json['ticket_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seat_id'] = seatId;
    data['seat_name'] = seatName;
    data['row_no'] = rowNo;
    data['column_no'] = columnNo;
    data['status'] = status;
    data['ticket_number'] = ticketNumber;
    return data;
  }
}

