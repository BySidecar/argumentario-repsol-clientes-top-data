/*
* WebAgent JavaScript Library v1.2.0
*
* Copyright 2018, ICR Adventus
*/

function Deferred() {
    this._done = [];
    this._fail = [];
}
Deferred.prototype = {
    execute: function (list, args) {
        var i = list.length;

        // convert arguments to an array
        // so they can be sent to the
        // callbacks via the apply method
        args = Array.prototype.slice.call(args);

        while (i--) list[i].apply(null, args);
    },
    resolve: function () {
        /// <summary>It indicates that the function has been resolved correctly and the corresponding callbacks will run asynchronously.</summary>
        /// <param name="args..." type="Arguments">Callback function arguments</param>
        /// <returns type="Deferred"></returns>
        var DeferredObj = this;
        var ArgsObj = arguments;
        setTimeout(function () {
            DeferredObj.execute(DeferredObj._done, ArgsObj);
        }, 0);
        return this;
    },
    reject: function () {
        /// <summary>It indicates that the function has been finished with errors and the corresponding callbacks will run asynchronously.</summary>
        /// <param name="args..." type="Arguments">Callback function arguments</param>
        /// <returns type="Deferred"></returns>
        var DeferredObj = this;
        var ArgsObj = arguments;
        setTimeout(function () {
            DeferredObj.execute(DeferredObj._fail, ArgsObj);
        }, 0);
        return this;
    },
    done: function (callback) {
        /// <summary>Allows to define the method that is executed when the deferred completes successfully.</summary>
        /// <param name="callback" type="Function">Callback function.</param>
        /// <returns type="Deferred"></returns>
        this._done.push(callback);
        return this;
    },
    fail: function (callback) {
        /// <summary>Allows to define the method that is executed when the deferred completes with fail.</summary>
        /// <param name="callback" type="Function">Callback function.</param>
        /// <returns type="Deferred"></returns>
        this._fail.push(callback);
        return this;
    }
}

var EAgentApp = {
    EAP_IAGENT: 0,
    EAP_WEBAGENT: 1
};

