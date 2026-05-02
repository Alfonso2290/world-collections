<%
    String requestId = request.getParameter("id"); //Recupera valor enviado desde hipervinculo de home.jsp (href)
    String title = request.getParameter("title");
%>

<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        /* 🔹 TITLE */
        h1 {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            background-color: white;
            display: inline-block;
            padding: 10px 20px;
            border-radius: 8px;
            border-left: 5px solid #007bff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            letter-spacing: 1px;
        }

        /* 🔹 TABLAS */
        table {
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }

        td {
            padding: 6px;
            text-align: center;
            font-size: 13px;
            border: 1px solid #ddd;
        }

        /* 🔹 GRID DE FIGURAS */
        #t1 td {
            min-width: 35px;
            height: 35px;
            font-weight: bold;
        }

        #t1 td:hover {
            transform: scale(1.1);
            cursor: pointer;
        }

        /* 🔹 FORM MODIFICAR */
        #t3 {
            margin-top: 10px;
        }

        #t3 td {
            padding: 8px;
            text-align: left;
        }

        /* inputs */
        #t3 input, #t3 select {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
        }

        #t3 input:focus, #t3 select:focus {
            border-color: #007bff;
            box-shadow: 0 0 4px rgba(0,123,255,0.4);
        }

        /* botón modificar */
        #t3 button {
            padding: 8px 16px;
            background-color: #ffc107;
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        #t3 button:hover {
            background-color: #e0a800;
        }

        /* 🔹 LEYENDA */
        #t2 {
            margin-top: 10px;
        }

        #t2 td {
            padding: 6px 10px;
            text-align: left;
        }

        /* 🔹 TITULOS DE SECCION (colspan dinámico) */
        td[colspan="10"], td[colspan="2"] {
            font-weight: bold;
            text-align: center;
            background-color: #2a27f5 !important;
            color: white;
            font-size: 14px;
        }
    </style>
    <script>
        let ArrayStatus = [];

        async function formListDetailCollections(event) {
            event.preventDefault();
            const id = document.getElementById("collectionId").value;

            const response = await fetch(`http://localhost:8081/control/collections-detail?collectionId=${id}`, {
                method: "GET"
            });

            const result = await response.json();

            const tbody = document.getElementById("collections-update-body");
            tbody.innerHTML = ""; // limpiar tabla

            let index = 0;
            let row = null;
            let typeBefore = 'Basica';
            let indexStatus = 0;

            result.forEach(item => {

                if(!ArrayStatus.includes(item.status)){
                    ArrayStatus[indexStatus] = item.status;
                    indexStatus++
                }

                let numeration = item.numeration;
                if(typeBefore!== item.type) {
                    typeBefore = item.type;
                    index = 0;
                }

                const updated = buildTable(index, row, item, tbody, numeration);
                index = updated.index;
                row = updated.row;

                // Si quedó una fila incompleta, agregarla
                if (row !== null) {
                    tbody.appendChild(row);
                }
            });

            legend();
            buildTableStatusControl();
        }

        function buildTable(index,row,item,tbody,numeration){
            if(index===0){
                row = document.createElement("tr");
                const tdTitle = document.createElement("td");
                tdTitle.textContent = item.type;
                tdTitle.setAttribute("colspan", "10");
                tdTitle.style.fontWeight = "bold";
                tdTitle.style.textAlign = "center";
                tdTitle.style.backgroundColor = "rgb(42, 39, 245)";
                tdTitle.style.color = "rgb(255, 255, 255)";
                row.appendChild(tdTitle);
                tbody.appendChild(row);
            }

            // Crear nueva fila cada 10 elementos
            if (index % 10 === 0) {
                row = document.createElement("tr");
            }

            // Crear la celda
            const td = document.createElement("td");
            if(item.status==='S') td.style.backgroundColor = "rgb(39, 245, 111)"; //Yala
            if(item.status==='N') td.style.backgroundColor = "rgb(245, 66, 39)"; //Nola
            if(item.status==='A') td.style.backgroundColor = "rgb(245, 166, 39)"; //Falta agregar
            if(item.status==='M') td.style.backgroundColor = "rgb(242, 245, 39)"; //Mejora
            td.textContent = numeration;
            row.appendChild(td);

            // Si llegamos a 10 elementos, agregar la fila
            if (index % 10 === 9) {
                tbody.appendChild(row);
                row = null;
            }

            index++;

            // Retorna valores actualizados
            return { index, row };
        }

        function buildTableStatusControl(){

            const tbody = document.getElementById("collections-control-status");
            tbody.innerHTML = ""; // limpiar tabla

            let row = document.createElement("tr");
            const tdTitle = document.createElement("td");
            tdTitle.textContent = 'Modificar Estado';
            tdTitle.setAttribute("colspan", "2");
            tdTitle.style.fontWeight = "bold";
            tdTitle.style.textAlign = "center";
            row.appendChild(tdTitle);
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Estado:</td>
                    <td><select id="statusControl"><option>Yala</option><option>Nola</option><option>Mejora</option><option>Pendiente Agregar</option></select></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Figura:</td>
                    <td><input id="figureControl"></input type="text" id="txtFigure"></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Tipo (Opc):</td>
                    <td><input id="typeControl"></input type="text" id="txtType"></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td colspan="2"><center><button onclick="updateFigureControlCollection()">Modificar</button></center></td>
                `;
            tbody.appendChild(row);
        }

        async function updateFigureControlCollection(){

            //event.preventDefault();
            const collectionId = document.getElementById("collectionId").value;
            const status = document.getElementById("statusControl").value;
            const numeration = document.getElementById("figureControl").value;
            let type = document.getElementById("typeControl").value;
            const title = document.getElementById("titleId").value;

            if(type==='') type = null;


            let statusFinal='';
            if(status==='Yala') statusFinal = "S"; //Yala
            if(status==='Nola') statusFinal = "N"; //Nola
            if(status==='Pendiente Agregar') statusFinal = "A"; //Falta agregar
            if(status==='Mejora') statusFinal = "M"; //Mejora

            const bodyElement = {
                numeration,
                status: statusFinal,
                collectionId,
                type
            }

            const response = await fetch(`http://localhost:8081/control/update/control-collections`,{
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(bodyElement)
            });

            if(response.ok){
                window.location.href = "update-control.jsp?id=" + collectionId + "&title=" + title;
            }else{
                const text = await response.text(); // leer error del backend si existe
                alert("Error del servidor (status " + response.status + "): " + text);
            }
        }

        function legend(){
            const tbody = document.getElementById("legend-body");
            tbody.innerHTML = ""; // limpiar tabla

            if(ArrayStatus.length>0) {
                const row = document.createElement("tr");
                const tdTitle = document.createElement("td");
                tdTitle.textContent = 'Leyenda';
                tdTitle.setAttribute("colspan", "2");
                tdTitle.style.fontWeight = "bold";
                tdTitle.style.textAlign = "center";
                row.appendChild(tdTitle);
                tbody.appendChild(row);
            }

            ArrayStatus.forEach(item => {
                const row = document.createElement("tr");

                const td1 = document.createElement("td");
                td1.textContent='';
                td1.style.padding = "8px";
                if(item==='S') td1.style.backgroundColor = "rgb(39, 245, 111)"; //Yala
                if(item==='N') td1.style.backgroundColor = "rgb(245, 66, 39)"; //Nola
                if(item==='A') td1.style.backgroundColor = "rgb(245, 166, 39)"; //Falta agregar
                if(item==='M') td1.style.backgroundColor = "rgb(242, 245, 39)"; //Mejora

                const td2 = document.createElement("td");
                td2.textContent = item==='S' ? 'Yala': item==='N' ? 'Nola': item==='A'? 'Pendiente Agregar': item==='M' ? 'Mejora':'';

                row.appendChild(td1);
                row.appendChild(td2);
                tbody.appendChild(row);
            });
        }
        window.addEventListener("load", formListDetailCollections);
    </script>
</head>
<body>
    <center>
        <input type="hidden" value="<%=requestId%>" id="collectionId"/>
        <input type="hidden" value="<%=title%>" id="titleId"/>
        <br><br>
        <h1><%= title %></h1>
        <br><br>
        <table border="2" id="t1">
            <thead>
            </thead>
            <tbody id="collections-update-body">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
        <br><br>
        <table border="2" id="t3">
            <thead>
            </thead>
            <tbody id="collections-control-status">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
        <br><br>
        <table border="2" id="t2">
            <thead>
            </thead>
            <tbody id="legend-body">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
    </center>
</body>
</html>
