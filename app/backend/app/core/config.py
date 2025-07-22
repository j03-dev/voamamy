from os import getenv
from oxapy import jwt

SECRET = getenv("SECRET")
JWT = jwt.Jwt(SECRET)
ENGINE = None


class AppData:
    def __init__(self):
        self.engine = ENGINE
