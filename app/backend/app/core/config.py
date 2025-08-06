from os import getenv
from oxapy import jwt
from dotenv import load_dotenv
from sqlalchemy import create_engine


load_dotenv()

SECRET = getenv("SECRET")
JWT = jwt.Jwt(SECRET)

TURSO_DATABASE_URL = getenv("TURSO_DATABASE_URL")
TURSO_AUTH_TOKEN = getenv("TURSO_AUTH_TOKEN")

ENGINE = create_engine(
    "sqlite+libsql:///embedded.db",
    connect_args={
        "auth_token": TURSO_AUTH_TOKEN,
        "sync_url": TURSO_DATABASE_URL,
    },
)


class AppData:
    def __init__(self):
        self.engine = ENGINE
