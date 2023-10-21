function validateForm() {
    // Get form field values
    var username = document.getElementById("username").value;
    var full_name = document.getElementById("full_name").value;
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    
    // Simple checks for non-empty fields
    if (username.trim() === "" || email.trim() === "") {
        alert("Username and Email are required.");
        return false; // Prevent form submission
    }
    
    // Check Full Name format (first name and last name)
    var fullNamePattern = /^[\w\s]+ [\w\s]+$/;
    if (!full_name.match(fullNamePattern)) {
        alert("Full Name should contain both First Name and Last Name.");
        return false; // Prevent form submission
    }
    
    // Check email format
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (!email.match(emailPattern)) {
        alert("Invalid email format.");
        return false; // Prevent form submission
    }
    
    // Check password strength (at least 8 characters, containing letters and numbers)
    var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/;
    if (!password.match(passwordPattern)) {
        alert("Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
        return false; // Prevent form submission
    }
    
    return true; // Allow form submission if all checks pass
}