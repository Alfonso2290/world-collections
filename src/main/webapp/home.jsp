<html>
<head>
    <script>
        async function formListCollectionsFilterName(event) {
            event.preventDefault();
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
            const response = await fetch(`http://localhost:30080/control/collections${url}`, {
                method: "GET"
            });

            const result = await response.json();

            const tbody = document.getElementById("collections-body");
            tbody.innerHTML = ""; // limpiar tabla

            result.forEach(item => {
                const row = document.createElement("tr");

                row.innerHTML = `
                    <td><a href='detail.jsp?id=${item.id}'>${item.name}</a></td>
                    <td>${item.type}</td>
                    <td>${item.editorial}</td>
                    <td>${item.origin}</td>
                    <td>${item.status}</td>
                    <td>${item.priority}</td>
                    <td>${item.destiny}</td>
                    <td>${item.form}</td>
                    <td>${item.binder}</td>
                `;

                tbody.appendChild(row);
            });
        }

        function formRegisterCollections(){
            window.location.href = "register.jsp";
        }
        window.onload = formListCollectionsFilterName; // ejecutar al cargar
    </script>
</head>
<body>
    <center>
        <br><br>
        Nombre: <input type="search" name="filterNameCollection" id="filterNameCollection"/>
        Editorial: <input type="search" name="filterEditorialCollection" id="filterEditorialCollection"/>
        <button type="button" onclick="formListCollectionsFilterName(event)">Buscar</button>
        <button type="button" onclick="formRegisterCollections()">Nuevo</button>
        <br><br>
        <table border="2">
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
                </tr>
            </thead>
            <tbody id="collections-body">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
    </center>
</body>
</html>