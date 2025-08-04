from sqlalchemy.orm import mapped_column, relationship, Mapped
from datetime import datetime

from models.group import Member
from models import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(primary_key=True)
    phone_number: Mapped[str] = mapped_column(unique=True)
    full_name: Mapped[str] = mapped_column()
    password: Mapped[str] = mapped_column()
    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    member: Mapped["Member"] = relationship(back_populates="user")
