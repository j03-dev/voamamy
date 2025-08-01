from repositories import user as repo
from serializers.user import UserSerializer


def register(session, new_user: UserSerializer):
    if not repo.get_user_by_phone_number(
        session,
        new_user.validated_data["phone_number"],
    ):
        return new_user.save(session)
    return None


def login(session, phone_number: str, password: str) -> str | None:
    if user := repo.get_user_by_phone_number(session, phone_number):
        if user.password == password:
            return repo.generate_token(session, user.id)
    return None
