from os import getenv
from oxapy import jwt
from dotenv import load_dotenv
from sqlalchemy import create_engine

from models import Base

load_dotenv()

SECRET = getenv("SECRET")
JWT = jwt.Jwt(SECRET)


TURSO_DB_URL = getenv("TURSO_DATABASE_URL")
TURSO_DB_AUTH_TOKEN = getenv("TURSO_AUTH_TOKEN")

DATABASE_URL = "sqlite+libsql:///database.db"

ENGINE = create_engine(
    DATABASE_URL,
    # connect_args={
    #     "auth_token": TURSO_AUTH_TOKEN,
    #     "sync_url": TURSO_DATABASE_URL,
    # },
)


class AppData:
    def __init__(self):
        self.engine = ENGINE
        Base.metadata.create_all(ENGINE)
