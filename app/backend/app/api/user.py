from oxapy import Router, Request, Status
from sqlalchemy.orm import Session

from repositories import user as repo
from serializers.user import UserSerializer
from services import user as srvs

from core.middlewares import jwt
from core.utils import with_session

router = Router()
router.middleware(jwt)


@router.get("/api/users/me")
@with_session
def me(request: Request, session: Session):
    if user := repo.get_user_by_id(session, request.user_id):
        user_serializer = UserSerializer(instance=user)
        return {"users": user_serializer.data}
    return {"message": "User not found"}, Status.NOT_FOUND


@router.get("/api/users/{user_id}")
@with_session
def retrieve(request: Request, session: Session, user_id: str):
    if user := repo.get_user_by_id(session, user_id):
        user_serializer = UserSerializer(instance=user)
        return {"users": user_serializer.data}
    return {"message": "User not found"}, Status.NOT_FOUND


@router.put("/api/users/{user_id}")
@with_session
def update(request: Request, session: Session, user_id: str):
    new_user = UserSerializer(request.data)
    new_user.is_valid()
    if user := srvs.update_user(session, user_id, new_user):
        user_serializer = UserSerializer(instance=user)
        return {"users": user_serializer.data}, Status.ACCEPTED
    return {"message": "User not found"}, Status.NOT_FOUND
