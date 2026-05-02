<%
    String requestId = request.getParameter("id");
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        /* 🔹 TABLAS GENERALES */
        table {
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            margin: 5px auto;
        }

        td {
            padding: 8px;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        /* 🔹 GRID PRINCIPAL (numeración) */
        #container-list-numbers-collection td {
            min-width: 35px;
            height: 35px;
            text-align: center;
            font-weight: bold;
            transition: transform 0.15s;
        }

        #container-list-numbers-collection td:hover {
            transform: scale(1.1);
            cursor: pointer;
        }

        /* 🔹 INPUTS */
        input[type="text"] {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
            transition: border 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus {
            border-color: #007bff;
            box-shadow: 0 0 4px rgba(0,123,255,0.4);
        }

        /* 🔹 SELECT */
        select {
            width: 100%;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
            outline: none;
        }

        select:focus {
            border-color: #007bff;
            box-shadow: 0 0 4px rgba(0,123,255,0.4);
        }

        /* 🔹 BOTONES */
        button {
            padding: 7px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            transition: all 0.2s;
        }

        button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        /* 🔹 BOTONES IMPORTANTES (automático por posición) */
        button:nth-of-type(2) {
            background-color: #28a745;
        }

        button:nth-of-type(2):hover {
            background-color: #1e7e34;
        }

        /* 🔹 SECCIONES DINÁMICAS */
        #container-add-news-items-collections,
        #container-selection-type-collection,
        #container-selection-numbers-type-collection {
            margin-top: 10px;
        }

        /* 🔹 BLOQUES DINÁMICOS (divs) */
        #container-confirmation-numbers-selection,
        #container-selection-color,
        #container-add-table-additional {
            margin-top: 10px;
        }

        /* 🔹 TABLA DE COLORES (cuando aparece dinámicamente) */
        #container-selection-color table td {
            text-align: center;
        }

    </style>
    <script>

        /**
         * Pendiente:
         *
         * REALIZAR VALIDACIONES
         * ---------------------
         *
         * */
        let countFieldNewType = 1;
        let typeCollection = null;
        let arrayMapColor = []; //Contiene {"12":"Rojo","14":"Rojo","23":"Azul"}
        let jsonArrayMapColor = []; //Contiene [{number:"12", color:"Rojo", index:"1" },{number:"14", color:"Azul", index:"12" }]
        let arrayFieldNewType = []; //Contiene los numeros que voy agregando en boton Add
        let indexes = []; //Contiene indices a agregar {101,102,160,161}
        let arrayMapTypes = []; //Contiene {"12":"Especial lluvia","14":"Especial lluvia","23":"Especial vidrio"}
        let arrayTypes = [];
        let arrayFieldTableAdditional = []; //Contiene todos los numeros de la coleccion
        const abecedary = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";

        function letterToNumber(letter) {
            const index = abecedary.indexOf(letter.toUpperCase());
            return index !== -1 ? index + 1 : null;
        }

        function numberToLetter(number) {
            if (number < 1 || number > abecedary.length) return null;
            return abecedary[number - 1];
        }

        function addElementArrayMapColor(number, color, index, type) {
            jsonArrayMapColor.push({
                number,
                color,
                index,
                type
            });
        }

        function addElementArrayMapTypes(number, type) {
            arrayMapTypes.push({
                number,
                type
            });
        }

        function addElementArrayColor(number, color) {
            arrayMapColor.push({
                number,
                color
            });
        }

        async function formListNumericCollections(event) {
            event.preventDefault();

            if(document.getElementById("opColorCell")!==null){
                const colorCell=document.getElementById("opColorCell").value;

                for(let i=arrayMapColor.length;i<countFieldNewType-1;i++){
                    addElementArrayColor(arrayFieldNewType[i],colorCell);
                    //alert("Agregando: Num" + arrayFieldNewType[i].toString() + " - Color: " + colorCell.toString() + " - Indice: " + indexes[i].toString() + " - Tipo: " +  arrayTypes[i].toString());
                    addElementArrayMapColor(arrayFieldNewType[i].toString(), colorCell.toString(), indexes[i].toString(), arrayTypes[i].toString());
                }

                addTable();
            }else{
                addTable();
            }

            /*jsonArrayMapColor.forEach(function(item) {
                alert("Json: " + item.index + "/" + item.number + "/" + item.color);
            });*/

        }

        function addTable(){
            const countNumeric = parseInt(document.getElementById("txtCount").value);

            const tbody = document.getElementById("container-list-numbers-collection");
            tbody.innerHTML = "";

            for(let i = 0; i < countNumeric; i++ ){
                arrayFieldTableAdditional[i] = (i + 1).toString();
            }

            let row = null;
            for (let i = 0; i < countNumeric; i++) {
                if(i%10===0){
                    row = document.createElement("tr");
                }
                const td = document.createElement("td");
                td.textContent = (i+1).toString();
                if(arrayFieldNewType!=null && arrayFieldNewType.includes(i+1)) {
                    const number = i +1;
                    const elementJson = jsonArrayMapColor.find(item => item.number.toString() === number.toString() && (item.index ? item.index.toString()===i.toString() : true));
                    switch (elementJson.color){
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

            addTableAdditional(event);
        }

        function addTableAdditional(event){
            event.preventDefault();

            let acronymTemp;
            let initNumberAcronymTemp;
            let endNumberAcronymTemp;
            if(document.getElementById("txtAcronym")!=null && document.getElementById("txtInitNumberAcronym")!=null && document.getElementById("txtEndNumberAcronym")!=null) {
                acronymTemp = document.getElementById("txtAcronym").value;
                initNumberAcronymTemp = document.getElementById("txtInitNumberAcronym").value;
                endNumberAcronymTemp = document.getElementById("txtEndNumberAcronym").value;
            }
            const acronym = acronymTemp ;
            let initNumberAcronym = parseInt(initNumberAcronymTemp);
            let endNumberAcronym = parseInt(endNumberAcronymTemp);
            const arraySize = parseInt(arrayFieldTableAdditional.length.toString());

            if(acronym === 'Letra'){
                initNumberAcronym = initNumberAcronymTemp.toString().toUpperCase().charCodeAt(0) - 64;
                endNumberAcronym = endNumberAcronymTemp.toString().toUpperCase().charCodeAt(0) - 64;
            }

            if(acronym === 'Letra Latina'){
                initNumberAcronym = letterToNumber(initNumberAcronymTemp);
                endNumberAcronym = letterToNumber(endNumberAcronymTemp);
            }

            let arrayNumber = [];
            let countRange = 0;
            if(acronym === 'Rango'){
                arrayNumber = initNumberAcronymTemp.toString().split(",");
                initNumberAcronym = 1 ;
                endNumberAcronym = arrayNumber.length;
            }

            for(let i = arrayFieldTableAdditional.length; i < arraySize + (endNumberAcronym - initNumberAcronym) + 1; i++ ){
                if(acronym === 'Letra'){
                    arrayFieldTableAdditional[i] = String.fromCharCode((i - arraySize) + initNumberAcronym + 64);
                }else if(acronym === 'Numero') {
                    arrayFieldTableAdditional[i] = i - arraySize + initNumberAcronym;
                }else if(acronym === 'Letra Latina'){
                    arrayFieldTableAdditional[i] = numberToLetter((i - arraySize) + initNumberAcronym);
                }else if(acronym === 'Rango'){
                    arrayFieldTableAdditional[i] = parseInt(arrayNumber[countRange]);
                    countRange++;
                }
                else{
                    arrayFieldTableAdditional[i] = acronym + (i - arraySize +initNumberAcronym);
                }

            }

            const tbody = document.getElementById("container-list-numbers-collection");
            tbody.innerHTML = "";

            let row = null;
            for (let i = 0; i < arrayFieldTableAdditional.length; i++) {
                if(i%10===0){
                    row = document.createElement("tr");
                }
                const td = document.createElement("td");
                td.textContent = arrayFieldTableAdditional[i];

                if (arrayFieldNewType != null) {
                    const number = arrayFieldTableAdditional[i].toString();
                    const elementJson = jsonArrayMapColor.find(item => item.number.toString() === number.toString() && item.index.toString() === i.toString());

                    if(elementJson){
                        //alert("Indices a pintar: " + i);
                        switch (elementJson.color){
                            case 'Rojo': td.style.backgroundColor = "rgb(245, 66, 39)";break;
                            case 'Azul': td.style.backgroundColor = "rgb(42, 39, 245)";break;
                            case 'Amarillo': td.style.backgroundColor = "rgb(242, 245, 39)";break;
                            case 'Rosado': td.style.backgroundColor = "rgb(245, 39, 221)";break;
                            case 'Naranja': td.style.backgroundColor = "rgb(245, 166, 39)";break;
                            case 'Lila': td.style.backgroundColor = "rgb(224, 39, 245)";break;
                            case 'Celeste': td.style.backgroundColor = "rgb(39, 245, 235)";
                        }
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

        async function containerAddTableAdditional(){
            document.getElementById("container-add-table-additional").innerHTML = `
                  <center><button onclick="containerTableAdditional(event);cleanDiv('container-add-table-additional')">Add</button></center>
            `;
        }

        async function containerTableAdditional(event){
            event.preventDefault();
            const tbody = document.getElementById("container-add-news-items-collections");
            tbody.innerHTML = "";
            let row = document.createElement("tr");

            row.innerHTML = `
                    <td>Acronimo:</td>
                    <td><input type="text" id="txtAcronym"/></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Valor inicial:</td>
                    <td><input type="text" id="txtInitNumberAcronym"/></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Valor final:</td>
                    <td><input type="text" id="txtEndNumberAcronym"/></td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td colspan="2"><center><button onclick="formListNumericCollections(event);containerAddTableAdditional();cleanTableType('container-add-news-items-collections')">Agregar</button></center></td>
                `;
            tbody.appendChild(row);
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
                    <td><center><button onclick="saveControlCollection(event)">Guardar</button></center></td>
                `;
            tbody.appendChild(row);

            document.getElementById("txtTypeCollection").value = txtTypeCollectionBefore;
            document.getElementById("opTypeConfirmation").value = opTypeConfirmationBefore;
        }

        async function saveControlCollection(event){
            event.preventDefault();
            const collectionId = document.getElementById("collectionId").value;
            let data = [];
            /*
            jsonArrayMapColor.forEach(function(item) {
                alert("Json: " + item.index + "/" + item.number + "/" + item.color + "/" + item.type);
            });*/
            let position = 0;
            arrayFieldTableAdditional.forEach(number => {
                let typeByNumber = getNumberSelected(number, position);
                position++;
                const bodyElement = {
                    type: typeByNumber,
                    numeration:number,
                    status: "S",
                    collectionId
                }
                data.push(bodyElement);
            });

            const response = await fetch(`http://localhost:8081/control/save/control-collections`,{
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            if(response.ok){
                window.location.href = "home.jsp";
            }else{
                const text = await response.text();
                alert("Error del servidor (status " + response.status + "): " + text);
            }
        }

        function getNumberSelected(number, index){
            let valueEnd="Basica";
            const jsonElement = jsonArrayMapColor.find(item => item.index.toString() === index.toString() && item.number.toString() === number.toString());
            if(jsonElement){
                valueEnd = jsonElement?.type.toString();
            }
            return valueEnd;
        }

        async function containerAddNumbersTypeCollection(event){
            typeCollection = document.getElementById("txtTypeCollection").value;
            const tbody = document.getElementById("container-selection-numbers-type-collection");
            tbody.innerHTML = "";

            let row = document.createElement("tr");
            row.innerHTML = `
                    <td>Rango:</td>
                    <td><select id="opRange"><option>Si</option><option>No</option></select</td>
                `;
            tbody.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                    <td><center><button onclick="containerAddNumbersTypeCollectionComplementary(event)">Add</button></center></td>
                `;
            tbody.appendChild(row);
        }

        async function containerAddNumbersTypeCollectionComplementary(event){
            const flagRange = document.getElementById("opRange").value;

            if(flagRange==='No'){
                countFieldNewType++;

                const tbody = document.getElementById("container-selection-numbers-type-collection");

                let row = document.createElement("tr");
                row.innerHTML = `
                    <td>Indica numero:</td>
                    <td><input type="text" id="txtNumberSelected_${countFieldNewType}"/></td>
                `;
                tbody.appendChild(row);
            }

        }

        function confirmationButtonByAddNumbersTypeCollections() {
            document.getElementById("container-confirmation-numbers-selection").innerHTML = `
                  <center><button onclick="containerSelectedColorTypeCollection();cleanTableType('container-selection-numbers-type-collection');cleanDiv('container-confirmation-numbers-selection')">Confirmar</button></center>
            `;
        }

        function containerSelectedColorTypeCollection() {
            let numberSelected;
            let arrayTempFieldNewType = [];
            let count = 0;
            let arrayNumber = [];
            const countNumbersAdded = arrayFieldNewType.length + 1;
            for (let i=countNumbersAdded; i<=countFieldNewType;i++){
                numberSelected = document.getElementById(`txtNumberSelected_${i}`).value.toString();
                if(numberSelected.toString().includes(",")){
                    arrayNumber = numberSelected.toString().split(",");
                    for(let j=0; j<arrayNumber.length;j++){
                        addElementArrayMapTypes(arrayNumber[j].toString(),typeCollection);
                        arrayTypes[i-1+j] = typeCollection;
                        arrayFieldNewType[i-1+j]=arrayNumber[j].toString();
                        arrayTempFieldNewType[count] = arrayNumber[j].toString();
                        count++;
                    }
                }else {
                    addElementArrayMapTypes(numberSelected,typeCollection);
                    arrayTypes[i-1] = typeCollection;
                    arrayFieldNewType[i-1]=numberSelected.toString();
                    arrayTempFieldNewType[count] = numberSelected.toString();
                    count++;
                }

            }

            let ultimosNumeros = {};
            for (let i = 0; i < arrayFieldTableAdditional.length; i++) {
                if(!indexes.includes(i) && arrayTempFieldNewType.includes(arrayFieldTableAdditional[i].toString())){
                    if(jsonArrayMapColor.some(obj => obj.number === arrayFieldTableAdditional[i].toString())){
                        const elementJson = jsonArrayMapColor.find(item => item.index.toString()===i.toString());
                        const indexVar = elementJson?.index;
                        if(indexVar!==i.toString()){
                            indexes.push(i);
                        }
                    }else{
                        ultimosNumeros[arrayFieldTableAdditional[i].toString()] = i;
                    }
                }
            }
            indexes.push(...Object.values(ultimosNumeros));

            if(arrayNumber.length>0){
                arrayNumber.forEach(x=> countFieldNewType++);
            }else{
                countFieldNewType++;
            }


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

        function isNumber(valor) {
            return !isNaN(valor) && valor.trim() !== "";
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
                <td><button type="button" onclick="formListNumericCollections(event);containerSelectionTypeCollection(event);containerAddTableAdditional()">Buscar</button></td>
            </tr>
        </table>
        <br/><br/>
        <table border="2">
            <thead>
            </thead>
            <tbody id="container-list-numbers-collection">
            </tbody>
        </table>
        <br>
        <div id="container-add-table-additional">
        </div>
        <br><br>
        <table border="2">
            <thead>
            </thead>
            <tbody id="container-add-news-items-collections">
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
