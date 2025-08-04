from sqlalchemy.orm import mapped_column, relationship, Mapped, DeclarativeBase
from sqlalchemy import ForeignKey
from datetime import datetime


class Base(DeclarativeBase):
    pass


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(primary_key=True)
    phone_number: Mapped[str] = mapped_column(unique=True)
    full_name: Mapped[str] = mapped_column()
    password: Mapped[str] = mapped_column()
    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    member: Mapped["Member"] = relationship(back_populates="user")


class Contribution(Base):
    __tablename__ = "contributions"

    id: Mapped[str] = mapped_column(primary_key=True)
    member_id: Mapped[str] = mapped_column(ForeignKey("members.id"))
    group_id: Mapped[str] = mapped_column(ForeignKey("groups.id"))
    at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    member: Mapped["Member"] = relationship(back_populates="contributions")


class Member(Base):
    __tablename__ = "members"

    id: Mapped[str] = mapped_column(primary_key=True)
    user_id: Mapped[str] = mapped_column(ForeignKey("users.id"))
    group_id: Mapped[str] = mapped_column(ForeignKey("groups.id"))
    joined_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    user: Mapped["User"] = relationship(back_populates="member")
    group: Mapped["Group"] = relationship(back_populates="members")
    contributions: Mapped[list["Contribution"]] = relationship(back_populates="member")


class Group(Base):
    __tablename__ = "groups"

    id: Mapped[str] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(unique=True)
    creator_id: Mapped[str] = mapped_column(ForeignKey("users.id"))
    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)
    savings: Mapped[float] = mapped_column(default=0)

    members: Mapped[list["Member"]] = relationship(back_populates="group")
