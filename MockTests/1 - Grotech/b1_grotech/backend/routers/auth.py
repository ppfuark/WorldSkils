from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.exc import NoResultFound
from sqlmodel import Session, select
import jwt
from models import User
from schemas import LoginRequest, TokenResponse
from main import get_session

router = APIRouter()

SECRET_KEY = "YOUR_SECRET_KEY"  # Replace with a secure key in production
ALGORITHM = "HS256"

@router.post("/login", response_model=TokenResponse, summary="User login")
async def login(credentials: LoginRequest, session: Session = Depends(get_session)):
    """
    Authenticate user with email and password. Returns a JWT bearer token if valid:contentReference[oaicite:13]{index=13}.
    """
    statement = select(User).where(User.email == credentials.email)
    user = session.exec(statement).first()
    if not user or user.hashed_password != f"fakehashed{credentials.password}":
        # Invalid credentials
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid email or password")
    # Create JWT token (subject is user email)
    payload = {"sub": user.email}
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
    return {"access_token": token, "token_type": "bearer"}
