class Command {
  int? commandId;
  int? commandIdentifier;
  String? client;
  List<dynamic>? orders;
  List<dynamic>? delivered;

  Command({
    required this.commandId,
    required this.commandIdentifier,
    required this.client,
    required this.orders,
    required this.delivered,
  });

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      commandId: json["command_id"],
      commandIdentifier: json["command_identifier"],
      client: json["client"],
      orders: json["opened"],
      delivered: json["delivered"],
    );
  }
}
