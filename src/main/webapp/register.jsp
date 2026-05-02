<html>
<head>
    <title>Registo Coleccion</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        table {
            border-collapse: collapse;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
        }

        td {
            padding: 8px;
        }

        input, select {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
            transition: border 0.2s, box-shadow 0.2s;
        }

        input:focus, select:focus {
            border-color: #007bff;
            box-shadow: 0 0 4px rgba(0,123,255,0.4);
        }

        input[type="submit"] {
            width: auto;
            padding: 6px 16px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #1e7e34;
        }
    </style>
    <script>
        async function saveCollection(event){
            event.preventDefault(); // Evita que el formulario recargue la página

            const txtName = document.getElementById("txtName").value;
            const opType = document.getElementById("opType").value;
            const txtEditorial = document.getElementById("txtEditorial").value;
            const txtOrigin = document.getElementById("txtOrigin").value;
            const opStatus = document.getElementById("opStatus").value;
            const txtPriority = document.getElementById("txtPriority").value;
            const opDestiny = document.getElementById("opDestiny").value;
            const opForm = document.getElementById("opForm").value;
            const opBinder = document.getElementById("opBinder").value;

            validateForm(txtName,opType,txtEditorial,txtOrigin,opStatus,txtPriority,opDestiny,opForm,opBinder);
        }

        function validateForm(txtName,opType,txtEditorial,txtOrigin,opStatus,txtPriority,opDestiny,opForm,opBinder){
            if(txtName.length===0) alert("Introduce Nombre");
            else if(opType==="--Seleccionar--") alert("Introduce Tipo");
            else if(txtEditorial.length===0) alert("Introduce Editorial");
            else if(txtOrigin.length===0) alert("Introduce Origen");
            else if(opStatus==="--Seleccionar--") alert("Introduce Estado");
            else if(txtPriority.length===0) alert("Introduce Prioridad");
            else if(opDestiny==="--Seleccionar--") alert("Introduce Destino");
            else if(opForm==="--Seleccionar--") alert("Introduce Forma");
            else if(opBinder==="--Seleccionar--") alert("Introduce Binder");
            else {
                const data = {
                    name:txtName,
                    type:opType,
                    editorial:txtEditorial,
                    origin:txtOrigin,
                    status:opStatus,
                    priority:txtPriority,
                    destiny:opDestiny,
                    form:opForm,
                    binder:opBinder
                }

                callRegister(data);
            }
        }

        async function callRegister(data){
            const response = await fetch(`http://localhost:8081/control/save/collections`,{
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            if(response.ok){
                window.location.href = "home.jsp";
            }else{
                const text = await response.text(); // leer error del backend si existe
                alert("Error del servidor (status " + response.status + "): " + text);
            }
        }
    </script>
</head>
<body>
    <center>
        <form name="formRegister" onsubmit="saveCollection(event)">
            <table border="2">
                <tr>
                    <td colspan="2" align="center"><b>Registro de Coleccion</b></td>
                </tr>
                <tr>
                    <td>Nombre de Coleccion</td>
                    <td><input type="text" id="txtName"/></td>
                </tr>
                <tr>
                    <td>Tipo</td>
                    <td>
                        <select id="opType">
                            <option selected>--Seleccionar--</option>
                            <option>Album Lamina</option>
                            <option>Album Sticker</option>
                            <option>Card</option>
                            <option>Mixto</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Editorial</td>
                    <td><input type="text" id="txtEditorial"/></td>
                </tr>
                <tr>
                    <td>Origen</td>
                    <td><input type="text" id="txtOrigin"/></td>
                </tr>
                <tr>
                    <td>Estado</td>
                    <td>
                        <select id="opStatus">
                            <option selected>--Seleccionar--</option>
                            <option>Completo</option>
                            <option>Incompleto</option>
                            <option>Solo Mejora</option>
                            <option>Pendiente apertura</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Prioridad</td>
                    <td><input type="number" id="txtPriority"/></td>
                </tr>
                <tr>
                    <td>Destino</td>
                    <td>
                        <select id="opDestiny">
                            <option selected>--Seleccionar--</option>
                            <option>Propia</option>
                            <option>Venta</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Forma</td>
                    <td>
                        <select id="opForm">
                            <option selected>--Seleccionar--</option>
                            <option>Pegado</option>
                            <option>Set a pegar</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Guarado en Binder</td>
                    <td>
                        <select id="opBinder">
                            <option selected>--Seleccionar--</option>
                            <option>Si</option>
                            <option>No</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <center><input type="submit" name="Guardar"/></center>
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>
