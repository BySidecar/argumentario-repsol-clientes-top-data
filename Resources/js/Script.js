

// ------------------------ //
// --- Realizar llamada --- //
// ------------------------ //

function Llamar() {

    var Telefono = $('#ctl00_MainContent_TELEFONOS').val();

    if (Telefono == undefined) { console.log("No hay telefono al que llamar"); return; }
    else { console.log("Llamando al teléfono " + Telefono); }    
       
    agentapi.MakeCall(Telefono)
        .done(function () {
            console.log("Llamada enrutada correctamente al teléfono " + Telefono);
        })
        .fail(function () {
            if (code == 0) {
                alert('Ha ocurrido un error al intentar llamar al teléfono `' + Telefono + '`');
            }
            else {
                alert('Ha ocurrido un error al intentar llamar al teléfono `' + Telefono + '`. MakeCall falló. Code:' + code + '. Cause:' + cause);
            }
        });
}

function LlamarV1(idTransaccion) {

    var Telefono = $('#ctl00_MainContent_TELEFONOS').val();
    console.log("Llamando al teléfono " + Telefono + " en la transaccion " + idTransaccion);

    agentapi.MakeCampaignCallEx(idTransaccion,Telefono)
        .done(function () {
            console.log("Llamada enrutada correctamente al teléfono " + Telefono);
        })
        .fail(function () {
            if (code == 0) {
                alert('Ha ocurrido un error al intentar llamar al teléfono `' + Telefono + '`');
            }
            else {
                alert('Ha ocurrido un error al intentar llamar al teléfono `' + Telefono + '`. MakeCampaignCallEx falló. Code:' + code + '. Cause:' + cause);
            }
        });
}

// ----------------------------- //
// --- Finalizar transaccion --- //
// ----------------------------- //

function CerrarTransaccion(idTransaction, final) {

    agentapi.CloseTransaction(final, '', '0', 0)
        .done(function () {
            console.log('Transacción ' + idTransaction + ' cerrada con final ' + final);
            return true;
        })
        .fail(function (code, cause) {
            if (code == 0) {
                alert('¡Ha ocurrido un error al finalizar la transacción!');
            }
            else {
                alert('CloseTransaction falló. Code:' + code + '. Cause:' + cause);
            }
            return false;
        });
}


// ----------------- //
// --- Funciones --- //
// ----------------- //
function getRequest(URL, callback) {
    console.log("getRequest() -> " + URL);
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            console.log("getRequest() Response: " + xmlHttp.responseText);
            callback(xmlHttp.responseText);
        }
    }
    xmlHttp.open("GET", URL, true);
    xmlHttp.send(null);
}

// --------------------------- //
// --- Identificar cliente --- //
// --------------------------- //

function asociar(IdTransaccion, IdSujeto) {

    agentapi.SetCustomer(IdTransaccion, IdSujeto)
                .done(function (response) {
                    location.href = ('Cliente.aspx');
                })
                .fail(function (code, cause) {
                    alert('SetCustomer falló. Code:' + code + '. Cause:' + cause);
                    location.href = ('Alta.aspx');
                });

}

// ------------------------- //
// --- Eventos de inicio --- //
// ------------------------- //
$(document).ready(function () {
    
});