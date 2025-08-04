from sqlalchemy.orm import Session
from typing import Optional
from core.config import JWT
from models import User


def get_user_by_id(session: Session, user_id: str) -> Optional[User]:
    return session.query(User).filter(User.id == user_id).first()


def get_user_by_phone_number(session: Session, phone_number: str) -> Optional[User]:
    return session.query(User).filter(User.phone_number == phone_number).first()


def generate_token(session: Session, user_id: str) -> str:
    claims = {"user_id": user_id, "exp": 3600 * 24 * 7}
    token_key = JWT.generate_token(claims)
    return token_key
