from flask import Flask, flash, render_template, request, jsonify, redirect, url_for, session
from database import db
from models import Category, QuizQuestion, User, UserScore
from sqlalchemy.exc import IntegrityError
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload
import bcrypt
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from collections import Counter
from flask_mail import Mail, Message
import secrets  # For generating secure tokens

# Initialize the Flask application
app = Flask(__name__, static_url_path='/static')
mail = Mail(app)

# Configuration settings
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/quizwiz'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = '29b37a2a3cce39d4a2ee6a1ef19c91a5'

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'bizzcozy@gmail.com'
app.config['MAIL_PASSWORD'] = 'kznsqxtvpchqqrjm'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
app.config['MAIL_DEFAULT_SENDER'] = ('Quizwiz', 'bizzcozy@gmail.com')
app.config['MAIL_DEBUG'] = True

# Initialize the SQLAlchemy and Mail instances with the Flask app
db.init_app(app)
mail.init_app(app)

# Initialize the LoginManager
login_manager = LoginManager(app)
login_manager.login_view = "login"  # The view name for your login page

# Function to load a user for the LoginManager
@login_manager.user_loader
def load_user(user_id):
    """
    Function to load a user for the LoginManager.
    
    Args:
        user_id: The ID of the user to be loaded.
    
    Returns:
        User object if found, None otherwise.
    """
    user = User.query.get(int(user_id))
    return user

# Root route
@app.route('/')
def index():
    """
    Route to render the index page.

    Returns:
        Rendered HTML template.
    """
    username = current_user.username if current_user.is_authenticated else None
    categories = Category.query.all()
    print(categories)  # Print the retrieved data
    return render_template("index.html", categories=categories, username=username)

# Quiz Route
@app.route('/quiz')
def quiz():
    """
    Route to render the quiz page.

    Returns:
        Rendered HTML template for selected category.
    """
    selected_category = request.args.get('category')
    print(f"Selected Category: {selected_category}")

    questions = QuizQuestion.query.filter_by(category=selected_category).all()
    print(f"Questions: {questions}")  # Debugging statement
    return render_template("quiz.html", questions=questions)

# Fetch quiz AP1 route
@app.route('/api/questions', methods=['GET'])
def get_quiz_questions():
    """
    Route to fetch quiz questions, options and hint.

    Returns:
        Rendered quiz questions, options and hints.
    """
    selected_category = request.args.get('category')
    questions = QuizQuestion.query.filter_by(category=selected_category).all()
    
    question_list = [
        {
            'id': question.id,
            'category': question.category,
            'question': question.question,
            'option_a': question.option_a,
            'option_b': question.option_b,
            'option_c': question.option_c,
            'option_d': question.option_d,
            'correct_option': question.correct_option,
            'hint': question.hint 
        }
        for question in questions
    ]
    return jsonify({'questions': question_list})

@app.route('/submit_score', methods=['POST'])
def submit_score():
    if request.method == 'POST':
        data = request.get_json()
        user_id = data.get('user_id')
        score = data.get('score')
        category = data.get('category')  # Add this line to get the category

        # Check if the user is logged in
        if current_user.is_authenticated:
            user_id = current_user.id  # Use the user ID of the logged-in user

        # Save the score to the database
        user_score = UserScore(user_id=user_id, score=score, category=category)
        db.session.add(user_score)
        db.session.commit()

        return jsonify({'message': 'Score saved successfully'})

    return jsonify({'message': 'Invalid request'})


@app.route('/faq')
def faq_page():
    return render_template('faq.html')

@app.route('/get_user_info/<int:user_id>', methods=['GET'])
def get_user_info(user_id):
    # Query the database to get the scores of the user
    user_scores = UserScore.query.filter_by(user_id=user_id).all()

    # Calculate the total score
    total_score = sum(score.score for score in user_scores)

    # Calculate the most frequently played category
    category_counts = Counter(score.category for score in user_scores)
    most_played_category = category_counts.most_common(1)[0][0]

    # Calculate the number of times the user ID occurs in the UserScore table
    user_score_count = len(user_scores)

    return jsonify({
        'total_score': total_score,
        'most_played_category': most_played_category,
        'user_score_count': user_score_count
    })

def get_leaderboard_data():
    leaderboard_data = []

    # Query the database to get the leaderboard data
    user_scores = (
        UserScore.query
        .join(User)  # Join the UserScore and User tables
        .options(joinedload(UserScore.user))  # Eager loading of the user relationship
        .with_entities(
            User.username,
            func.sum(UserScore.score).label('total_score'),
            func.count(UserScore.id).label('user_score_count'),
            func.max(UserScore.category).label('most_played_category')
        )
        .group_by(User.username)  # Group by username
        .order_by(func.sum(UserScore.score).desc())  # Order by total score in descending order
        .limit(10)  # Limit to the top 10 results
        .all()
    )

    for user_score in user_scores:
        leaderboard_data.append({
            'username': user_score.username,
            'total_score': user_score.total_score,
            'user_score_count': user_score.user_score_count,
            'most_played_category': user_score.most_played_category
        })

    return leaderboard_data


@app.route('/leaderboard')
def leaderboard():
    # Fetch leaderboard data from your database
    leaderboard_data = get_leaderboard_data()  # You'll need to implement this function

    # Enumerate the data, starting at 1
    enumerated_leaderboard = list(enumerate(leaderboard_data, start=1))

    return render_template('leaderboard.html', enumerated_leaderboard=enumerated_leaderboard)


