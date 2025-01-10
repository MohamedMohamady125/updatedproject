from pydantic import BaseModel, Field
from enum import Enum
from datetime import datetime, date
from typing import Optional
from decimal import Decimal

class RefundTypes(str, Enum):
    BOOKING_CANCELLATION = "booking cancellation"  # Refund due to booking being canceled
    VENDOR_PRODUCT_RETURN = "vendor product return"  # Refund due to returning a product to a vendor
    SERVICE_ISSUE = "service issue"  # Refund due to dissatisfaction with service quality
    SYSTEM_ERROR = "system error"  # Refund due to technical or payment system issues


class RefundInfo(BaseModel):
    refund_id: int  # Unique identifier for the refund
    transaction_id: int  # Links to the transaction being refunded
    refund_type: RefundTypes  # Type of refund
    refund_amount: Decimal  # Amount to be refunded
    reason: Optional[str] = None  # Optional explanation for the refund
    created_at: datetime = datetime.now()  # Timestamp when the refund was created
    status: str = "pending"  # Refund status: 'pending', 'completed', or 'failed'


class RefundStatus(str, Enum):
    PENDING = "pending"
    COMPLETED = "completed"
    FAILED = "failed"
