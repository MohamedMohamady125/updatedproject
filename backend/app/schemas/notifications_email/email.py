from pydantic import EmailStr, BaseModel, Field
from datetime import datetime, date
from typing import Optional, List
from app.schemas.notifications_email.enums import DeliveryStatus,Purpose

class EmailInfo(BaseModel):
    user_id : int
    email: EmailStr
    type: Purpose
    subject : str
    body : str
    attachments : Optional[List[str]] = None
    delivery_time : Optional[datetime] = None
    status: DeliveryStatus = DeliveryStatus.PENDING


class EmailResponse(BaseModel):
    message: str
    success: bool
    email_id: Optional[int] = None