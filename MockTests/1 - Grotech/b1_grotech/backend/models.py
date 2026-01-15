from sqlmodel import SQLModel, Field, Relationship
from typing import Optional, List
from datetime import date

class Breed(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str

    animals: List["Animal"] = Relationship(back_populates="breed")


class Lot(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str

    animals: List["Animal"] = Relationship(back_populates="lot")


class User(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    email: str = Field(index=True, unique=True)
    hashed_password: str


class Animal(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str
    weight: float
    type: str  # 'male' or 'female'
    is_castrated: bool = Field(default=False)
    age: int
    species: str
    image_path: str  # file path to animal image (under /media)
    habitat: str = Field(default="Interno")  # 'Interno', 'Externo', or 'Misto'
    breed_id: int = Field(foreign_key="breed.id")
    lot_id: int = Field(foreign_key="lot.id")

    breed: Optional[Breed] = Relationship(back_populates="animals")
    lot: Optional[Lot] = Relationship(back_populates="animals")
    vaccines: List["AnimalVaccine"] = Relationship(back_populates="animal")
    exercises: List["AnimalExercise"] = Relationship(back_populates="animal")


class Vaccine(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str

    animal_vaccines: List["AnimalVaccine"] = Relationship(back_populates="vaccine")


class AnimalVaccine(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    animal_id: int = Field(foreign_key="animal.id")
    vaccine_id: int = Field(foreign_key="vaccine.id")
    done: bool = Field(default=False)

    animal: Optional[Animal] = Relationship(back_populates="vaccines")
    vaccine: Optional[Vaccine] = Relationship(back_populates="animal_vaccines")


class AnimalExercise(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    animal_id: int = Field(foreign_key="animal.id")
    date: date = Field(default_factory=date.today)
    did_exercise: bool = Field(default=False)

    animal: Optional[Animal] = Relationship(back_populates="exercises")
