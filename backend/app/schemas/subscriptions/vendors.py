from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class Status(str, Enum):
    ACTIVE = "active"
    CANCELLED = "cancelled"
    EXPIRED = "expired"

class subscriptionInfo(BaseModel):
    id : int
    start_date : datetime
    Optional[datetime] = None 
    price : float
    status : Status
    created_at: datetime = Field(default_factory=datetime.now)  
    updated_at: datetime = Field(default_factory=datetime.now) 