@app.route('/policy')
def policy_page():
    return render_template('policy.html')

@app.route('/about')
def about_page():
    return render_template('about.html')


def send_email_notification(name, email, subject, message):
    try:
        msg = Message('Contact Us Form Submission', sender=email, recipients=['bizzcozy@gmail.com'])
        msg.body = f'Name: {name}\nEmail: {email}\nSubject: {subject}\nMessage: {message}'
        mail.send(msg)
    except Exception as e:
        print(f'Email sending error: {str(e)}')

@app.route('/contact')
def contact_page():
    return render_template('contact.html')

@app.route('/contact', methods=['POST'])
def contact_us():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        subject = request.form.get('subject')
        message = request.form.get('message')
        
        # Send an email notification with the form data
        send_email_notification(name, email, subject, message)
        
        # Optionally, you can redirect to a thank you page
        return redirect(url_for('thank_you'))
    
@app.route('/thank_you')
def thank_you():
    return render_template('thank_you.html')



@app.route('/terms')
def terms_page():
    return render_template('terms.html')

@app.route('/dashboard')
@login_required
def dashboard():
    if current_user.is_authenticated:
        username = current_user.username

        # Query the UserScore table to get the scores of the logged-in user
        user_scores = UserScore.query.filter_by(user_id=current_user.id).all()

        return render_template('dashboard/dashboard.html', username=username, user_scores=user_scores)
    else:
        return redirect(url_for('login'))

@app.route('/profile')
@login_required
def profile():
    if current_user.is_authenticated:
            username = current_user.username

            return render_template('dashboard/profile.html', username=username)
    else:
        return redirect(url_for('login'))

@app.route('/update_profile', methods=['POST'])
@login_required
def update_profile():
    if request.method == 'POST':
        new_full_name = request.form.get('full_name')
        new_password = request.form.get('new_password')

        # Update the user's full name
        current_user.full_name = new_full_name

        # If a new password is provided, update the user's password
        if new_password:
            hashed_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt())
            current_user.password = hashed_password

        db.session.commit()

        flash('Profile updated successfully', 'success')
        return redirect(url_for('profile'))

    return redirect(url_for('profile'))  # Handle invalid requests


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        full_name = request.form['full_name']
        email = request.form['email']
        password = request.form['password']

        # Check if the username or email already exists
        existing_user = User.query.filter(
            or_(User.username == username, User.email == email)
        ).first()
        
        if existing_user:
            flash('Username or email is already in use.', 'error')
            return render_template('register.html')  # Render the registration form again

        # Hash the password securely
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        # Create a new user and add it to the database
        new_user = User(username=username, full_name=full_name, email=email, password=hashed_password)
        db.session.add(new_user)
        db.session.commit()

        # Log in the user immediately after registration
        login_user(new_user)

        flash('Registration successful', 'success')  # Add a success message

        return redirect(url_for('dashboard'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        user = User.query.filter_by(username=username).first()

        if user and bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
            # Successful login
            login_user(user)
            flash('Login successful', 'success')

            return redirect(url_for('dashboard'))
        else:
            # Failed login
            flash('Invalid username or password', 'error')

    return render_template('login.html')

@app.route('/forgot_password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'POST':
        email = request.form.get('email')
        user = User.query.filter_by(email=email).first()

        if user:
            # Generate a unique token for password reset
            reset_token = secrets.token_urlsafe(16)

            # Save the token to the user's record in the database
            user.reset_password_token = reset_token
            db.session.commit()

            # Send a password reset email
            send_password_reset_email(user, reset_token)

            flash('An email with instructions for password reset has been sent to your email address.', 'success')
            return redirect(url_for('login'))

        flash('Invalid email address. Please check your email or sign up for a new account.', 'error')

    return render_template('forgot_password.html')


def send_password_reset_email(user, reset_token):
    # Create the password reset link with the token
    reset_link = url_for('reset_password', token=reset_token, _external=True)

    # Create and send the email
    subject = "Password Reset Request"
    recipients = [user.email]
    html_body = render_template("password_reset_email.html", reset_link=reset_link)

    msg = Message(subject=subject, recipients=recipients, html=html_body)

    # Send the email
    mail.send(msg)

@app.route('/reset_password/<token>', methods=['GET', 'POST'])
def reset_password(token):
    # Check if the token is valid
    user = User.query.filter_by(reset_password_token=token).first()
    
    if user:
        if request.method == 'POST':
            new_password = request.form.get('new_password')

            # Update the user's password
            hashed_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt())
            user.password = hashed_password
            user.reset_password_token = None  # Remove the token
            db.session.commit()

            flash('Your password has been reset. You can now log in with your new password.', 'success')
            return redirect(url_for('login'))
        
        return render_template('reset_password.html', token=token)

    flash('Invalid or expired token. Please request a new password reset link.', 'error')
    return redirect(url_for('login'))
    
@app.before_request
def load_user_if_logged_in():
    if 'logged_in' in session and session['logged_in']:
        user = User.query.get(session['user_id'])
        if user:
            login_user(user)


@app.route('/logout', methods=['POST'])
@login_required
def logout():
    logout_user()
    flash('You have been logged out', 'success')  # Provide a success message
    return redirect(url_for('login'))


if __name__ == "__main__":
    app.secret_key = '29b37a2a3cce39d4a2ee6a1ef19c91a5'
    app.run(debug=True)