from oxapy import Router, Request, Status
from serializers.user import UserSerializer, CredentialSerializer
from sqlalchemy.orm import Session

from core.utils import with_session
from services import auth as srvs

router = Router()


@router.post("/api/auth/register")
@with_session
def register(request: Request, session: Session):
    new_user = UserSerializer(request.data)
    new_user.is_valid()
    if user := srvs.register(session, new_user):
        user_serializer = UserSerializer(instance=user)
        return {"users": user_serializer.data}, Status.CREATED
    return {"detail": "A user with this phone number already exists."}, Status.CONFLICT


@router.post("/api/auth/login")
@with_session
def login(request: Request, session: Session):
    cred = CredentialSerializer(request.data)
    cred.is_valid()
    if token := srvs.login(session, **cred.validated_data):
        return {"token": token}
    return {"detail": "The provided phone number or password is incorrect."}, Status.BAD_REQUEST
