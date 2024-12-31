from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from app.schemas.profiles.user import UserInfo, skillLevel

class SwimmerInfo(UserInfo):
    skill_level: skillLevel  
    goals: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    age_group: Optional[str] = None

