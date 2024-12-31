from app.schemas.profiles.user import UserInfo
from datetime import datetime

class agentInfo(UserInfo):
    department : str
    created_at: datetime
    updated_at: datetime

