from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import models
from app.schemas.profiles.user import userRegister, userLogin, UserResponse
from passlib.context import CryptContext
from datetime import datetime
from typing import Type


# this is for creating the password hashing
pwd_context: Type[CryptContext] = CryptContext(schemes=["bcrypt"], deprecated="auto")

router = APIRouter()

def verify_password(plain_password: str, hashed_password: str) -> bool:
    
    return pwd_context.verify(plain_password, hashed_password)   #this verifies that the password enter matches the one in the database


hashed_password = pwd_context.hash("password123")  # Hash the password during registration
print(hashed_password)  # Output: $2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW
