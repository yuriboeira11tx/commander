class Command {
  int? commandId;
  int? commandIdentifier;
  String? client;
  List<dynamic>? orders;

  Command({
    required this.commandId,
    required this.commandIdentifier,
    required this.client,
    required this.orders,
  });

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      commandId: json["command_id"],
      commandIdentifier: json["command_identifier"],
      client: json["client"],
      orders: json["opened"],
    );
  }
}
