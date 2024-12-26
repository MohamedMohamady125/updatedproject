from enum import Enum

class Purpose(str, Enum):
    INFORMATIONAL = "informational"
    PROMOTIONAL = "promotional"
    REMINDER = "reminder"

class DeliveryStatus(str, Enum):
    DELIVERED = "delivered"
    PENDING = "pending"
    FAILED = "failed"
    SENT = "sent"

class Priority(str, Enum):
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"


class NotificationPlatforms(str, Enum):
    IN_APP = "in_app"
    PUSH = "push"
    EMAIL = "email"
    SMS = "sms"

