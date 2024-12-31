from pydantic import BaseModel, EmailStr
from typing import Optional, Dict, List
from datetime import datetime, date
from app.schemas.profiles.user import skillLevel, speciality
from enum import Enum

class Status(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    SUSPENDED = "suspended"

class type(str, Enum):   ##this is the schedule type
    ONE_TIME = "one_time"
    WEEKLY = "weekly"
    MONTHLY = "monthly"
class listingInfo(BaseModel):
    listing_id : int
    title : str
    listing_type : speciality
    description : str
    status : Status
    schedule_type : type
    sessions_per_week : int
    custom_schedule: Optional[Dict[str, List[str]]] = None  
    indvidual_price : float 
    indvidual_duration : float
    group_price : float
    group_duration : float
    min_students : int
    max_students : int
    current_students : int
    age_group : str
    skill_level : skillLevel
    created_at: datetime = datetime.now()  
    updated_at: datetime = datetime.now()





