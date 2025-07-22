from sqlalchemy.orm import mapped_column, Mapped, relationship
from app.models import Base

from sqlalchemy import (
    DateTime,
    ForeignKey,
    # Text,
    # Date,
    # Table,
    # Column,
    # Float,
    # Boolean,
)
from datetime import datetime


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(primary_key=True)
    phone_number: Mapped[str] = mapped_column()
    full_name: Mapped[str] = mapped_column()
    password: Mapped[str] = mapped_column()
    created_at: Mapped[DateTime] = mapped_column(default=datetime.utcnow)

    token: Mapped["Token"] = relationship(back_populates="user")


class Token(Base):
    __tablename__ = "token"

    id: Mapped[str] = mapped_column(primary_key=True)
    key: Mapped[str] = mapped_column()
    created_at: Mapped[DateTime] = mapped_column(default=datetime.utcnow)
    user_id:Mapped[str] = mapped_column(Fore

    user: Mapped["User"] = relationship(back_populates="token")
