from functools import wraps
from oxapy import Request
from typing import TypeVar, Callable, Any
from sqlalchemy.orm import Session

import uuid


F = TypeVar("F", bound=Callable[..., Any])


def with_session(func: F) -> F:
    @wraps(func)
    def wrapper(request: Request, *args, **kwargs):
        # pyrefly: ignore
        with Session(request.app_data.engine) as session:
            return func(request, session, *args, **kwargs)

    return wrapper  # pyrefly: ignore


def new_id() -> str:
    return str(uuid.uuid4())
