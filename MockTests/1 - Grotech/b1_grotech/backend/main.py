from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from sqlmodel import SQLModel, create_engine, Session
from routers import auth, animals, reference

# Initialize FastAPI app
app = FastAPI(title="AgroTech API", description="Backend for the AgroTech animal management app")

# SQLite database URL (file-based)
sqlite_file_name = "agrotech.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"

# Create the SQLModel engine (check_same_thread for SQLite multi-threading)
engine = create_engine(sqlite_url, echo=True, connect_args={"check_same_thread": False})

# Create database tables on startup
@app.on_event("startup")
def on_startup():
    SQLModel.metadata.create_all(engine)

# Dependency to get DB session
def get_session():
    with Session(engine) as session:
        yield session

# Mount '/media' directory for serving image/video files (spec expects media files):contentReference[oaicite:12]{index=12}.
app.mount("/media", StaticFiles(directory="media"), name="media")

# Include routers
app.include_router(auth.router, prefix="/auth", tags=["auth"])
app.include_router(animals.router, prefix="/animals", tags=["animals"])
app.include_router(reference.router)
