# app/api/v1/endpoints/auth/pass.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import Annotated

# Import your database models, schemas, and utilities
from app.models import models  # Assuming you have a User model
from app.schemas.profiles.user import PasswordChange  # Schema for password change
from app.db.database import get_db  # Database session dependency
from app.core.security import get_current_user  # Import the get_current_user function
from app.api.v1.endpoints.users.user import verify_password, get_password_hash  # Reuse password functions

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/password-change")
async def password_change(
    request: PasswordChange,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)  # Use the get_current_user dependency
):
    """
    Change the password for an authenticated user.

    - **current_password**: The user's current password.
    - **new_password**: The new password.
    """
    # Verify the current password
    if not verify_password(request.current_password, current_user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect current password."
        )
    
    # Hash the new password
    hashed_password = get_password_hash(request.new_password)
    
    # Update the user's password
    current_user.hashed_password = hashed_password
    db.commit()
    
    return {"message": "Password has been changed successfully."}