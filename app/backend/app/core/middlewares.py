from typing import Callable
from .config import JWT
from oxapy import Request, jwt as jsonwebtoken, Status


def jwt(request: Request, next: Callable, **kwargs):
    if token := request.headers.get("authorization", "").replace("Bearer ", ""):
        try:
            claims = JWT.verify(token)
            request.user_id = claims['user_id']
            return next(request, **kwargs)
        except jsonwebtoken.JwtError as err:
            return {"message": str(err)}, Status.UNAUTHORIZED
    return {"message": "Token is required"}, Status.UNAUTHORIZED
