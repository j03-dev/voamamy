from typing import Callable
from .config import JWT
from oxapy import Request, jwt as jsonwebtoken, Status


import logging


def jwt(request: Request, next: Callable, **kwargs):
    if token := request.headers.get("authorization", "").replace("Bearer ", ""):
        try:
            claims = JWT.verify_token(token)
            request.user_id = claims["user_id"]
            return next(request, **kwargs)
        except jsonwebtoken.JwtError as err:
            return {"detail": str(err)}, Status.UNAUTHORIZED
    return {"detail": "Token is required"}, Status.UNAUTHORIZED


def logger(request: Request, next: Callable, **kwargs):
    logging.log(1000, f"{request.method} {request.uri}")
    return next(request, **kwargs)
