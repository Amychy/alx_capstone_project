// Declare data in a broader scope
let data;

// Get references to HTML elements
const hintButton = document.getElementById('hint-button');
const hintDiv = document.getElementById('hint');

// Function to toggle hint visibility
function toggleHintVisibility() {
    if (hintDiv.style.display === 'none') {
        hintDiv.style.display = 'block';
        hintButton.textContent = 'Hide Hint'; // Change button text to "Hide Hint"
    } else {
        hintDiv.style display = 'none';
        hintButton.textContent = 'Hint'; // Change button text back to "Show Hint"
    }
}

// Add event listener to the hint button
hintButton.addEventListener('click', toggleHintVisibility);

// Variables for the quiz
let timer;
let timeLeft = 50; // Set the timer duration to 50 seconds
let currentScore = 0;
let totalScore = 0;
let currentQuestionIndex = 0;
let numberOfQuestions; // Store the total number of questions
let scores = []; // Store individual scores
let quizRunning = true; // Flag to track whether the quiz is running or not

// Function to restart the quiz
function restartQuiz() {
    // Reload the page to reset everything
    location.reload();
}

// Function to open a modal
function openModal(header, message, score, isSuccess, isTimeout) {
    const modal = document.getElementById('modal');
    modal.style.display = 'block';
    document.getElementById('modal-header').textContent = header;

    const nextButton = document.querySelector('#modal button');
    if (isTimeout) {
        // If it's a timeout, end the quiz
        nextButton.addEventListener('click', function () {
            clearInterval(timer);
            closeModal();
            displayQuizCompletion();
        });
    } else {
        nextButton.addEventListener('click', closeModal);
    }

    const modalMessage = document.getElementById('modal-message');
    modalMessage.textContent = message;

    if (isSuccess) {
        modalMessage.style.color = '#069414';
        modalMessage.style.fontSize = '24px';
        modalMessage.innerHTML += '<img src="../static/images/success.png" alt="Success">';
    } else {
        modalMessage.style.color = '#B90F05';
        modalMessage.style.fontSize = '20px';
        modalMessage.innerHTML += '<img class="w-20" src="../static/images/error.png" alt="Error">';
    }

    document.getElementById('modal-score').textContent = `Your score: ${score}`;
}

// Function to close the modal
function closeModal() {
    const modal = document.getElementById('modal');
    modal.style.display = 'none';
}

// Function to display quiz completion
function displayQuizCompletion() {
    const quizContainer = document.getElementById('quiz-container');
    quizContainer.innerHTML = '';

    const completionMessage = document.createElement('div');
    completionMessage.innerHTML = `
        <h1>Quiz Completed</h1>
        <p>Total Score = ${currentScore}</p>
        <div class="flex justify-between items-center gap-5">
            <button class="hint-btn md:py-3 py-2 px-2 md:px-5 rounded-xl text-sm md:text-base mt-4" onclick="restartQuiz()">Restart Quiz</button>
            <button class="header-btn-bg text-white md:py-3 py-2 px-2 md:px-5 rounded-xl text-sm md:text-base font-medium mt-4" onclick="location.href='/';">Retake Quiz</button>
        </div>
    `;

    quizContainer.appendChild(completionMessage);
    // Reset hint and button visibility
    hintDiv.style.display = 'none';
    hintButton.style.display = 'none';
}

// Function to record the score
function recordScore(score, category) {
    fetch('/submit_score', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ score: score, category: category }),
    })
        .then(response => response.json())
        .then(data => {
            console.log('Score recorded:', data);
        })
        .catch(error => {
            console.error('Error recording score:', error);
        });
}

