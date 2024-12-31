from pydantic import BaseModel
from typing import Optional
from app.schemas.profiles.user import UserInfo, speciality

class AcademyInfo(UserInfo):
    specialty: speciality  
    coach_count: int
    business_license_url: Optional[str] = None
    tax_number: Optional[str] = None
    contact_email: Optional[str] = None
    website_url: Optional[str] = None
    contact_phone_number: Optional[str] = None
