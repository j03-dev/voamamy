from oxapy import serializer

from models import User
from core.utils import new_id


class PhoneNumberSerializer(serializer.CharField):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.pattern = r"^(?:\+261|0)(32|33|34|37|38)\d{7}$"


class CredentialSerializer(serializer.Serializer):
    phone_number = PhoneNumberSerializer()
    password = serializer.CharField(min_length=8)


class UserSerializer(serializer.Serializer):
    id = serializer.CharField(read_only=True, required=False, nullable=True)
    phone_number = PhoneNumberSerializer()
    full_name = serializer.CharField()
    password = serializer.CharField(
        min_length=8,
        required=False,
        nullable=True,
        write_only=True,
    )
    created_at = serializer.DateTimeField(required=False, nullable=True, read_only=True)

    class Meta:
        model = User

    def create(self, session, validated_data):
        validated_data["id"] = new_id()
        instance = super().create(session, validated_data)
        return instance
