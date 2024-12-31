from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from app.schemas.profiles.user import UserInfo, skillLevel


class VendorInfo(UserInfo):
    can_ship: bool = False  
    description: Optional[str] = None  
    status: str = "active" 
    rating: Optional[float] = None 
    created_at: datetime
    updated_at: datetime
