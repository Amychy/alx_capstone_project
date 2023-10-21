// Fetch the table and rows
const leaderboardTable = document.querySelector('.leaderboard-table');
const rows = leaderboardTable.querySelectorAll('tbody tr');

// Create data structures to store accumulated scores and count
const userScores = new Map();
const userCounts = new Map();
const mostFrequentCategories = new Map();

// Process each row
rows.forEach(row => {
    const username = row.cells[1].textContent; // Access username from the second cell

    const totalScore = parseInt(row.cells[2].textContent, 10);
    const count = parseInt(row.cells[3].textContent, 10);
    const category = row.cells[4].textContent;

    // Accumulate total scores
    userScores.set(username, (userScores.get(username) || 0) + totalScore);

    // Count the number of times the username appears
    userCounts.set(username, (userCounts.get(username) || 0) + count);

    // Determine the most frequent category
    if (!mostFrequentCategories.has(username)) {
        mostFrequentCategories.set(username, category);
    }
});

// Update the table content with the modified data
rows.forEach(row => {
    const username = row.cells[1].textContent;
    row.cells[2].textContent = userScores.get(username);
    row.cells[3].textContent = userCounts.get(username);
    row.cells[4].textContent = mostFrequentCategories.get(username);
});