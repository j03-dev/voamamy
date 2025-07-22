from sqlalchemy.orm import Session
from typing import Optional
from core.config import JWT
from core.utils import new_id
from models.user import User, Token


def get_user_by_id(session: Session, user_id: str) -> Optional[User]:
    return session.query(User).filter_by(id=user_id).first()


def get_user_by_phone_number(session: Session, phone_number: str) -> Optional[User]:
    return session.query(User).filter_by(phone_number=phone_number).first()


def get_token(session: Session, user_id: str) -> Optional[Token]:
    return session.query(Token).filter_by(user_id=user_id).first()


def create_token(session: Session, user_id: str, key: str) -> Token:
    token = Token(id=new_id(), key=key, user_id=user_id)
    session.add(token)
    session.commit()
    return token


def get_or_create_token(session: Session, user_id: str) -> Token:
    if token := get_token(session, user_id):
        return token
    claims = {"user_id": user_id, "exp": 3600 * 24 * 7}
    token_key = JWT.generate_token(claims)
    token = create_token(session, user_id, token_key)
    return token
