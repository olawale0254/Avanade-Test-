from fastapi import FastAPI
import os

app = FastAPI()

SERVICE_VERSION = os.getenv("SERVICE_VERSION", "1.0")

@app.get("/hello")
def read_root():
    return {"message": f"Hello world, version {SERVICE_VERSION}"}
