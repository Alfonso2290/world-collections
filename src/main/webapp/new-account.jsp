
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Created Account</title>
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
            font-family: Arial, sans-serif;
        }

        .account-form {
            width: 380px;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        }

        .account-form td {
            padding: 15px 20px;
            border: none;
        }

        .account-form tr:first-child td {
            padding: 25px 20px;
            background-color: #4f46e5;
            color: white;
            font-size: 22px;
            font-weight: bold;
        }

        .account-form tr:not(:first-child) td:first-child {
            width: 110px;
            font-weight: bold;
            color: #374151;
        }

        .account-form input {
            width: 100%;
            box-sizing: border-box;
            padding: 11px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: 0.2s;
        }

        .account-form input:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .account-form button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #4f46e5;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .account-form button:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        .account-form button:active {
            transform: translateY(0);
        }
    </style>

    <script>
        async function createAccount(event){
            event.preventDefault();
            const user = document.getElementById("txtUser").value;
            const password = document.getElementById("txtPassword").value;

            if(user.length===0){
                alert("Usted debe ingresar User Name");
                return;
            }

            if(password.length===0){
                alert("Usted debe ingresar Password");
                return;
            }

            const response = await fetch(`http://localhost:8081/user/save?user=${encodeURIComponent(user)}&password=${encodeURIComponent(password)}`, {
                method: "POST"
            });

            const result = await response.json();


            if (result === true) {
                alert("Creación de cuenta exitosa");
                window.location.href = "index.jsp";
            } else{
                alert("El usuario ya existe");
            }

        }
    </script>
</head>
<body>
    <table class="account-form">
        <tr>
            <td align="center" colspan="2">Formulario de Usuario</td>
        </tr>
        <tr>
            <td>User Name:</td>
            <td><input type="text" id="txtUser"/> </td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type="password" id="txtPassword"/> </td>
        </tr>
        <tr>
            <td align="center" colspan="2"><button type="submit" onclick="createAccount(event)">Create Account</button> </td>
        </tr>
    </table>
</body>
</html>
