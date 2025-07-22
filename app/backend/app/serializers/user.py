from oxapy import serializer

from models.user import User
from core.utils import new_id


class CredentialSerializer(serializer.Serializer):
    phone_number = serializer.CharField()  # TODO: add phone_number pattern
    password = serializer.CharField(min_length=8)


class UserSerializer(serializer.Serializer):
    id = serializer.CharField(read_only=True, required=False, nullable=True)
    phone_number = serializer.CharField()  # TODO: add phone_number pattern
    full_name = serializer.CharField()
    password = serializer.CharField(min_length=8, write_only=True)
    created_at = serializer.DateTimeField(required=False, nullable=True, read_only=True)

    class Meta:
        model = User

    def create(self, session, validated_data):
        validated_data["id"] = new_id()
        instance = super().create(session, validated_data)
        return instance
