class MembershipPlan {
  final String id;
  final String name;
  final String amount;
  final String contacts;
  final String validity;

  MembershipPlan({
    required this.id,
    required this.name,
    required this.amount,
    required this.contacts,
    required this.validity,
  });

  factory MembershipPlan.fromJson(Map<String, dynamic> json) {
    return MembershipPlan(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      contacts: json['contacts'],
      validity: json['validity'],
    );
  }
}
