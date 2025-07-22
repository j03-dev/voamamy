from repositories.user import get_user_by_phone_number
from serializers.user import UserSerializer
from core.config import JWT


def register(session, new_user: UserSerializer):
    if not get_user_by_phone_number(session, new_user.validated_data["phone_number"]):
        return new_user.save(session)
    return None


def login(session, phone_number: str, password: str):
    if user := get_user_by_phone_number(session, phone_number):
        if user.password == password:
            claims = {"user_id": user.id, "exp": 3600 * 24 * 7}
            token = JWT.generate_token(claims)
            return token
    return None
