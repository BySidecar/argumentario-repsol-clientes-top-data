<%@ Page language="vb" %>


<head>
    <title>BySidecar</title>


</head>
<body></body></html>

<%
    Traces.Debug("--- Iniciando Bysidecar Llamadas: " + Gestion.Transaccion.IdTransaccion.ToString + " ---")
    Traces.Debug("IdTransaccion: " + Gestion.Transaccion.IdTransaccion.ToString +
         ", IdSujeto: " + Gestion.Cliente.IdSujeto.ToString +
         ", IdDocumento: " + Gestion.Transaccion.ContactoInicial.Document.IdDocument.ToString +
         ", ANI: " + Gestion.Transaccion.Ani + ", DNIS: " + Gestion.Transaccion.Dnis +
         ", Sentido (contacto): " + Gestion.Transaccion.SentidoContacto.ToString)

    If Gestion.Cliente.IdSujeto = 0 Then ' --- CLIENTE ANÓNIMO --- '
        Response.Redirect("Alta.aspx")
    Else ' --- CLIENTE EXISTENTE --- '
        Response.Redirect("Cliente.aspx")
    End If

%>