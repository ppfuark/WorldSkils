from fastapi import APIRouter, Depends
from sqlmodel import Session, select
from models import Breed, Lot
from schemas import BreedRead, LotRead
from main import get_session

router = APIRouter(tags=["lookup"])

@router.get("/breeds", response_model=list[BreedRead], summary="Get all breeds")
async def list_breeds(session: Session = Depends(get_session)):
    """
    Return all animal breeds for the dropdown (matches spec: breed data comes from API):contentReference[oaicite:19]{index=19}.
    """
    breeds = session.exec(select(Breed)).all()
    return breeds

@router.get("/lots", response_model=list[LotRead], summary="Get all lots")
async def list_lots(session: Session = Depends(get_session)):
    """
    Return all lot options for the dropdown (as per spec: lot data from API):contentReference[oaicite:20]{index=20}.
    """
    lots = session.exec(select(Lot)).all()
    return lots
