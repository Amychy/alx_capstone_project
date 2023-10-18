from flask_sqlalchemy import SQLAlchemy
from models import UserOverallScores

db = SQLAlchemy()

# Function to update user's overall scores
def update_user_scores(user_id, quiz_category, quiz_score):
    existing_record = UserOverallScores.query.filter_by(user_id=user_id).first()

    if existing_record:
        # User record exists, update the fields
        total_score = existing_record.total_score + quiz_score  # Add the new quiz score to the existing total score
        number_of_plays = existing_record.number_of_plays + 1  # Increment the number of plays

        # Check if the new score affects the "category_with_highest_score" field
        if quiz_score > existing_record.total_score:
            category_with_highest_score = quiz_category
        else:
            category_with_highest_score = existing_record.category_with_highest_score

        # Update the record in the table
        existing_record.total_score = total_score
        existing_record.number_of_plays = number_of_plays
        existing_record.category_with_highest_score = category_with_highest_score
    else:
        # User record doesn't exist, create a new record
        new_record = UserOverallScores(user_id=user_id, total_score=quiz_score, number_of_plays=1, category_with_highest_score=quiz_category)
        db.session.add(new_record)

    db.session.commit()
