from oxapy import Router, Request, Status
from serializers.user import UserSerializer, CredentialSerializer

import services as srvs

router = Router()


@router.get("/api/auth/register")
def register(request: Request, session):
    new_user = UserSerializer(request.data)
    new_user.is_valid()
    if user := srvs.auth.register(session, new_user):
        user_serializer = UserSerializer(instance=user)
        return {"users": user_serializer.data}, Status.CREATED
    return {"message": "This phone number is alredy used"}, Status.CONFLICT


@router.post("/api/auth/login")
def login(request: Request, session):
    cred = CredentialSerializer(request.data)
    cred.is_valid()
    if token := srvs.auth.login(session, **cred.validated_data):
        return {"token": token}
    return {"message": "The phone number or the password is false"}, Status.BAD_REQUEST
