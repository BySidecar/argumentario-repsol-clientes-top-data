/*
* iAgent JavaScript Library v1.0.0
*
* Copyright 2010, ICR Adventus
*/

var iAgent = new function () {


    var iagent;

    try {
        iagent = new ActiveXObject("iagent.agentscript");

    }
    catch (e) {
        alert("[CreateAgentObject] " + e);
        iagent = null;
    }


    /***************************************************************
    *	Identifica un sujeto en una transacción
    *	\param idTransaccion
    *	\param idSujeto
    ***************************************************************/
    this.SujetoIdentificado = function (idSujeto, idTransaccion) {

        var ErrMsgHead = "[SujetoIdentificado] ";

        if (iagent == null) {
            alert(ErrMsgHead + "El objeto ActiveX iAgent no existe.");
            return false;
        }
        if (idTransaccion == "" || idTransaccion == 0) {
            alert(ErrMsgHead + "El campo idTransaccion no es válido.");
            return false;
        }

        try {
            return (iagent.IdentificadoSujetoInterloc(idTransaccion, idSujeto));
        } catch (e) {
            alert(ErrMsgHead + e.name + " " + e.message);
        }
        return false;
    }



    /***************************************************************
    *	Finaliza la gestion
    *	\param IdFinal
    *	\param FechaReplanificacion
    *	\param Intervalo
    *	\param Cuota
    ***************************************************************/
    this.FinalGestion = function (IdFinal, FechaReplanificacion, Intervalo, Cuota) {

        var ErrMsgHead = "[FinalGestion] ";

        try {
            return (iagent.FinalGestion(IdFinal, FechaReplanificacion, Intervalo, Cuota));
        }
        catch (e) {
            alert(ErrMsgHead + e.name + " " + e.message);
        }
        return false;
    }



    /***************************************************************
    *	Muestra los localizadores
    *	\param bShow
    ***************************************************************/
    this.MostrarLocalizadores = function (bShow) {

        var ErrMsgHead = "[MostrarLocalizadores] ";

        try {
            if (iagent.MostrarLocalizadores(bShow)) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (e) {
            alert(ErrMsgHead + e.name + " " + e.message);
        }
        return false;
    }

    /***************************************************************
    *	Muestra los históricos
    *	\param bShow
    ***************************************************************/
    this.MostrarHistoricos = function (bShow) {

        var ErrMsgHead = "[MostrarHistoricos] ";

        try {
            if (iagent.MostrarHistoricos(bShow)) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (e) {
            alert(ErrMsgHead + e.name + " " + e.message);
        }
        return false;
    }


    /***************************************************************
    *	Muestra las participaciones
    *	\param bShow
    ***************************************************************/
    this.MostrarParticipaciones = function (bShow) {

        var ErrMsgHead = "[MostrarParticipaciones] ";

        try {
            // this is not implemented in iagent v8 and will fail...
            if (iagent.MostrarParticipaciones(true)) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (e) {
            alert(ErrMsgHead + e.name + " " + e.message);
        }
        return false;
    }


}
