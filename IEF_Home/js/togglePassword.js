function showPassword(isShow) {
    document.getElementById("ContentPlaceHolderMain_txtPassword").setAttribute("type", isShow ? "text" : "password");
    document.getElementById("eyePassword").classList.toggle("fa-eye-slash");
}

function showRegister(showRegister) {
    document.getElementById("login-content").style.display = showRegister ? "none" : "block";
    document.getElementById("register-content").style.display = showRegister ? "block" : "none";
}