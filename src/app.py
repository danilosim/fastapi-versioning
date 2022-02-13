from ddtrace import patch_all, tracer
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.config import settings
from src.routers import example


def create_app():
    app = FastAPI(
        openapi_url="/swagger.json",
        docs_url="/",
        redoc_url=None,
    )
    origins = ["http://localhost"]
    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    app.include_router(example.router)

    tracer.configure(
        hostname=settings.datadog_host,
        port=settings.datadog_port,
        https=False,
        enabled=settings.datadog_enabled,
    )
    patch_all()

    return app


app = create_app()