// Function to fetch quiz questions
function fetchQuestions(selectedCategory) {
    console.log(`Fetching questions for category: ${selectedCategory}`);
    fetch(`/api/questions?category=${selectedCategory}`)
        .then(response => response.json())
        .then(data => {
            numberOfQuestions = data.questions.length; // Store the total number of questions
            console.log('Data received:', data);

            const questionElement = document.getElementById('question-placeholder');
            const optionsContainer = document.getElementById('options-container');
            const nextButton = document.getElementById('next-button');
            let currentQuestionIndex = 0;
            const totalQuestions = data.questions.length;
            const correctAnswers = data.questions.map(question => question.correct_option);

            function displayQuestion(questionIndex) {
                if (!quizRunning) {
                    return; // Don't proceed if the quiz is not running
                }

                // Reset the hint button text to "Show Hint" for each new question
                hintButton.textContent = 'Hint';

                const currentQuestion = data.questions[questionIndex];
                console.log(`Displaying question ${questionIndex + 1} of ${totalQuestions}`);
                questionElement.textContent = currentQuestion.question;

                if (currentQuestion.hint !== null) {
                    hintDiv.textContent = currentQuestion.hint;
                } else {
                    hintDiv.textContent = 'No hint available for this question.';
                }

                optionsContainer.innerHTML = '';
                const options = [
                    currentQuestion.option_a,
                    currentQuestion.option_b,
                    currentQuestion.option_c,
                    currentQuestion.option_d
                ];

                options.forEach((option, index) => {
                    const optionLabel = document.createElement('label');
                    optionLabel.classList.add('flex', 'flex-row', 'gap-6', 'font-medium', 'option-label');
                    optionLabel.innerHTML = `
                        <input type="radio" value="${String.fromCharCode(65 + index)}" name="answer" class="mt-1"> ${String.fromCharCode(65 + index)}. ${option}
                    `;
                    optionsContainer.appendChild(optionLabel);
                });

                nextButton.addEventListener('click', () => {
                    if (!quizRunning) {
                        return; // Don't proceed if the quiz is not running
                    }
                    const selectedAnswer = document.querySelector('input[name="answer"]:checked');
                    if (selectedAnswer) {
                        const answerValue = selectedAnswer.value;
                        if (answerValue === correctAnswers[questionIndex]) {
                            currentScore++;
                            openModal('Success!', 'You answered the question correctly!', currentScore, true, false);
                        } else {
                            openModal('Incorrect', 'Your answer is incorrect.', currentScore, false, false);
                        }
                        selectedAnswer.checked = false;

                        // Add this line to reset the hint visibility
                        hintShown = false;
                        hintDiv.style.display = 'none';

                        if (questionIndex < totalQuestions - 1) {
                            questionIndex++;
                            displayQuestion(questionIndex);
                        } else {
                            quizRunning = false; // Mark the quiz as completed
                            displayQuizCompletion();
                            clearInterval(timer);

                            // Store the current score in the array of scores
                            scores.push(currentScore);

                            if (scores.length === numberOfQuestions) {
                                // Calculate the total score
                                totalScore = scores.reduce((acc, cur) => acc + cur, 0);

                                // Send the total score to the server
                                recordScore(totalScore, selectedCategory);
                            } else {
                                // If all questions have been answered, but scores are not yet sent (e.g., if the quiz is aborted)
                                // Send the current score
                                recordScore(currentScore, selectedCategory);
                            }
                        }
                    }
                });

                // Start the timer for each question
                startTimer(selectedCategory);
            }

            displayQuestion(currentQuestionIndex);
        })
        .catch(error => {
            console.error('Error fetching questions:', error);
        });
}

// Function to start the timer
function startTimer(selectedCategory) {
    if (!quizRunning) {
        return; // Don't proceed if the quiz is not running
    }
    console.log('Start timer');
    updateTimerDisplay();

    clearInterval(timer);
    timer = setInterval(function () {
        if (timeLeft > 0) {
            timeLeft--;
            updateTimerDisplay();
        } else {
            quizRunning = false; // Mark the quiz as completed
            clearInterval(timer);
            openModal("Time's Up!", "You ran out of time.", currentScore, false, true);

            // Store the current score in the array of scores
            scores.push(currentScore);

            if (scores.length === numberOfQuestions) {
                // Calculate the total score
                totalScore = scores.reduce((acc, cur) => acc + cur, 0);

                // Send the total score to the server
                recordScore(totalScore, selectedCategory);
            } else {
                // If all questions have been answered, but scores are not yet sent (e.g., if the quiz is aborted)
                // Send the current score
                recordScore(currentScore, selectedCategory);
            }
        }
    }, 1000);
}

// Function to update the timer display
function updateTimerDisplay() {
    const timerElement = document.getElementById('timer');
    timerElement.textContent = `Time Left: ${timeLeft} seconds`;
}

// Execute the code when the DOM is loaded
document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const selectedCategory = urlParams.get('category');

    console.log(`Selected category from URL: ${selectedCategory}`);

    if (selectedCategory) {
        fetchQuestions(selectedCategory);
    } else {
        console.error('No category selected.');
    }
});
