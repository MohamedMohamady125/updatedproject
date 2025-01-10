from pydantic import BaseModel
from typing import Optional
from app.schemas.profiles.user import UserInfo, speciality
from datetime import date, datetime
from enum import Enum

    
class CoachInfo(UserInfo):
    speciality: speciality  # Swimming, Fitness, Both
    experience_years: int
    description: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    

class CoachResponse(BaseModel):
    id: int
    speciality: str
    experience_years: int
    description: Optional[str] = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True  # Enable ORM mode for SQLAlchemy models
