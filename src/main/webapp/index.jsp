<html>
<head>
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
            const response = await fetch(`http://localhost:30080/user/validate/user?user=${encodeURIComponent(user)}&password=${encodeURIComponent(password)}`, {
                method: "GET"
            });

            const result = await response.json();


            if (result.status === '200') {
                alert("Login exitoso: " + JSON.stringify(result));
                window.location.href = "home.jsp";
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
