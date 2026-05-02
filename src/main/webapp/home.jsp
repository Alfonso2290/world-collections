<html>
<head>
    <!-- CSS de DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
</head>
<body>
    <center>
        <br><br>
        Nombre: <input type="search" name="filterNameCollection" id="filterNameCollection"/>
        Editorial: <input type="search" name="filterEditorialCollection" id="filterEditorialCollection"/>
        <button type="button" onclick="formListCollectionsFilterName(event)">Buscar</button>
        <button type="button" onclick="formRegisterCollections()">Nuevo</button>
        <br><br>
        <table border="2" id="miTabla">
            <thead>
                <tr>
                    <td>Name</td>
                    <td>Type</td>
                    <td>Editorial</td>
                    <td>Origin</td>
                    <td>Status</td>
                    <td>Priority</td>
                    <td>Destiny</td>
                    <td>Form</td>
                    <td>Binder</td>
                    <td>Agregar Tabla de Control</td>
                    <td>Modificar Tabla de Control</td>
                </tr>
            </thead>
            <tbody id="collections-body">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>

        <!--Paginado-->
        <!-- jQuery (OBLIGATORIO) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- DataTables -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <!---->

        <script>

            let table;

            $(document).ready(function() {
                table = $('#miTabla').DataTable({
                    pageLength: 10, //Paginado x default
                    searching: false //Deshabilita la busqueda de la tabla
                });

                formListCollectionsFilterName();
            });

            async function formListCollectionsFilterName(event) {
                if(event) event.preventDefault();
                const name = document.getElementById("filterNameCollection").value;
                const editorial = document.getElementById("filterEditorialCollection").value;
                let url='';
                if(editorial.length!==0 && name.length!==0){
                    url = `?name=${name}&editorial=${editorial}`
                }else if(name.length!==0){
                    url = `?name=${name}`;
                }else if(editorial.length!==0){
                    url = `?editorial=${editorial}`;
                }
                const response = await fetch(`http://localhost:8081/control/collections${url}`, {
                    method: "GET"
                });

                const result = await response.json();

                table.clear();

                result.forEach(item => {
                    const title = item.name.toString().toUpperCase().concat(' - ')
                        .concat(item.type.toString().toUpperCase()).concat(' - ')
                        .concat(item.editorial.toString().toUpperCase()).concat(' - ')
                        .concat(item.origin.toString().toUpperCase()).concat(' - ')
                        .concat(item.priority.toString());

                    table.row.add([
                        `<a href='detail.jsp?id=${item.id}&title=${title}'>${item.name}</a>`,
                        item.type,
                        item.editorial,
                        item.origin,
                        item.status,
                        item.priority,
                        item.destiny,
                        item.form,
                        item.binder,
                        `<input type="button" value="Agregar" onclick="registerControlCollection(${item.id})"/>`,
                        `<input type="button" value="Modificar" onclick="updateControlCollection(${item.id},'${title}')"/>`
                    ]);
                });

                table.draw();
            }

            function formRegisterCollections(){
                window.location.href = "register.jsp";
            }

            function registerControlCollection(id){
                window.location.href = "register-control.jsp?id=" + id;
            }

            function updateControlCollection(id, title){
                window.location.href = "update-control.jsp?id=" + id + "&title=" + title;
            }
        </script>

    </center>
</body>
</html>