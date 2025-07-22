from oxapy import serializer


class CredentialSerializer(serializer.Serializer):
    phone_number = serializer.CharField()  # TODO: add phone_number pattern
    password = serializer.CharField(min_lenght=8)


class UserSerializer(serializer.Serializer):
    id = serializer.CharField(write_only=True, required=False, nullable=True)
    phone_number = serializer.CharField()  # TODO: add phone_number pattern
    full_name = serializer.CharField()
    password = serializer.CharField(min_lenght=8, write_only=True)
