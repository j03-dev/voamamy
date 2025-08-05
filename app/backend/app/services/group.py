from sqlalchemy.orm import Session
from serializers.group import GroupSerializer, MemberSerializer
from repositories import group as repo
from models import Group, User

from typing import Optional
from datetime import datetime


def create(session: Session, user_id: str, new_group: GroupSerializer):
    if not repo.get_groups_by_user_id(session, user_id):
        group = new_group.save(session)
        repo.add_member_to_group(session, user_id, group.id)
        return group
    return None


def record_weekly_group_contribution(session: Session, user_id: str, group_id: str) -> Optional[Group]:
    if user := session.get(User, user_id):
        # Check if the user has already contributed to a group this week.
        if not MemberSerializer.has_contributed_this_week(session, user.member.id):
            today = datetime.utcnow().date()
            week_number = today.isocalendar().week
            year = today.isocalendar().year
            contribution = repo.create_contribution(
                session,
                user.member.id,
                group_id,
                week_number,
                year,
            )
            contribution.member.group.savings += 10_000
            session.commit()
            return contribution.group
    return None
