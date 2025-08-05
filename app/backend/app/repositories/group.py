from sqlalchemy.orm import Session
from models import Group, Member, Contribution, User
from typing import Optional
from core.utils import new_id


def get_group_by_id(session: Session, group_id: str) -> Optional[Group]:
    # type: ignore
    return session.query(Group).filter(Group.id == group_id).first()


def get_groups_by_user_id(session: Session, user_id: str) -> Optional[Group]:
    # type: ignore
    return (
        session.query(Group)
        .filter(
            (Group.members.any(Member.user_id == user_id))
            | (Group.creator_id == user_id)
        )
        .first()
    )


def add_member_to_group(session, user_id: str, group_id) -> Member:
    new_member = Member(id=new_id(), user_id=user_id, group_id=group_id)
    session.add(new_member)
    session.commit()
    return new_member


def has_contributed_this_week(
    session: Session, member_id: str, week_number: int, year: int
) -> bool:
    contribution = (
        session.query(Contribution)
        .filter(
            Contribution.member_id == member_id,  # type: ignore
            Contribution.week_number == week_number,  # type: ignore
            Contribution.year == year,  # type: ignore
        )
        .first()
    )
    return contribution is not None


def create_contribution(
    session: Session,
    member_id: str,
    group_id: str,
    week_number: int,
    year: int,
):
    new_contribution = Contribution(
        id=new_id(),
        member_id=member_id,
        group_id=group_id,
        week_number=week_number,
        year=year,
    )
    session.add(new_contribution)
    session.commit()
    return new_contribution
