<%
    String requestId = request.getParameter("id"); //Recupera valor enviado desde hipervinculo de home.jsp (href)
%>

<html>
<head>
    <script>
        let ArrayStatus = [];

        async function formListDetailCollections(event) {
            event.preventDefault();
            const id = document.getElementById("collectionId").value;

            const response = await fetch(`http://localhost:30080/control/collections-detail?collectionId=${id}`, {
                method: "GET"
            });

            const result = await response.json();

            const tbody = document.getElementById("collections-detail-body");
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

            // RETORNAMOS valores actualizados
            return { index, row };
        }

        function legend(){
            const tbody = document.getElementById("legend-body");
            tbody.innerHTML = ""; // limpiar tabla

            const row = document.createElement("tr");
            const tdTitle = document.createElement("td");
            tdTitle.textContent='Leyenda';
            tdTitle.setAttribute("colspan", "2");
            tdTitle.style.fontWeight = "bold";
            tdTitle.style.textAlign = "center";
            row.appendChild(tdTitle);
            tbody.appendChild(row);

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
        <br><br>
        <table border="2" id="t1">
            <thead>
            </thead>
            <tbody id="collections-detail-body">
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
