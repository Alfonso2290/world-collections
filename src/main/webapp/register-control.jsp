<%
    String requestId = request.getParameter("id");
%>
<html>
<head>
    <script>
        let countFieldNewType = 1;
        let typeCollection = null;
        let arrayMapColor = new Map(); //Contiene {"12":"Rojo","14":"Rojo","23":"Azul"}
        let arrayFieldNewType = [];
        let arrayMapTypes = new Map(); //Contiene {"12":"Especial lluvia","14":"Especial lluvia","23":"Especial vidrio"}

        async function formListNumericCollections(event) {
            event.preventDefault();

            if(document.getElementById("opColorCell")!==null){
                const colorCell=document.getElementById("opColorCell").value;
                let numberSelected;
                for(let i=0; i<countFieldNewType;i++){
                    numberSelected = parseInt(arrayFieldNewType[i]);
                }

                for(let i=arrayMapColor.size;i<countFieldNewType-1;i++){
                    arrayMapColor.set(arrayFieldNewType[i],colorCell);
                }
                /*for (let [key, value] of arrayMapTypes.entries()) {
                    alert("Fila " + key + ":" + value);
                }
                for (let [key, value] of arrayMapColor.entries()) {
                    alert("Fila " + key + ":" + value);
                }*/
                addTable(numberSelected,arrayFieldNewType);
            }else{
                addTable(null,null);
            }

        }

        function addTable(numberSelected,arrayNumberSelected){
            const countNumeric = parseInt(document.getElementById("txtCount").value);
            //alert(countNumeric);
            //const id = document.getElementById("collectionId").value;

            const tbody = document.getElementById("container-list-numbers-collection");
            tbody.innerHTML = "";

            let row = null;
            for (let i = 0; i < countNumeric; i++) {
                if(i%10===0){
                    row = document.createElement("tr");
                }
                const td = document.createElement("td");
                td.textContent = i+1;
                if(arrayNumberSelected!=null && arrayNumberSelected.includes(i+1)) {
                    switch (arrayMapColor.get(i+1)){
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

        async function containerSelectionTypeCollection(event){
            event.preventDefault();
            const tbody = document.getElementById("container-selection-type-collection");

            let txtTypeCollectionBefore='';
            let opTypeConfirmationBefore = 'Si';
            if(document.getElementById("txtTypeCollection")!==null){
                txtTypeCollectionBefore = document.getElementById("txtTypeCollection").value;
                opTypeConfirmationBefore = document.getElementById("opTypeConfirmation").value;
            }

            tbody.innerHTML = "";

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
                    <td><center><button onclick="containerAddNumbersTypeCollection(event);confirmationButtonByAddNumbersTypeCollections();cleanTableType('container-selection-type-collection')">Confirmar</button></center></td>
                    <td><center><button>Guardar</button></center></td>
                `;
            tbody.appendChild(row);

            document.getElementById("txtTypeCollection").value = txtTypeCollectionBefore;
            document.getElementById("opTypeConfirmation").value = opTypeConfirmationBefore;
        }

        async function containerAddNumbersTypeCollection(event){
            typeCollection = document.getElementById("txtTypeCollection").value;
            const tbody = document.getElementById("container-selection-numbers-type-collection");
            tbody.innerHTML = "";

            let row = document.createElement("tr");
            row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                    <td><center><button onclick="containerAddNumbersTypeCollectionComplementary(event)">Add</button></center></td>
                `;
            tbody.appendChild(row);
        }

        async function containerAddNumbersTypeCollectionComplementary(event){
            countFieldNewType++;

            const tbody = document.getElementById("container-selection-numbers-type-collection");

            let row = document.createElement("tr");
            row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                `;
            tbody.appendChild(row);
        }

        function confirmationButtonByAddNumbersTypeCollections() {
            document.getElementById("container-confirmation-numbers-selection").innerHTML = `
                  <center><button onclick="containerSelectedColorTypeCollection();cleanTableType('container-selection-numbers-type-collection');cleanDiv('container-confirmation-numbers-selection')">Confirmar</button></center>
            `;
        }

        function containerSelectedColorTypeCollection() {
            let numberSelected;
            const countNumbersAdded = arrayFieldNewType.length + 1;
            for (let i=countNumbersAdded; i<=countFieldNewType;i++){
                numberSelected = parseInt(document.getElementById(`txtNumberSelected_${i}`).value);
                arrayMapTypes.set(numberSelected,typeCollection);
                arrayFieldNewType[i-1]=numberSelected;
            }
            countFieldNewType++;

            document.getElementById("container-selection-color").innerHTML = `
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
                            <td colspan="2"><center> <button onclick="formListNumericCollections(event);containerSelectionTypeCollection(event);cleanDiv('container-selection-color')">Confirmar</button></center></td>
                        </tr>
                    <table>
                    </center>
            `;
        }

        function cleanTableType(contentTableContainer){
            const tbody = document.getElementById(contentTableContainer);
            tbody.innerHTML = "";
            let row = document.createElement("tr");
            row.innerHTML = "";
            tbody.appendChild(row);
        }

        function cleanDiv(contentDivContainer){
            document.getElementById(contentDivContainer).innerHTML = "";
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
                <td><button type="button" onclick="formListNumericCollections(event);containerSelectionTypeCollection(event)">Buscar</button></td>
            </tr>
        </table>
        <br/><br/>
        <table border="2">
            <thead>
            </thead>
            <tbody id="container-list-numbers-collection">
            </tbody>
        </table>
        <br><br>
        <table border="2">
            <thead>
            </thead>
            <tbody id="container-selection-type-collection">
            </tbody>
        </table>
        <br><br>
        <table border="2">
            <thead>
            </thead>
            <tbody id="container-selection-numbers-type-collection">
            </tbody>
        </table>
        <br>
        <div id="container-confirmation-numbers-selection"></div>
        <br>
        <div id="container-selection-color"></div>
    </center>
</body>
</html>
