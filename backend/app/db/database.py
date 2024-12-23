from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Database URL
SQLALCHEMY_DATABASE_URL = "mysql+pymysql://root:MmmM12345!@127.0.0.1/coachingapp"

# Create engine
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Create SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create Base class
Base = declarative_base()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# At the end of your database.py file, add:
if __name__ == "__main__":
    try:
        # Test the connection
        engine.connect()
        print("Successfully connected to the database!")
    except Exception as e:
        print(f"An error occurred: {e}")