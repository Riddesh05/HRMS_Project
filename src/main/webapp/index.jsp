
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>HRMS | Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
      rel="stylesheet">

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    min-height:100vh;
    background:linear-gradient(135deg,#eeeaff,#eef6ff);
    font-family:"Segoe UI",sans-serif;
    display:flex;
    align-items:center;
    justify-content:center;
}

/* MAIN BOX */

.login-wrapper{
    width:900px;
    height:520px;
    display:flex;
    border-radius:25px;
    overflow:hidden;
    background:white;
    box-shadow:0 20px 50px rgba(60,70,150,.18);
    animation:show .7s ease;
}

/* LEFT */

.left-panel{
    width:50%;
    padding:55px 55px;
    color:white;
    background:linear-gradient(135deg,#5145d9,#2869e8);
    position:relative;
    overflow:hidden;
}

.left-panel:before,
.left-panel:after{
    content:"";
    position:absolute;
    border:1px solid rgba(255,255,255,.15);
    border-radius:50%;
    animation:circleMove 6s ease-in-out infinite;
}

.left-panel:before{
    width:300px;
    height:300px;
    top:-150px;
    right:-120px;
}

.left-panel:after{
    width:280px;
    height:280px;
    bottom:-170px;
    right:-80px;
    animation-delay:1.5s;
}

/* ICON */

.logo-icon{
    width:65px;
    height:65px;
    border-radius:18px;
    background:rgba(255,255,255,.18);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin-bottom:35px;
    animation:float 3s ease-in-out infinite;
}

/* TEXT */

.left-panel h1{
    font-size:50px;
    font-weight:800;
    margin-bottom:20px;
    animation:slideRight .7s ease .15s both;
}

.left-panel p{
    font-size:16px;
    line-height:1.8;
    opacity:.9;
    margin-bottom:25px;
    animation:slideRight .7s ease .25s both;
}

/* FEATURES */

.feature{
    display:flex;
    align-items:center;
    gap:15px;
    margin:18px 0;
    font-size:15px;
    animation:slideRight .6s ease both;
}

.feature:nth-child(3){
    animation-delay:.35s;
}

.feature:nth-child(4){
    animation-delay:.45s;
}

.feature:nth-child(5){
    animation-delay:.55s;
}

.feature i{
    width:38px;
    height:38px;
    border-radius:50%;
    background:rgba(255,255,255,.16);
    display:flex;
    align-items:center;
    justify-content:center;
    transition:.3s;
}

.feature:hover i{
    transform:scale(1.15) rotate(8deg);
    background:rgba(255,255,255,.25);
}

/* RIGHT */

.right-panel{
    width:50%;
    padding:55px 60px;
    background:#fff;
    animation:slideLeft .7s ease .2s both;
}

.right-panel h2{
    font-size:34px;
    font-weight:800;
    color:#18233d;
    margin-bottom:5px;
}

.subtitle{
    color:#7b849b;
    font-size:14px;
    margin-bottom:35px;
}

/* INPUT */

.input-box{
    position:relative;
    margin-bottom:18px;
    animation:slideUp .6s ease .4s both;
}

.input-box:nth-of-type(2){
    animation-delay:.5s;
}

.input-box i{
    position:absolute;
    left:18px;
    top:50%;
    transform:translateY(-50%);
    color:#8791a8;
    transition:.3s;
}

.input-box input{
    width:100%;
    height:52px;
    padding:0 18px 0 48px;
    border:1px solid #dce1ed;
    border-radius:12px;
    outline:none;
    font-size:14px;
    transition:.3s;
}

.input-box input:focus{
    border-color:#4d60e8;
    box-shadow:0 0 0 4px rgba(77,96,232,.10);
    transform:translateY(-1px);
}

.input-box:focus-within i{
    color:#4d60e8;
    transform:translateY(-50%) scale(1.1);
}

/* BUTTON */

.login-btn{
    width:100%;
    height:52px;
    border:0;
    border-radius:12px;
    color:white;
    font-weight:600;
    font-size:15px;
    background:linear-gradient(90deg,#5145e5,#2869e8);
    transition:.3s;
    position:relative;
    overflow:hidden;
    animation:slideUp .6s ease .6s both;
}

.login-btn:before{
    content:"";
    position:absolute;
    top:0;
    left:-100%;
    width:60%;
    height:100%;
    background:linear-gradient(
        90deg,
        transparent,
        rgba(255,255,255,.25),
        transparent
    );
    transition:.5s;
}

.login-btn:hover:before{
    left:120%;
}

.login-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 22px rgba(55,80,220,.25);
}

/* ERROR */

.alert{
    font-size:13px;
    border-radius:10px;
    animation:shake .4s ease;
}

/* FOOTER */

.footer{
    text-align:center;
    color:#9aa3b5;
    font-size:12px;
    margin-top:28px;
}

/* ANIMATIONS */

@keyframes show{
    from{
        opacity:0;
        transform:translateY(25px) scale(.96);
    }
    to{
        opacity:1;
        transform:translateY(0) scale(1);
    }
}

@keyframes slideRight{
    from{
        opacity:0;
        transform:translateX(-25px);
    }
    to{
        opacity:1;
        transform:translateX(0);
    }
}

@keyframes slideLeft{
    from{
        opacity:0;
        transform:translateX(25px);
    }
    to{
        opacity:1;
        transform:translateX(0);
    }
}

@keyframes slideUp{
    from{
        opacity:0;
        transform:translateY(15px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

@keyframes float{
    0%,100%{
        transform:translateY(0);
    }
    50%{
        transform:translateY(-7px);
    }
}

@keyframes circleMove{
    0%,100%{
        transform:translate(0,0) scale(1);
    }
    50%{
        transform:translate(-15px,15px) scale(1.05);
    }
}

@keyframes shake{
    0%,100%{
        transform:translateX(0);
    }
    25%{
        transform:translateX(-5px);
    }
    75%{
        transform:translateX(5px);
    }
}

/* MOBILE */

@media(max-width:768px){

    .login-wrapper{
        width:92%;
        height:auto;
        flex-direction:column;
    }

    .left-panel,
    .right-panel{
        width:100%;
    }

    .left-panel{
        padding:35px;
    }

    .left-panel h1{
        font-size:38px;
    }

    .right-panel{
        padding:35px;
    }

}

</style>

</head>

<body>

<div class="login-wrapper">

    <!-- LEFT PANEL -->

    <div class="left-panel">

        <div class="logo-icon">
            <i class="bi bi-people-fill"></i>
        </div>

        <h1>HRMS</h1>

        <p>
            A smarter way to manage your workplace,
            employees and daily HR operations from
            one centralized platform.
        </p>

        <div class="feature">
            <i class="bi bi-shield-check"></i>
            <span>Secure Employee Management</span>
        </div>

        <div class="feature">
            <i class="bi bi-calendar-check"></i>
            <span>Simplified Leave</span>
        </div>

        <div class="feature">
            <i class="bi bi-bar-chart-line"></i>
            <span>Powerful HR Analytics</span>
        </div>

    </div>


    <!-- RIGHT PANEL -->

    <div class="right-panel">

        <h2>
            Welcome Back 👋
        </h2>

        <div class="subtitle">
            Sign in to continue to your employee account.
        </div>


        <form action="login" method="post">

            <div class="input-box">

                <i class="bi bi-envelope"></i>

                <input type="email"
                       name="email"
                       placeholder="Email address"
                       required>

            </div>


            <div class="input-box">

                <i class="bi bi-lock"></i>

                <input type="password"
                       name="password"
                       placeholder="Password"
                       required>

            </div>


            <c:if test="${not empty error}">

                <div class="alert alert-danger">
                    ${error}
                </div>

            </c:if>


            <button type="submit" class="login-btn">

                <i class="bi bi-box-arrow-in-right me-2"></i>
                Sign In

            </button>

        </form>


        <div class="footer">
            © 2026 HRMS • Employee Management System
        </div>

    </div>

</div>

</body>
</html>
