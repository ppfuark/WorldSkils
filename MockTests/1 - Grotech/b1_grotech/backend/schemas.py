from pydantic import BaseModel, Field, EmailStr
from typing import Optional, List
from datetime import date

class LoginRequest(BaseModel):
    email: EmailStr = Field(..., example="farmer@example.com")
    password: str = Field(..., example="strongpassword123")


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"


class BreedRead(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True


class LotRead(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True


class AnimalCreate(BaseModel):
    name: str = Field(..., example="Bessie")
    weight: float = Field(..., example=250.5)
    type: str = Field(..., example="female", description="male or female")
    is_castrated: bool = Field(..., example=False)
    age: int = Field(..., example=3)
    species: str = Field(..., example="Cow")
    image_path: str = Field(..., example="images/cow.png")
    breed_id: int = Field(..., example=1, description="ID of breed from /breeds")
    lot_id: int = Field(..., example=2, description="ID of lot from /lots")


class AnimalListItem(BaseModel):
    id: int
    name: str
    species: str
    image_path: str

    class Config:
        orm_mode = True


class VaccineInfo(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True


class AnimalVaccineRead(BaseModel):
    id: int
    done: bool
    vaccine: VaccineInfo

    class Config:
        orm_mode = True


class ExerciseRead(BaseModel):
    date: date
    did_exercise: bool

    class Config:
        orm_mode = True


class AnimalDetail(BaseModel):
    id: int
    name: str
    weight: float
    type: str
    is_castrated: bool
    age: int
    species: str
    image_path: str
    habitat: str
    breed: str
    lot: str
    vaccines: List[AnimalVaccineRead]
    exercises: List[ExerciseRead]

    class Config:
        orm_mode = True
