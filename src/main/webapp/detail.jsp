<%
    String requestId = request.getParameter("id"); //Recupera valor enviado desde hipervinculo de home.jsp (href)
%>

<html>
<head>
    <script>
        async function init(event) {
            event.preventDefault(); // Evita que el formulario recargue la página
            const val = document.getElementById("boton").value;
            alert (val);
        }

    </script>
</head>
<body>
    <center>
        <form name="Detail" onsubmit="init(event)">
            <button type="submit" value="<%=requestId%>" id="boton">Click</button>
        </form>
    </center>
</body>
</html>
