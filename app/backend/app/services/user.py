from sqlalchemy.orm import Session

from serializers.user import UserSerializer
from repositories import user as repo


def update_user(session: Session, user_id: str, new_user: UserSerializer):
    if user := repo.get_user_by_id(session, user_id):
        return new_user.update(session, user, new_user.validated_data)
    return None
