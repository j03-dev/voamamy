from repositories import user as repo
from serializers.user import UserSerializer
from models.user import User


def register(session, new_user: UserSerializer):
    if not repo.get_user_by_phone_number(
        session,
        new_user.validated_data["phone_number"],
    ):
        return new_user.save(session)
    return None


def login(session, phone_number: str, password: str) -> User | None:
    if user := repo.get_user_by_phone_number(session, phone_number):
        if user.password == password:
            return repo.get_or_create_token(session, user.id)
    return None
