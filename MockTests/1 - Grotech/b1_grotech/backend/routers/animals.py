from fastapi import APIRouter, Depends, HTTPException
from typing import List
from sqlmodel import Session, select
from models import Animal, Breed, Lot, AnimalVaccine, Vaccine, AnimalExercise
from schemas import AnimalCreate, AnimalListItem, AnimalDetail, AnimalVaccineRead, VaccineInfo, ExerciseRead
from main import get_session
from routers.auth import SECRET_KEY, ALGORITHM  # to decode token
import jwt

router = APIRouter()

def get_current_user(token: str = Depends(lambda: None), session: Session = Depends(get_session)):
    """
    Dependency to get the current user from JWT token in Authorization header.
    If token is invalid or missing, raises HTTP 401.
    """
    # For simplicity, this function would extract the token via OAuth2 dependency.
    # Here we simulate decoding for demonstration.
    raise HTTPException(status_code=401, detail="Not authenticated")

@router.get("/", response_model=List[AnimalListItem], summary="Get all animals")
async def list_animals(session: Session = Depends(get_session)):
    """
    Return a list of all animals (id, name, species, image). This matches the UI list view:contentReference[oaicite:14]{index=14}.
    """
    animals = session.exec(select(Animal)).all()
    return [AnimalListItem(
        id=a.id, name=a.name, species=a.species, image_path=a.image_path
    ) for a in animals]

@router.post("/", response_model=AnimalDetail, summary="Register a new animal")
async def create_animal(animal: AnimalCreate, session: Session = Depends(get_session)):
    """
    Register a new animal with fields name, weight, breed_id, type, is_castrated, age, lot_id, species, and image_path:contentReference[oaicite:15]{index=15}.
    """
    db_animal = Animal.from_orm(animal)
    session.add(db_animal)
    session.commit()
    session.refresh(db_animal)
    # Prepare detail output (no vaccines/exercises yet)
    breed = session.get(Breed, db_animal.breed_id)
    lot = session.get(Lot, db_animal.lot_id)
    return AnimalDetail(
        id=db_animal.id,
        name=db_animal.name,
        weight=db_animal.weight,
        type=db_animal.type,
        is_castrated=db_animal.is_castrated,
        age=db_animal.age,
        species=db_animal.species,
        image_path=db_animal.image_path,
        habitat=db_animal.habitat,
        breed=breed.name if breed else "",
        lot=lot.name if lot else "",
        vaccines=[],
        exercises=[]
    )

@router.get("/{animal_id}", response_model=AnimalDetail, summary="Get animal details")
async def get_animal(animal_id: int, session: Session = Depends(get_session)):
    """
    Get detailed info for a specific animal, including name, lot, habitat, vaccines, and exercise history:contentReference[oaicite:16]{index=16}:contentReference[oaicite:17]{index=17}.
    """
    animal = session.get(Animal, animal_id)
    if not animal:
        raise HTTPException(status_code=404, detail="Animal not found")
    breed = session.get(Breed, animal.breed_id)
    lot = session.get(Lot, animal.lot_id)
    # Vaccination records
    av_records = session.exec(select(AnimalVaccine).where(AnimalVaccine.animal_id == animal_id)).all()
    vaccines = []
    for av in av_records:
        vaccine = session.get(Vaccine, av.vaccine_id)
        vaccines.append(AnimalVaccineRead(
            id=av.id,
            done=av.done,
            vaccine=VaccineInfo(id=vaccine.id, name=vaccine.name) if vaccine else None
        ))
    # Exercise records
    ex_records = session.exec(select(AnimalExercise).where(AnimalExercise.animal_id == animal_id)).all()
    exercises = [ExerciseRead(date=ex.date, did_exercise=ex.did_exercise) for ex in ex_records]
    return AnimalDetail(
        id=animal.id,
        name=animal.name,
        weight=animal.weight,
        type=animal.type,
        is_castrated=animal.is_castrated,
        age=animal.age,
        species=animal.species,
        image_path=animal.image_path,
        habitat=animal.habitat,
        breed=breed.name if breed else "",
        lot=lot.name if lot else "",
        vaccines=vaccines,
        exercises=exercises
    )

@router.delete("/{animal_id}", summary="Delete an animal")
async def delete_animal(animal_id: int, session: Session = Depends(get_session)):
    """
    Delete an animal by ID. This supports the swipe-to-delete action in the UI:contentReference[oaicite:18]{index=18}.
    """
    animal = session.get(Animal, animal_id)
    if not animal:
        raise HTTPException(status_code=404, detail="Animal not found")
    session.delete(animal)
    session.commit()
    return {"detail": "Animal deleted successfully"}
