<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        table {
            border-collapse: collapse;
            background-color: #ffffff;
            padding: 10px;
            border-radius: 8px;
        }

        td {
            padding: 8px;
        }

        input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 6px 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
        .custom-alert {
            position: fixed;
            top: 20px;
            right: 20px;
            min-width: 250px;
            padding: 12px 16px;
            border-radius: 6px;
            color: white;
            font-size: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            z-index: 9999;
            opacity: 0;
            transform: translateY(-20px);
            transition: all 0.3s ease;
        }

        .custom-alert.show {
            opacity: 1;
            transform: translateY(0);
        }

        .success {
            background-color: #28a745;
        }

        .error {
            background-color: #dc3545;
        }
    </style>
    <script>
        async function login(event) {
            event.preventDefault(); // Evita que el formulario recargue la página

            const user = document.getElementById("user").value;
            const password = document.getElementById("password").value;

            if(user.length===0) {
                alert("Ingrese username");
                return;
            }else if(password.length===0){
                alert("Ingrese password");
                return;
            }

            //Apunta al NodePort: 30080 (world-control-collection --> Service -> nodePort: 30080)
            // Ya no apunta a service NodePort, sino a service LoadBalancer el cual utiliza el puerto 8081
            const response = await fetch(`http://localhost:8081/user/validate/user?user=${encodeURIComponent(user)}&password=${encodeURIComponent(password)}`, {
                method: "GET"
            });

            const result = await response.json();


            if (result.status === '200') {
                showAlert("Login exitoso", "success");
                window.location.href = "home.jsp";
            } else {
                showAlert("Credenciales incorrectas", "error");
            }
        }

        /**Mejora estilo de mensaje de login exitoso o erroneo*/
        function showAlert(message, type) {
            const alertBox = document.createElement("div");
            alertBox.className = `custom-alert ${type}`;
            alertBox.innerText = message;

            document.body.appendChild(alertBox);

            setTimeout(() => {
                alertBox.classList.add("show");
            }, 10);

            setTimeout(() => {
                alertBox.classList.remove("show");
                setTimeout(() => alertBox.remove(), 300);
            }, 3000);
        }
    </script>
</head>
<body>
    <form onsubmit="login(event)">
        <table border="2" align="center">
            <tr align="center">
                <td colspan="2" height="30">Login</td>
            </tr>
            <tr>
                <td width="120" height="30">User:</td>
                <td width="150"><input type="text" id="user"/></td>
            </tr>
            <tr>
                <td height="30">Password:</td>
                <td><input type="password" id="password"/></td>
            </tr>
            <tr>
                <td colspan="2" height="30"><center><button type="submit">Login</button></center></td>
            </tr>
        </table>
    </form>
</body>
</html>
