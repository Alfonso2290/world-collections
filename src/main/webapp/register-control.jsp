<%
    String requestId = request.getParameter("id");
%>
<html>
<head>
    <script>

        /**
         * Pendiente:
         *
         * CASO PINTAR CELDAS
         * ------------------
         * CASO 1:
         * Las letras tbn deben aplicarse la logica del CASO 1 Y 2 ..ES DECIR, PUEDO TENER MAS DE 1 LETRA IGUAL (A,A,A)
         *
         *
         * CASO 4:
         * Las letras añadidas actualmente no permiten la Ñ, adaptar para que si se pueda usar
         *
         * */
        let countFieldNewType = 1;
        let typeCollection = null;
        let arrayMapColor = new Map(); //Contiene {"12":"Rojo","14":"Rojo","23":"Azul"}
        let jsonArrayMapColor = []; //Contiene [{number:"12", color:"Rojo", index:"1" },{number:"14", color:"Azul", index:"12" }]
        let arrayFieldNewType = []; //Contiene los numeros que voy agregando en boton Add
        let indexes = []; //Contiene indices a agregar {101,102,160,161}
        let arrayMapTypes = new Map(); //Contiene {"12":"Especial lluvia","14":"Especial lluvia","23":"Especial vidrio"}
        let arrayFieldTableAdditional = []; //Contiene todos los numeros de la coleccion

        function addElementArrayMapColor(number, color, index) {
            jsonArrayMapColor.push({
                number: number,
                color: color,
                index: index
            });
        }

        async function formListNumericCollections(event) {
            event.preventDefault();

            if(document.getElementById("opColorCell")!==null){
                const colorCell=document.getElementById("opColorCell").value;

                //size=2 => i=2, 3, 4, 5
                //alert("Inicio for: " + arrayMapColor.size);
                //alert("Fin de for: " + countFieldNewType-1);
                //<5
                for(let i=arrayMapColor.size;i<countFieldNewType-1;i++){
                    arrayMapColor.set(arrayFieldNewType[i],colorCell);
                    /*alert(arrayFieldNewType[i].toString());
                    alert(colorCell.toString());
                    alert(indexes[i].toString());*/
                    //alert("Iterador: (" + i + "): " + arrayFieldNewType[i].toString());
                    //alert("Indexes valores: " + indexes[i].toString());
                    addElementArrayMapColor(arrayFieldNewType[i].toString(), colorCell.toString(), indexes[i].toString());
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

            for(let i = arrayFieldTableAdditional.length; i < arraySize + (endNumberAcronym - initNumberAcronym) + 1; i++ ){
                if(acronym === 'Letra'){
                    arrayFieldTableAdditional[i] = String.fromCharCode((i - arraySize) + initNumberAcronym + 64);
                }else if(acronym === 'Numero') {
                    arrayFieldTableAdditional[i] = i - arraySize + initNumberAcronym;
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

                if (arrayFieldNewType != null /*&& arrayFieldNewType.includes(arrayFieldTableAdditional[i].toString())*/
                    /*&& arrayTemp.lastIndexOf(arrayFieldTableAdditional[i].toString()) === i*/) {


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

            arrayFieldTableAdditional.forEach(control => {
                console.log("CONTROL =", control);
                console.log("TYPE =", getNumberSelected(control));
                console.log("MAP =", arrayMapTypes);
                let typeByNumber = getNumberSelected(control);
                const bodyElement = {
                    type: typeByNumber,
                    numeration:control,
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
                const text = await response.text(); // leer error del backend si existe
                alert("Error del servidor (status " + response.status + "): " + text);
            }
        }

        function getNumberSelected(number){
            let valueEnd="Basica";
            for (let [key, value] of arrayMapTypes.entries()) {
                if(key.toString() === number){
                    valueEnd = value;
                }
            }
            return valueEnd;
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
            let arrayTempFieldNewType = [];
            let count = 0;
            const countNumbersAdded = arrayFieldNewType.length + 1;
            for (let i=countNumbersAdded; i<=countFieldNewType;i++){
                numberSelected = document.getElementById(`txtNumberSelected_${i}`).value.toString();//este parse
                arrayMapTypes.set(numberSelected,typeCollection);
                arrayFieldNewType[i-1]=numberSelected.toString();
                arrayTempFieldNewType[count] = numberSelected.toString();
                count++;

            }

            let ultimosNumeros = {};
            for (let i = 0; i < arrayFieldTableAdditional.length; i++) {

                for (let j = 0; j < arrayFieldNewType.length; j++){

                    if(arrayFieldTableAdditional[i].toString() === arrayFieldNewType[j].toString() && !indexes.includes(i) && arrayTempFieldNewType.includes(arrayFieldTableAdditional[i].toString())){
                        const count = arrayFieldTableAdditional.filter(x => x.toString() === arrayFieldTableAdditional[i].toString()).length;
                        //alert("Cantidad de " + arrayFieldTableAdditional[i].toString() + ": " + count);
                        if(isNumber(arrayFieldTableAdditional[i].toString())){
                            //alert("Ingresa a numero: (" + i + ")-> " + arrayFieldTableAdditional[i].toString());
                            //ultimosNumeros[arrayFieldTableAdditional[i].toString()] = i;
                            if(jsonArrayMapColor.some(obj => obj.number === arrayFieldTableAdditional[i].toString())){
                                const elementJson = jsonArrayMapColor.find(item => item.index.toString()===i.toString());
                                const indexVar = elementJson?.index;
                                if(indexVar!==i.toString()){
                                    indexes.push(i);
                                }
                            }else{
                                ultimosNumeros[arrayFieldTableAdditional[i].toString()] = i;
                            }
                        }else{
                            indexes.push(i);
                        }
                    }
                }
            }
            //alert("antes de agregar numero");
            //indexes.forEach(x => alert("Index: " + x));
            indexes.push(...Object.values(ultimosNumeros));
            //alert("luego de agregar numero");
            //indexes.forEach(x => alert("Index: " + x));
            //alert(indexes);

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
