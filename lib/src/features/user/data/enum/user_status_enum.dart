enum UserStatus {
  ACTIVE,
  CREATED,
  INACTIVE,
  SUSPENDED,
}

extension ParseToString on UserStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}
