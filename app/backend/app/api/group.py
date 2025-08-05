from oxapy import Router, Request, Status
from sqlalchemy.orm import Session

from core.middlewares import jwt
from core.utils import with_session
from serializers.group import GroupSerializer
from services import group as srvs
from repositories import group as repo

router = Router()
router.middleware(jwt)


@router.post("/api/groups")
@with_session
def create(request: Request, session: Session):
    new_group = GroupSerializer(request.data, context={"request": request})
    new_group.is_valid()
    if group := srvs.create(session, request.user_id, new_group):
        group_serializer = GroupSerializer(instance=group, context={"session": session})
        return {"groups": group_serializer.data}, Status.CREATED
    return {"detail": "Failed to create group"}, Status.BAD_REQUEST


@router.get("/api/groups/my")
@with_session
def mygroup(request: Request, session: Session):
    if group := repo.get_groups_by_user_id(session, request.user_id):
        group_serializer = GroupSerializer(instance=group, context={"session": session})
        return {"groups": group_serializer.data}, Status.CREATED
    return {"detail": "Group not found"}, Status.NOT_FOUND


@router.post("/api/groups/contributions")
@with_session
def contribute(request: Request, session: Session):
    if group := srvs.contribute_to_group_user_member(session, request.user_id):
        group_serializer = GroupSerializer(instance=group, context={"session": session})
        return {"groups": group_serializer.data}
    return {"detail": "You have already contribute in this weeke"}, Status.BAD_REQUEST
