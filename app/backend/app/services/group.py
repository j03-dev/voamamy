from sqlalchemy.orm import Session
from serializers.group import GroupSerializer
from repositories import group as repo
from models import Group

from typing import Optional
from datetime import datetime


def create(session: Session, user_id: str, new_group: GroupSerializer):
    if not repo.get_groups_by_user_id(session, user_id):
        group = new_group.save(session)
        repo.add_member_to_group(session, user_id, group.id)
        return group
    return None


def contribute_to_group_user_member(session: Session, user_id: str) -> Optional[Group]:
    if member := repo.get_member_by_user_id(session, user_id):
        today = datetime.utcnow().date()
        week_number = today.isocalendar().week
        year = today.isocalendar().year
        contribution = repo.create_contribution(
            session,
            member.id,
            member.group_id,
            week_number,
            year,
        )
        contribution.member.group.savings += 10_000
        session.commit()
        return contribution.group
    return None
