<html>
<head>
    <script>
        async function login(event) {
            event.preventDefault(); // Evita que el formulario recargue la página

            const user = document.getElementById("user").value;
            const password = document.getElementById("password").value;

            const response = await fetch(`http://localhost:8082/user/validate/user?user=${encodeURIComponent(user)}&password=${encodeURIComponent(password)}`, {
                method: "GET"
            });

            const result = await response.json();


            if (result.status === '200') {
                alert("Login exitoso: " + JSON.stringify(result));
                window.location.href = "home.js";
            } else {
                alert("Error: " + JSON.stringify(result));
            }
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
