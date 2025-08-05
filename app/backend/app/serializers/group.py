from oxapy import serializer
from models import Group

from core.utils import new_id
from serializers.user import UserSerializer
from repositories import group as repo
from sqlalchemy.orm import Session

from datetime import datetime


class MemberSerializer(serializer.Serializer):
    id = serializer.CharField(read_only=True, required=False)
    user_id = serializer.CharField(read_only=True, required=False)
    group_id = serializer.CharField()
    joined_at = serializer.CharField(read_only=True, required=False)

    user = UserSerializer(read_only=True, required=False)  # type: ignore

    @staticmethod
    def has_contributed_this_week(session: Session, member_id: str) -> bool:
        today = datetime.utcnow().date()
        week_number = today.isocalendar().week
        year = today.isocalendar().year
        return repo.has_contributed_this_week(session, member_id, week_number, year)

    def to_representation(self, instance):
        session = self.context.get("session")
        data = super().to_representation(instance)
        data["has_contributed_this_week"] = self.has_contributed_this_week(
            session, data["id"]
        )
        return data


class GroupSerializer(serializer.Serializer):
    id = serializer.CharField(read_only=True, required=False)
    name = serializer.CharField()
    creator_id = serializer.CharField(read_only=True, required=False)
    created_at = serializer.CharField(read_only=True, required=False)
    savings = serializer.CharField(read_only=True, required=False)

    members = MemberSerializer(read_only=True, required=False, many=True)  # type: ignore

    class Meta:
        model = Group

    def create(self, session, validated_data):
        request = self.context.get("request")
        validated_data["id"] = new_id()
        validated_data["creator_id"] = request.user_id
        return super().create(session, validated_data)
