from models import Base
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy import ForeignKey

from datetime import datetime

# TODO: Member should have state


class Member(Base):
    __tablename__ = "members"

    id: Mapped[str] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id"))
    group_id: Mapped[str] = mapped_column(ForeignKey("groups.id"))
    joined_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    group: Mapped["Group"] = relationship(back_populates="members")


class Group(Base):
    __tablename__ = "groups"

    id: Mapped[str] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(unique=True)
    creator_id: Mapped[str] = mapped_column(ForeignKey("users.id"))
    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)
    savings: Mapped[float] = mapped_column(default=0)

    members: Mapped[list["Member"]] = relationship(back_populates="group")
