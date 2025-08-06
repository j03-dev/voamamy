from oxapy import Router, Request, Status
from sqlalchemy.orm import Session

from core.middlewares import jwt
from core.utils import with_session
from serializers.group import GroupSerializer, LoanSerializer
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
    return {"detail": "Group creation failed."}, Status.BAD_REQUEST


@router.get("/api/groups/my")
@with_session
def mygroup(request: Request, session: Session):
    if group := repo.get_groups_by_user_id(session, request.user_id):
        group_serializer = GroupSerializer(instance=group, context={"session": session})
        return {"groups": group_serializer.data}, Status.CREATED
    return {"detail": "No group found for the current user."}, Status.NOT_FOUND


@router.post("/api/groups/{group_id}/contributions")
@with_session
def contribute(request: Request, session: Session, group_id: str):
    if group := srvs.record_weekly_group_contribution(
        session, request.user_id, group_id
    ):
        group_serializer = GroupSerializer(instance=group, context={"session": session})
        return {"group": group_serializer.data}, Status.CREATED
    return {"detail": "You have already contributed this week."}, Status.CONFLICT


@router.post("api/groups/loans")
@with_session
def request_loan(request: Request, session: Session):
    new_loan = LoanSerializer(request.data, context={"request": request})
    new_loan.is_valid()
    if loan := srvs.request_laon(session, new_loan):
        loan_serializer = LoanSerializer(instance=loan)
        return {"loans": loan_serializer.data}, Status.ACCEPTED
    return {
        "detail": "You have alredy laon that pending or not yet repaid.",
    }, Status.CONFLICT
