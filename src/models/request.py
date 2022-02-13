from pydantic import BaseModel

from src.utils.decorators import as_form


@as_form
class ExampleRequest(BaseModel):
    augend: int
    addend: int
