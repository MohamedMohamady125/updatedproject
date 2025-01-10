from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from datetime import timedelta
from typing import Annotated
from app.models import models  # Assuming you have a User model
from app.schemas.profiles.user import UserResponse  # Assuming you have a UserResponse schema
from app.db.database import get_db  # Database session dependency
from app.core.security import create_access_token  # Utility function to create access tokens
from app.api.v1.endpoints.users.user import verify_password

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login", response_model=UserResponse)
async def login(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    db: Session = Depends(get_db)
):
    """
    Authenticate a user and return an access token.

    - **username**: The user's email.
    - **password**: The user's password.
    """
    # Fetch the user from the database
    user = db.query(models.User).filter(models.User.email == form_data.username).first()
    
    # Check if the user exists and the password is correct
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    # Create an access token for the user
    access_token_expires = timedelta(minutes=30)  # Token expiration time
    access_token = create_access_token(
        data={"sub": user.email},
        expires_delta=access_token_expires
    )
    
    # Return the user's data along with the access token
    return {
        "email": user.email,
        "full_name": user.full_name,
        "access_token": access_token,
        "token_type": "bearer"
    }