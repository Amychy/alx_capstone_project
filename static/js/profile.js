function validateForm() {
    var full_name = document.getElementById("full_name").value;
    var new_password = document.getElementById("new_password").value;

    // Check Full Name format (first name and last name)
    var fullNamePattern = /^[\w\s]+ [\w\s]+$/;
    if (!full_name.match(fullNamePattern)) {
        alert("Full Name should contain both First Name and Last Name.");
        return false;
    }

    // If a new password is provided, check its format
    if (new_password && !isValidPassword(new_password)) {
        alert("Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
        return false;
    }

    return true;
}

function isValidPassword(password) {
    var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
    return password.match(passwordPattern);
}