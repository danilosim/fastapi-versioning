from pydantic import BaseModel

from src.utils.decorators import as_form


@as_form
class ExampleResponse(BaseModel):
    sum: int
