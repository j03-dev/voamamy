from sqlalchemy.orm import Session

from serializers.group import GroupSerializer
from repositories import group as repo


def create(session: Session, user_id: str, new_group: GroupSerializer):
    if not repo.get_member_by_user_id(session, user_id):
        return new_group.save(session)
    return None
