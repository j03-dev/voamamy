from sqlalchemy.orm import Session

from serializers.group import GroupSerializer
from repositories import group as repo


def create(session: Session, user_id: str, new_group: GroupSerializer):
    if not repo.get_groups_by_user_id(session, user_id):
        group = new_group.save(session)
        repo.add_member_to_group(session, user_id, group.id)
        return group
    return None