var agentapi = new function () {

    function makeHttpRequest(sURL) {
        /// <summary>Realiza una petición http asincrona</summary>
        /// <param name="sURL" type="String">idTransaccion</param>
        /// <param name="resultFunc" type="Func">Función de resultado, nos van a pasar un objeto response y un objeto deferred.</param>
        /// <returns type="Deferred"></returns>

        if (!window.XMLHttpRequest) {
            throw new Error("XMLHttpRequest not suported by browser.");
        }

        var xmlhttp = new XMLHttpRequest();
        var deferred = new Deferred();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                try {
                    if (xmlhttp.status != 200)
                        throw new Error("Http status." + xmlhttp.status);

                    var response = JSON.parse(xmlhttp.responseText);
                    if (response.result)
                        deferred.resolve(response);
                    else
                        deferred.reject(response.code, response.cause);
                }
                catch (ex) {
                    deferred.reject(0, "[makeHttpRequest] {sURL=" + sURL + "}: " + ex.message);
                }
            }
        };

        xmlhttp.open("GET", sURL, true);
        xmlhttp.send();

        return deferred;
    }

    function iAgentScript() {
        /// <summary>Devuelve la instancia de iAgentScript</summary>
        /// <returns type="iagent.agentscript">ActiveXObject("iagent.agentscript")</returns>
        if (iagent == null)
            iagent = new ActiveXObject("iagent.agentscript");
        return iagent;
    }

    function webServiceActionURL(action, params) {
        /// <summary>Devuelve la url de una accion de webService para webAgent</summary>
        /// <param name="action" type="String">Acción</param>
        /// <param name="params" type="String">Parámetros en formato querystring de la petición.</param>
        /// <returns type="String">URL para la petición.</returns>
        return agentapi.WebAgentServiceUrl + action + "?token=" + agentapi.WebAgentAuthToken + "&" + params;
    }

    function executeAgentapiAction(iAgentCallBack, webAgentCallBack) {
        /// <summary>Ejecuta el callback correspondiente a iAgent o WebAgent según corresonda</summary>
        /// <param name="sURL" type="String">Acción</param>
        /// <param name="sURL" type="String">Parámetros en formato querystring de la petición.</param>
        /// <returns type="iagent.agentscript">ActiveXObject("iagent.agentscript")</returns>

        if (agentapi.AgentAppType == EAgentApp.EAP_WEBAGENT)  //webAgent
            webAgentCallBack();
        else //iAgent
            iAgentCallBack();

    }

    var iagent = null;

    /// <summary>
    /// Agent application type
    /// </summary>
    this.AgentAppType = "";

    /// <summary>
    /// WebAgent Authentication token
    /// </summary>
    this.WebAgentAuthToken = "";

    /// <summary>
    /// Base URL of WebAgent WebService 
    /// </summary>
    this.WebAgentServiceUrl = "";

    this.SetCustomer = function (transactionId, customerId) {
        /// <summary>Sets the customer of the transaction.</summary>
        /// <param name="transactionId" type="Number">transactionId</param>
        /// <param name="customerId" type="Number">customerId</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[SetCustomer] ";
        var deferred = new Deferred();

        try {
            if (transactionId == "" || transactionId == 0) {
                throw new Error(ErrMsgHead + "Invalid transactionId.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("SetCustomer", "transactionId=" + encodeURIComponent(transactionId) + "&customerId=" + encodeURIComponent(customerId)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().IdentificadoSujetoInterloc(transactionId, customerId) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.MakeCall = function (telNumber) {
        /// <summary>Makes a call.</summary>
        /// <param name="telNumber" type="Number">Number to call.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[MakeCall] ";
        var deferred = new Deferred();

        try {
            if (telNumber == "") {
                throw new Error(ErrMsgHead + " telNumber is empty.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("MakeCall", "telNumber=" + encodeURIComponent(telNumber)))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callid = iAgentScript().RealizarLlamada_js(telNumber);
                (callid >= 0) ? deferred.resolve(callid) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.MakeCampaignCall = function (transactionId) {
        /// <summary>Makes a campaign call.</summary>
        /// <param name="transactionId" type="Number">TransactionId.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[MakeCampaignCall] ";
        var deferred = new Deferred();

        try {
            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("MakeCampaignCall", "transactionId=" + transactionId))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callid = iAgentScript().RealizarLlamadaEnCampanya_js(transactionId);
                (callid >= 0) ? deferred.resolve(callid) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.MakeCampaignCallEx = function (transactionId, telNumber) {
        /// <summary>Makes a campaign call to the specified number.</summary>
        /// <param name="transactionId" type="Number">transactionId.</param>
        /// <param name="telNumber" type="Number">Number to call.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[MakeCampaignCallEx] ";
        var deferred = new Deferred();

        try {
            if (telNumber == "") {
                throw new Error(ErrMsgHead + " telNumber is empty.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("MakeCampaignCallEx", "transactionId=" + transactionId + "&telNumber=" + encodeURIComponent(telNumber)))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callid = iAgentScript().RealizarLlamadaEnCampanyaEx_js(transactionId, telNumber);
                (callid >= 0) ? deferred.resolve(callid) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.TransferActiveCall = function (telNumber) {
        /// <summary>Transfers the call to the specified number.</summary>
        /// <param name="telNumber" type="Number">Number to call.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[TransferActiveCall] ";
        var deferred = new Deferred();
        try {
            if (telNumber == "") {
                throw new Error(ErrMsgHead + " telNumber is empty.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("TransferActiveCall", "telNumber=" + encodeURIComponent(telNumber)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().TransferirLlamadaActiva(telNumber) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.HoldAndTransferActiveCall = function (telNumber) {
        /// <summary>Holds and transfers the call to the specified number.</summary>
        /// <param name="telNumber" type="Number">Number to call.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[HoldAndTransferActiveCall] ";
        var deferred = new Deferred();
        try {
            if (telNumber == "") {
                throw new Error(ErrMsgHead + " telNumber is empty.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("HoldAndTransferActiveCall", "telNumber=" + encodeURIComponent(telNumber)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().AparcarYTransferirLlamadaActiva(telNumber) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Hangup = function (callId) {
        /// <summary>Hangups the specified call.</summary>
        /// <param name="callId" type="Number">Id of the call to hangup.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Hangup] ";
        var deferred = new Deferred();

        try {
            if (callId < 0) {
                throw new Error(ErrMsgHead + " invalid callId.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("Hangup", "callId=" + encodeURIComponent(callId)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().ColgarLlamada(callId) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetCallsCount = function () {
        /// <summary>Get the current calls count.</summary>
        /// <returns type="Deferred"></returns>
        var ErrMsgHead = "[GetCallsCount] ";
        var deferred = new Deferred();

        try {
            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetCallsCount", ""))
                .done(function (response) {
                    deferred.resolve(response.callsCount);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var numLlamadasActuales = iAgentScript().ObtenerLlamadasActuales_js();
                numLlamadasActuales >= 0 ? deferred.resolve(numLlamadasActuales) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetActiveCall = function () {
        /// <summary>Gets the active call Id.</summary>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[GetActiveCall] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetActiveCall", ""))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var IdCall = iAgentScript().ObtenerLlamadaActiva_js()
                IdCall > 0 ? deferred.resolve(IdCall) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetCallId = function (index) {
        /// <summary>Gets the callId of the call in the specified index</summary>
        /// <param name="index" type="Number>Position of the call.</param>
        /// <returns type="Deferred"></returns>
        var ErrMsgHead = "[GetCallId] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetCallId", "index=" + index))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var IdCall = iAgentScript().ObtenerIdLlamada_js(index);
                IdCall > 0 ? deferred.resolve(IdCall) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetCallState = function (index) {
        /// <summary>Gets the state of the call in the specified index.</summary>
        /// <param name="index" type="Number">Position of the call.</param>
        /// <returns type="Deferred"></returns>
        var ErrMsgHead = "[GetCallState] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetCallState", "index=" + index))
                .done(function (response) {
                    deferred.resolve(response.callState);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callState = iAgentScript().ObtenerEstadoLlamada_js(index);
                callState > 0 ? deferred.resolve(callState) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetCalls = function () {
        /// <summary>Gets current calls collection.</summary>
        /// <returns type="Deferred"></returns>
        var ErrMsgHead = "[GetCalls] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetCalls", ""))
                .done(function (response) {
                    deferred.resolve(response.calls);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callState = iAgentScript().ObtenerEstadoLlamada_js(index);
                callState > 0 ? deferred.resolve(callState) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.CloseTransaction = function (idFinal, scheduleOn, scheduleOverTime, quotaIncrement) {
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[CloseTransaction] ";
        var deferred = new Deferred();

        try {
            function DateToString(d) {
                function pad(s) { return (s < 10) ? '0' + s : s; }
                // "yyyyMMddTHH:mm:ss"
                return [d.getFullYear(), pad(d.getMonth() + 1), pad(d.getDate())].join('') + "T" + [pad(d.getHours()), pad(d.getMinutes()), pad(d.getSeconds())].join(':');
            }

            if (typeof idFinal == 'undefined') {
                idFinal = 0;
            }

            if (scheduleOn != 'undefined' && scheduleOn instanceof Date) {
                scheduleOn = DateToString(scheduleOn);
            }
            else {
                scheduleOn = '01/01/2001 00:00:00';
            }

            if (typeof scheduleOverTime == 'undefined') {
                scheduleOverTime = 0;
            }

            if (typeof quotaIncrement == 'undefined') {
                quotaIncrement = 0;
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("CloseTransaction", "resolutionCodeId=" + String(idFinal) + "&scheduleOn=" + scheduleOn + "&scheduleOverTime=" + String(scheduleOverTime) + "&quotaIncrement=" + String(quotaIncrement)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().FinalGestion(idFinal, scheduleOn, scheduleOverTime, quotaIncrement) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Hold = function (callId) {
        /// <summary>Holds the specified call.</summary>
        /// <param name="callId" type="Number">Id of the call to hold.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Hold] ";
        var deferred = new Deferred();

        try {
            if (callId < 0) {
                throw new Error(ErrMsgHead + " invalid callid.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("Hold", "callId=" + encodeURIComponent(callId)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().AparcarLlamada(callId) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Retrieve = function (callId) {
        /// <summary>Retrieves the specified call.</summary>
        /// <param name="callId" type="Number">Id of the call to retireve.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Retrieve] ";
        var deferred = new Deferred();

        try {
            if (callId < 0) {
                throw new Error(ErrMsgHead + " invalid callId.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("Retrieve", "callId=" + encodeURIComponent(callId)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().RecuperarLlamada(callId) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Transfer = function (activeCallId, heldCallId) {
        /// <summary>Makes a transfer from the active call to the specified held call.</summary>
        /// <param name="activeCallId" type="Number">Id of the active call to transfer. (optional)</param>
        /// <param name="heldCallId" type="Number">Id of the held call to transfer. (optional)</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Transfer] ";
        var deferred = new Deferred();

        try {
            if (activeCallId < 0 || heldCallId < 0) {
                throw new Error(ErrMsgHead + " invalid CallId.");
            }

            var webAgentCallBack = function () {
                var queryStr = "";
                if (!(activeCallId == undefined || heldCallId == undefined))
                    queryStr = "activeCallId=" + encodeURIComponent(activeCallId) + "&heldCallId=" + encodeURIComponent(heldCallId);

                makeHttpRequest(webServiceActionURL("Transfer", queryStr))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callid = iAgentScript().TransferirLlamada_js(activeCallId, heldCallId);
                (callid != 0) ? deferred.resolve(callid) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Conference = function (activeCallId, heldCallId) {
        /// <summary>Makes a conference with the active call and the held call.</summary>
        /// <param name="activeCallId" type="Number">Id of the active call to add to the conference. (optional)</param>
        /// <param name="heldCallId" type="Number">Id of the held call to add to the conference. (optional)</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Conference] ";
        var deferred = new Deferred();

        try {
            if (activeCallId < 0 || heldCallId < 0) {
                throw new Error(ErrMsgHead + " invalid callID.");
            }

            var webAgentCallBack = function () {
                var queryStr = "";
                if (!(activeCallId == undefined || heldCallId == undefined))
                    queryStr = "activeCallId=" + encodeURIComponent(activeCallId) + "&heldCallId=" + encodeURIComponent(heldCallId);

                makeHttpRequest(webServiceActionURL("Conference", queryStr))
                .done(function (response) {
                    deferred.resolve(response.callId);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var callid = iAgentScript().ConferenciarLlamada_js(activeCallId, heldCallId);
                (callid != 0) ? deferred.resolve(callid) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.ConferenceActiveCall = function (telNumber) {
        /// <summary>Make a call to the specified number and adds the call to the conference.</summary>
        /// <param name="telNumber" type="Number">Number to call an add to the conference.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[ConferenceActiveCall] ";
        var deferred = new Deferred();
        try {
            if (telNumber == "") {
                throw new Error(ErrMsgHead + " telephone number.");
            }

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("ConferenceActiveCall", "telNumber=" + encodeURIComponent(telNumber)))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().ConferenciarLlamadaActiva(telNumber) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.StartRecording = function () {
        /// <summary>Starts recording.</summary>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[StartRecording] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("StartRecording", ""))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().IniciarGrabacion() ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.StopRecording = function () {
        /// <summary>Stops recording.</summary>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[StopRecording] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("StopRecording", ""))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().FinalizarGrabacion() ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.TagRecording = function (index, text) {
        /// <summary>Adds a tag to the current recording.</summary>
        /// <param name="index" type="Number">Tag position.</param>
        /// <param name="text" type="String">Tag text.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[TagRecording] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("TagRecording", "index=" + index + "&text=" + text))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().MarcarGrabacion(index, text) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetRecordingState = function () {
        /// <summary>Gets the recording state.</summary>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[GetRecordingState] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetRecordingState", ""))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().ObtenerEstadoGrabacion() ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.SendDTMF = function (callId, digits) {
        /// <summary>Sends the spcified digits as DTMF to the remote party.</summary>
        /// <param name="callId" type="Number">Id of the call to send the DTMF.</param>
        /// <param name="digits" type="Number">Digits to send.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[SendDTMF] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("SendDTMF", "callId=" + callId + "&digits=" + digits))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().SendDTMF(callId, digits) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.SetNotReady = function (breakReasonId) {
        /// <summary>Sets not ready state to agent with the specified breakReasonId.</summary>
        /// <param name="breakReasonId" type="Number">Break reason Id.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[SetNotReady] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("SetNotReady", "breakReasonId=" + breakReasonId))
                .done(function (response) {
                    deferred.resolve(response.eSEA);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var ret = iAgentScript().SolicitarPausa(breakReasonId);
                ret > 0 ? deferred.resolve(ret) : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Answer = function (callId) {
        /// <summary>Answers the specified call.</summary>
        /// <param name="callId" type="Number">CallId to answer.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Answer] ";
        var deferred = new Deferred();

        try {
            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("Answer", "callId=" + callId))
                .done(function (response) {
                    deferred.resolve(response.eSEA);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().ContestarLlamada(callId) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.FastTransferActiveCall = function (telNumber) {
        /// <summary>Makes a fast transfer to the specified number.</summary>
        /// <param name="telNumber" type="Number">Número al que redirigir.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[FastTransferActiveCall] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("FastTransferActiveCall", "telNumber=" + telNumber))
                .done(function (response) {
                    deferred.resolve(response.eSEA);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().RedirigirLlamadaActiva(telNumber) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetTransactionKeyValue = function (transactionId, key) {
        /// <summary>Get transaction key-value.</summary>
        /// <param name="transactionId" type="Number">Transaction Id.</param>
        /// <param name="key" type="String">Key.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[GetTransactionKeyValue] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("GetTransactionKeyValue", "transactionId=" + transactionId + "&key=" + key))
                .done(function (response) {
                    deferred.resolve(response.Value);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                var value = iAgentScript().ObtenerValorClave_js(transactionId, key);
                deferred.resolve(value);
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.SetTransactionKeyValue = function (transactionId, key, value) {
        /// <summary>Get transaction key-value.</summary>
        /// <param name="transactionId" type="Number">Transaction Id.</param>
        /// <param name="key" type="String">Key.</param>
        /// <param name="value" type="String">Key to set.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[SetTransactionKeyValue] ";
        var deferred = new Deferred();

        try {

            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("SetTransactionKeyValue", "transactionId=" + transactionId + "&key=" + key + "&value=" + value))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                iAgentScript().AsignarValorClave(transactionId, key, value) ? deferred.resolve() : deferred.reject(0, "");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.RequestInteraction = function () {
        /// <summary>Request next interaction in the queue.</summary>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[RequestInteraction] ";
        var deferred = new Deferred();
        try {
            var webAgentCallBack = function () {
                makeHttpRequest(webServiceActionURL("RequestInteraction", ""))
                .done(function (response) {
                    deferred.resolve();
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                throw new Error(ErrMsgHead + " not implemented.");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.GetCustomer = function (transactionId) {
        /// <summary>Gets the customer of the transaction.</summary>
        /// <param name="transactionId" type="Number">transactionId (Optional). Gets the current customer if not set.</param>
        /// <returns type="Deferred"></returns>
        var ErrMsgHead = "[GetCustomer] ";
        var deferred = new Deferred();

        try {
            if (transactionId == "" || transactionId == 0) {
                throw new Error(ErrMsgHead + "Invalid transactionId.");
            }

            var webAgentCallBack = function () {
                var query;

                if (transactionId == undefined)
                    query = "";
                else
                    query = "transactionId=" + encodeURIComponent(transactionId);

                makeHttpRequest(webServiceActionURL("GetCustomer", query))
                .done(function (response) {
                    deferred.resolve(response.Customer);
                })
                .fail(function (code, text) {
                    deferred.reject(code, text);
                });
            }

            var iAgentCallBack = function () {
                throw new Error(ErrMsgHead + " not implemented.");
            }

            executeAgentapiAction(iAgentCallBack, webAgentCallBack);
        }
        catch (ex) {
            var message = ErrMsgHead + ex.name + " " + ex.message;
            if (window.console) console.log(message);
            deferred.reject(0, message);
        }

        return deferred;
    }

    this.Wait4CallState = function (callId, callState) {
        /// <summary>Waits for specified callState or end of call.</summary>
        /// <param name="callId" type="Number">CallId to check.</param>
        /// <param name="callState" type="Number">CallState to wait for.</param>
        /// <returns type="Deferred"></returns>

        var ErrMsgHead = "[Wait4CallState] ";
        var MaxFails = 5;
        var tInterval = 200;

        var deferred = new Deferred();

        var OnFailedFunc = function (fails, code, text) {
            if (fails++ > MaxFails)
                deferred.reject(code, text); //Lo marcamos como fallido (no se ha adquirido el estado esperado)
            else
                setTimeout(w4CallStateFunc(fails++), tInterval); //Si no hemos llegado a MaxFails lo checkeamos mas tarde
        };

        var w4CallStateFunc = function (failsCount) {

            this.GetCallsCount()
            .done(function (count) {
                var w4CallStateInnerfunc = function (index, count, checkFunc) {
                    this.GetCallId(index)
                    .done(function (obtainedCallId) {
                        if (index == count) {
                            OnFailedFunc(failsCount, 0, "GetCallId::Callid " + callId + " not found");
                        }
                        else if (obtainedCallId == callid) {
                            this.GetCallState(index)
                            .done(function (obtainedCallState) {
                                if (obtainedCallState == callState)
                                    deferred.resolve(); //la llamada alcanzo el estado deseado
                                else
                                    setTimeout(w4CallStateFunc(0), tInterval); //reseteamos contador de fallos y continuamos
                            })
                            .fail(function (code, text) {
                                OnFailedFunc(failsCount, code, text);
                            });
                        }
                        else {
                            checkFunc(index++, count, checkFunc); //Continuamos bucle recursivo
                        }
                    }).fail(function (code, text) {
                        OnFailedFunc(failsCount, code, text);
                    });
                };

                w4CallStateInnerfunc(0, count, w4CallStateInnerfunc);

            }).fail(function (code, text) {
                deferred.reject(code, text);
            });
        };

        w4CallStateFunc(0);

        return deferred;
    }


};


var agentapi_105 = new function () {

    this.IdentificadoSujetoInterloc = function (idSujeto, idTransaccion) {
        /// <summary>Identifica un sujeto en una transacción.</summary>
        /// <param name="idTransaccion" type="Number">idTransaccion</param>
        /// <param name="idSujeto" type="Number">idSujeto</param>
        /// <returns type="Deferred"></returns>
        return agentapi.SetCustomer(idSujeto, idTransaccion);
    }

    this.RealizarLlamada = function (sNumTel) {
        /// <summary>Realiza una llamada.</summary>
        /// <param name="sNumTel" type="Number">Número de teléfono a llamar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.MakeCall(sNumTel);
    }

    this.RealizarLlamadaEnCampanya = function (idTransaction) {
        /// <summary>Realiza una llamada vinculada a la transacción al telefono correspondiente al registro actual.</summary>
        /// <param name="idTransaction" type="Number">Transacción de la gestión.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.MakeCampaignCall(idTransaction);
    }

    this.RealizarLlamadaEnCampanyaEx = function (idTransaction, sNumTel) {
        /// <summary>Realiza una llamada vinculada a la transacción al telefono indicado.</summary>
        /// <param name="idTransaction" type="Number">Transacción de la gestión.</param>
        /// <param name="sNumTel" type="Number">Número de teléfono a llamar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.MakeCampaignCallEx(idTransaction, sNumTel);
    }

    this.TransferirLlamadaActiva = function (sNumTel) {
        /// <summary>Transfiere la llamada activa al número indicado.</summary>
        /// <param name="sNumTel" type="Number">Número de teléfono receptor de la transferencia.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.TransferActiveCall(sNumTel);
    }

    this.AparcarYTransferirLlamadaActiva = function (sNumTel) {
        /// <summary>Transfiere la llamada activa al número indicado, aparcando la llamada previemente.</summary>
        /// <param name="sNumTel" type="Number">Número de teléfono receptor de la transferencia.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.HoldAndTransferActiveCall(sNumTel);
    }

    this.ColgarLlamada = function (idCall) {
        /// <summary>Cuelga la llamada indicada.</summary>
        /// <param name="idCall" type="Number">Id de la llamada a colgar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Hangup(idCall);
    }

    this.ObtenerLlamadasActuales = function () {
        /// <summary>Obtiene el número de llamadas en curso.</summary>
        /// <returns type="Deferred"></returns>
        return agentapi.GetCallsCount();
    }

    this.ObtenerLlamadaActiva = function () {
        /// <summary>Obtiene el identificador de la campaña activa.</summary>
        /// <returns type="Deferred"></returns>
        return agentapi.GetActiveCall();
    }

    this.ObtenerIdLlamada = function (index) {
        /// <summary>Obtiene el identificador de la llamada correspondiente a la posición indicada por index.</summary>
        /// <param name="index" type="Number">Posición de la llamada.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.GetCallId(index);
    }

    this.ObtenerEstadoLlamada = function (index) {
        /// <summary>Obtiene el estado de la llamada correspondiente a la posición indicada por index.</summary>
        /// <param name="index" type="Number">Posición de la llamada.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.GetCallState(index);
    }

    this.AparcarLlamada = function (idCall) {
        /// <summary>Aparca la llamada indicada.</summary>
        /// <param name="idCall" type="Number">Id de la llamada a aparcar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Hold(idCall);
    }

    this.RecuperarLlamada = function (idCall) {
        /// <summary>Recupera la llamada indicada.</summary>
        /// <param name="idCall" type="Number">Id de la llamada a recuperar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Retrieve(idCall);
    }

    this.TransferirLlamada = function (idActiveCall, idHeldcall) {
        /// <summary>Transfiere la llamada activa con la aparcada indicada.</summary>
        /// <param name="idActiveCall" type="Number">Id de la llamada a transferir.</param>
        /// <param name="idHeldcall" type="Number">Id de la llamada aparcada receptora de la transferencia.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Transfer(idActiveCall, idHeldcall);
    }

    this.ConferenciarLlamada = function (idActiveCall, idHeldcall) {
        /// <summary>Realiza una conference con los interlocutores de las llamadas activa y aparcada.</summary>
        /// <param name="idActiveCall" type="Number">Id de la llamada activa a conferenciar.</param>
        /// <param name="idHeldcall" type="Number">Id de la llamada aparcada a conferenciar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Conference(idActiveCall, idHeldcall);
    }

    this.ConferenciarLlamadaActiva = function (sNumTel) {
        /// <summary>Ponse la llamada en conferencia con la llamada activa y el número indicado.</summary>
        /// <param name="sNumTel" type="Number">Número de teléfono con el cual realizar la conferencia.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.ConferenceActiveCall(sNumTel);
    }

    this.IniciarGrabacion = function () {
        /// <summary>Inicia la grabación de la llamada.</summary>
        /// <returns type="Deferred"></returns>
        return agentapi.StartRecording();
    }

    this.FinalizarGrabacion = function () {
        /// <summary>Finaliza la grabación de la llamada.</summary>
        /// <returns type="Deferred"></returns>
        return agentapi.StopRecording();
    }

    this.MarcarGrabacion = function (index, texto) {
        /// <summary>Marcar la grabación de la llamada.</summary>
        /// <param name="index" type="Number">Posición de la marca.</param>
        /// <param name="texto" type="String">Texto de la marca.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.TagRecording(index, texto);
    }

    this.ObtenerEstadoGrabacion = function () {
        /// <summary>Marcar la grabación de la llamada.</summary>
        /// <returns type="Deferred"></returns>
        return agentapi.GetRecordingState();
    }

    this.SendDTMF = function (idCall, digits) {
        /// <summary>Envía DTMF a la llamada correspondiente.</summary>
        /// <param name="idCall" type="Number">Id de la llamada a enviar DTMF.</param>
        /// <param name="digits" type="Number">Dígitos a enviar por DTMF.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.SendDTMF(idCall, digits);
    }

    this.SolicitarPausa = function (idMotivoPausa) {
        /// <summary>Solicita pausa con el idMotivoPausa indicado.</summary>
        /// <param name="IdMotivoPausa" type="Number">Id de la llamada a enviar DTMF.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.SetNotReady(idMotivoPausa);
    }

    this.ContestarLlamada = function (idCall) {
        /// <summary>Contesta la llamada indicada.</summary>
        /// <param name="idCall" type="Number">Id de la llamada a contestar.</param>
        /// <returns type="Deferred"></returns>
        return agentapi.Answer(idCall);
    }

    this.RedirigirLlamadaActiva = function (sNumtel) {
        /// <summary>Redirige la llamada activa al número de teléfno indicado.</summary>
        /// <param name="sNumtel" type="Number">Número al que redirigir</param>
        /// <returns type="Deferred"></returns>
        return agentapi.FastTransfer(sNumtel);
    }
};