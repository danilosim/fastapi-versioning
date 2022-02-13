from pydantic import BaseSettings


class Settings(BaseSettings):
    a_secret: str
    datadog_host: str
    datadog_port: int
    datadog_enabled: bool

    class Config:
        env_file = ".env"


settings = Settings()
