<%
    String requestId = request.getParameter("id");
%>
<html>
<head>
    <script>
        let countFieldNewType = 1;
        let arrayMapTypes = new Map();

        async function formListNumericCollections(event) {
            event.preventDefault();

            if(document.getElementById("opColorCell")!==null){
                let arrayFieldNewType = [];
                const colorCell=document.getElementById("opColorCell").value;
                const typeCollection = document.getElementById("txtTypeCollection").value;
                let numberSelected;
                for (let i=1; i<=countFieldNewType;i++){
                    numberSelected = parseInt(document.getElementById(`txtNumberSelected_${i}`).value);
                    arrayMapTypes.set(numberSelected,typeCollection);
                    arrayFieldNewType[i-1]=numberSelected;
                }
                /*for (let [key, value] of arrayMapTypes.entries()) {
                    alert("Fila " + key + ":" + value);
                }*/
                addTable(colorCell,numberSelected,arrayFieldNewType);
            }else{
                addTable(null,null,null);
            }

        }

        function addTable(colorCell,numberSelected,arrayNumberSelected){
            const countNumeric = parseInt(document.getElementById("txtCount").value);
            //alert(countNumeric);
            //const id = document.getElementById("collectionId").value;

            const tbody = document.getElementById("count-numeric");
            tbody.innerHTML = ""; // limpiar tabla

            let row = null;
            for (let i = 0; i < countNumeric; i++) {
                if(i%10===0){
                    row = document.createElement("tr");
                }
                const td = document.createElement("td");
                td.textContent = i+1;
                if(arrayNumberSelected!=null && arrayNumberSelected.includes(i+1)) {
                    switch (colorCell){
                        case 'Rojo': td.style.backgroundColor = "rgb(245, 66, 39)";break;
                        case 'Azul': td.style.backgroundColor = "rgb(42, 39, 245)";break;
                        case 'Amarillo': td.style.backgroundColor = "rgb(242, 245, 39)";break;
                        case 'Rosado': td.style.backgroundColor = "rgb(245, 39, 221)";break;
                        case 'Naranja': td.style.backgroundColor = "rgb(245, 166, 39)";break;
                        case 'Lila': td.style.backgroundColor = "rgb(224, 39, 245)";break;
                        case 'Celeste': td.style.backgroundColor = "rgb(39, 245, 235)";
                    }
                }
                row.appendChild(td);


                if (i % 10 === 9) {
                    tbody.appendChild(row);
                    row = null;
                }
            }
            if (row !== null) {
                tbody.appendChild(row);
            }
        }

        async function addTypeCollection(event){
            event.preventDefault();
            const tbody = document.getElementById("add-type-confirmation");

            let txtTypeCollectionBefore='';
            let opTypeConfirmationBefore = 'Si';
            if(document.getElementById("txtTypeCollection")!==null){
                txtTypeCollectionBefore = document.getElementById("txtTypeCollection").value;
                opTypeConfirmationBefore = document.getElementById("opTypeConfirmation").value;
            }

            tbody.innerHTML = ""; // limpiar tabla

            let row = document.createElement("tr");

            row.innerHTML = `
                    <td>Agregar Tipo:</td>
                    <td><select id="opTypeConfirmation"><option>Si</option><option>No</option></select></td>
                `;
            //Si es no todas son basicas
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Tipo:</td>
                    <td><input type="text" id="txtTypeCollection" name="txtTypeCollectionName"/></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td colspan="2"><center><button onclick="addNumbersType(event);validateButton()">Confirmar</button></center></td>
                `;
            tbody.appendChild(row);

            document.getElementById("txtTypeCollection").value = txtTypeCollectionBefore;
            document.getElementById("opTypeConfirmation").value = opTypeConfirmationBefore;
        }

        async function addNumbersType(event){
            const tbody = document.getElementById("count-numeric-type");
            tbody.innerHTML = ""; // limpiar tabla

            let row = document.createElement("tr");
            row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                    <td><center><button onclick="addType(event)">Add</button></center></td>
                `;
            tbody.appendChild(row);
        }

        async function addType(event){
            countFieldNewType++;

            const tbody = document.getElementById("count-numeric-type");

            let row = document.createElement("tr");
            row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                `;
            tbody.appendChild(row);
        }

        function validateButton() {
            document.getElementById("button-confirmation-type").innerHTML = `
                  <center><button onclick="addColorType()">Confirmar</button></center>
            `;
        }

        function addColorType() {
            document.getElementById("color-type").innerHTML = `
                    <center>
                    <table border="2">
                        <tr>
                            <td>Indique color referente</td>
                            <td>
                                <select id="opColorCell">
                                    <option value="Rojo" selected>Rojo</option>
                                    <option value="Azul">Azul</option>
                                    <option value="Amarillo">Amarillo</option>
                                    <option value="Rosado">Rosado</option>
                                    <option value="Naranja">Naranja</option>
                                    <option value="Lila">Lila</option>
                                    <option value="Celeste">Celeste</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><center> <button onclick="formListNumericCollections(event);addTypeCollection(event)">Confirmar</button></center></td>
                        </tr>
                    <table>
                    </center>
            `;
        }
    </script>
</head>
<body>
    <center>
        <input type="hidden" id="collectionId" value="<%=requestId%>"/>
        <br><br>
        <table>
            <tr>
                <td>Cantidad de figuras Numericas</td>
                <td><input type="text" id="txtCount"/></td>
                <td><button type="button" onclick="formListNumericCollections(event);addTypeCollection(event)">Buscar</button></td>
            </tr>
        </table>
        <br/><br/>
        <table border="2">
            <thead>
            </thead>
            <tbody id="count-numeric">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
        <br><br>
        <table border="2">
            <thead>
            </thead>
            <tbody id="add-type-confirmation">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
        <br><br>
        <table border="2">
            <thead>
            </thead>
            <tbody id="count-numeric-type">
            <!-- Aquí se pintan las filas dinámicamente -->
            </tbody>
        </table>
        <br>
        <div id="button-confirmation-type"></div>
        <br>
        <div id="color-type"></div>
    </center>
</body>
</html>
