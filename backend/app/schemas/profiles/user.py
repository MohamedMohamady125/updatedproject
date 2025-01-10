from pydantic import BaseModel, EmailStr
from datetime import datetime
from enum import Enum
from typing import Optional

class Role(str, Enum):
    SWIMMER_PARENT = "swimmer or parent"
    COACH = "coach"
    ACADEMY = "academy"
    EVENT_ORGANIZER = "event_organizer"
    SUPPORT_AGENT = "support agent"
    ADMIN = "admin"
    PHOTOGRAPHER = "photographer"
    VENDOR = "vendor"

class AccountStatus(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    SUSPENDED = "suspended"
    BANNED = "banned"

class gender(str, Enum):
    MALE = "male"
    FEMALE = "female"

class speciality(str, Enum):
    SWIMMING = "swimming"
    FITNESS = "fitness"

class skillLevel(str, Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"

class UserInfo(BaseModel):
    id: int
    name: str
    email: EmailStr
    phone_number: Optional[str] = None
    role: Role
    profile_photo_url: Optional[str] = None
    account_status: AccountStatus = AccountStatus.ACTIVE
    main_location: Optional[str] = None
    created_at: datetime
    updated_at: datetime



class userRegister(BaseModel):
    name: str
    email: EmailStr
    password: str
    role: Role
    phone_number: Optional[str] = None
    profile_photo_url: Optional[str] = None
    main_location: Optional[str] = None


class userLogin(BaseModel):
    email : EmailStr
    password : str


class UserResponse(BaseModel):
    id: int
    name: str
    email: EmailStr
    phone_number: Optional[str] = None
    role: Role
    profile_photo_url: Optional[str] = None
    account_status: AccountStatus
    main_location: Optional[str] = None
    created_at: datetime
    updated_at: datetime