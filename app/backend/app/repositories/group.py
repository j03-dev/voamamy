from sqlalchemy.orm import Session
from models.group import Group, Member
from typing import Optional


def get_group_by_id(session: Session, group_id: str) -> Optional[Group]:
    return session.query(Group).filter(Group.id == group_id).first()  # type: ignore


def get_member_by_user_id(session: Session, user_id: str) -> Optional[Member]:
    return session.query(Member).filter(Member.user_id == user_id).first()  # type: ignore
