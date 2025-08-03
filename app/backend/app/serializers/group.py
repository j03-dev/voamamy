from oxapy import serializer
from models.group import Group
from core.utils import new_id


class MemberSerializer(serializer.Serializer):
    id = serializer.CharField(read_only=True, required=False)
    user_id = serializer.CharField(read_only=True, required=False)
    group_id = serializer.CharField()
    joined_at = serializer.CharField(read_only=True, required=False)


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
