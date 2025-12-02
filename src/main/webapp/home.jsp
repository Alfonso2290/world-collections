<html>
<head>
    <script>
        async function formListCollections(event) {
            event.preventDefault();
            const response = await fetch(`http://localhost:30080/control/collections`, {
                method: "GET"
            });

            const result = await response.json();

            const tbody = document.getElementById("collections-body");
            tbody.innerHTML = ""; // limpiar tabla

            result.forEach(item => {
                const row = document.createElement("tr");

                row.innerHTML = `
                    <td>${item.name}</td>
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
        window.onload = formListCollections; // ejecutar al cargar
    </script>
</head>
<body>
    <center>
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