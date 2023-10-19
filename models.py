from database import db  # Import the db instance from the database module
from flask_login import UserMixin  # Import UserMixin from flask_login
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime

class Category(db.Model):
    __tablename__ = 'categories'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    image_url = db.Column(db.String(255), nullable=False)

    def __init__(self, name, image_url):
        self.name = name
        self.image_url = image_url

class QuizQuestion(db.Model):
    __tablename__ = 'quiz_question'
    id = db.Column(db.Integer, primary_key=True)
    category = db.Column(db.String(50), nullable=False)
    question = db.Column(db.String(255), nullable=False)
    option_a = db.Column(db.String(100), nullable=False)
    option_b = db.Column(db.String(100), nullable=False)
    option_c = db.Column(db.String(100), nullable=False)
    option_d = db.Column(db.String(100), nullable=False)
    correct_option = db.Column(db.String(1), nullable=False)
    hint = db.Column(db.String(255))  # Field to store hints/explanations


class User(db.Model, UserMixin):
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)  # Unique constraint on username
    full_name = db.Column(db.String(50))
    email = db.Column(db.String(100), unique=True, nullable=False)  # Unique constraint on email
    password = db.Column(db.String(60), nullable=False)
    reset_password_token = db.Column(db.String(100), unique=True)

class UserScore(db.Model):
    __tablename__ = 'user_scores'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    score = db.Column(db.Integer, nullable=False)
    category = db.Column(db.String(255))  # Adjust the data type and length as needed
    timestamp = Column(DateTime, default=datetime.utcnow)

    user = db.relationship('User', primaryjoin=(user_id == User.id), backref='scores')

