# Import necessary modules and classes
from database import db
from flask_login import UserMixin
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime

class Category(db.Model):
    """
    Database model for categories.

    Attributes:
        id (int): Primary key for the category.
        name (str): Name of the category.
        image_url (str): URL for the category's image.
    """
    __tablename__ = 'categories'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    image_url = db.Column(db.String(255), nullable=False)

    def __init__(self, name, image_url):
        """
        Initialize a Category object with a name and an image URL.

        Args:
            name (str): The name of the category.
            image_url (str): The URL of the category's image.
        """
        self.name = name
        self.image_url = image_url

class QuizQuestion(db.Model):
    """
    Database model for quiz questions.

    Attributes:
        id (int): Primary key for the question.
        category (str): The category to which the question belongs.
        question (str): The question text.
        option_a, option_b, option_c, option_d (str): Answer choices.
        correct_option (str): The correct answer choice ('A', 'B', 'C', or 'D').
        hint (str): Optional hint or explanation for the question.
    """
    __tablename__ = 'quiz_question'
    id = db.Column(db.Integer, primary_key=True)
    category = db.Column(db.String(50), nullable=False)
    question = db.Column(db.String(255), nullable=False)
    option_a = db.Column(db.String(100), nullable=False)
    option_b = db.Column(db.String(100), nullable=False)
    option_c = db.Column(db.String(100), nullable=False)
    option_d = db.Column(db.String(100), nullable=False)
    correct_option = db.Column(db.String(1), nullable=False)
    hint = db.Column(db.String(255))

class User(db.Model, UserMixin):
    """
    Database model for users.

    Attributes:
        id (int): Primary key for the user.
        username (str): Unique username for the user.
        full_name (str): Full name of the user.
        email (str): Unique email address for the user.
        password (str): Password hash for user authentication.
        reset_password_token (str): Token for password reset.
    """
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    full_name = db.Column(db.String(50))
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    reset_password_token = db.Column(db.String(100), unique=True)

class UserScore(db.Model):
    """
    Database model for user quiz scores.

    Attributes:
        id (int): Primary key for the score entry.
        user_id (int): Foreign key to associate with a user.
        score (int): User's quiz score.
        category (str): Category for which the score is recorded.
        timestamp (datetime): Timestamp of the score entry.
        user (User): Relationship to the User model for user score tracking.
    """
    __tablename__ = 'user_scores'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    score = db.Column(db.Integer, nullable=False)
    category = db.Column(db.String(255))
    timestamp = Column(DateTime, default=datetime.utcnow)

    user = db.relationship('User', primaryjoin=(user_id == User.id), backref='scores')