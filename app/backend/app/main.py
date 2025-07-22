from oxapy import HttpServer
from core.config import AppData
from api import auth

server = HttpServer(("0.0.0.0", 5555))
server.app_data(AppData())
server.attach(auth.router)

if __name__ == "__main__":
    server.run()
