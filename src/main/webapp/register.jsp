<html>
<head>
    <title>Title</title>
</head>
<body>
    <center>
        <form name="formRegister">
            <table border="2">
                <tr>
                    <td colspan="2" align="center">Registro de Coleccion</td>
                </tr>
                <tr>
                    <td>Nombre de Coleccion</td>
                    <td><input type="text" name="txtName"/></td>
                </tr>
                <tr>
                    <td>Tipo</td>
                    <td>
                        <select name="opType">
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
                    <td><input type="text" name="txtEditorial"/></td>
                </tr>
                <tr>
                    <td>Origen</td>
                    <td><input type="text" name="txtOrigin"/></td>
                </tr>
                <tr>
                    <td>Estado</td>
                    <td>
                        <select name="opStatus">
                            <option selected>--Seleccionar--</option>
                            <option>Completo</option>
                            <option>Incompleto</option>
                            <option>Solo mejora</option>
                            <option>Pendiente abrir</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Prioridad</td>
                    <td><input type="number" name="txtPriority"/></td>
                </tr>
                <tr>
                    <td>Destino</td>
                    <td>
                        <select name="opDestiny">
                            <option selected>--Seleccionar--</option>
                            <option>Propia</option>
                            <option>Venta</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Forma</td>
                    <td>
                        <select name="opForm">
                            <option selected>--Seleccionar--</option>
                            <option>Pegado</option>
                            <option>Set a pegar</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Guarado en Binder</td>
                    <td>
                        <select name="opBinder">
                            <option selected>--Seleccionar--</option>
                            <option>Si</option>
                            <option>No</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>
