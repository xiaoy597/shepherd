from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

engine = create_engine('mysql://spider:spider@localhost:3306/spiderdb')

Session = sessionmaker(bind=engine)

session = Session()
