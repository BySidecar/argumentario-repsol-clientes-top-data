<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="Site.Master" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="System.Net" %>

<%@ Import Namespace="System.Net.Mail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

   
<header class="main-header"></header>

<div class="content container">

    <div class="row">

        <!-- Listado de clientes -->
        <div class="col-md-12">
            <div class="box box-info">                
                <div class="box-header with-border">
                    <h3 class="box-title">Buscar un Cliente</h3>
                </div>
                <div class="box-body">

                    <div class="row">
                    <div class="col-md-4"><!-- Asignado a-- -->
                        <div class="form-group">                               
                            <label>Asignado A:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fas fa-arrows-alt-h"></i></span>
                                <asp:DropDownList ID="AsignadoA" runat="server" CssClass="form-control">
                                    
                                    <asp:ListItem Value="Todos" Text="Todos" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="Agente" Text="Agente"></asp:ListItem>
                                    

                                </asp:DropDownList>
                            </div>                           
                        </div>
                    </div>

                        
                        <div class="col-md-3"><!-- ID CLIENTE -->
		                    <div class="form-group">                                
			                    <label>Id de Cliente</label>
                                <div class="input-group">
				                    <span class="input-group-addon">#</span>
				                    <asp:TextBox ID="Idcliente" runat="server" placeholder="Id Cliente" CssClass="form-control"></asp:TextBox>
			                    </div>			                                                       
		                    </div>
	                    </div>
	                    <div class="col-md-4"><!-- NOMBRE -->
		                    <div class="form-group">
			                    <label>Nombre</label>                              
			                    <asp:TextBox ID="BUSCAR_NOMBRE" runat="server" placeholder="Nombre" CssClass="form-control"></asp:TextBox>
		                    </div>
	                    </div>
	                    
	                    <div class="col-md-4"><!-- TELF -->
		                    <div class="form-group">                                
			                    <label>Teléfono</label>
			                    <div class="input-group">
				                    <span class="input-group-addon"><i class="fa fa-phone telefono"¡"></i></span>
				                    <asp:TextBox ID="BUSCAR_TELEFONO" runat="server" placeholder="Teléfono" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
			                    </div>   
                            </div>
                        </div>
                        <div class="col-md-4"><!-- EMAIL -->
		                    <div class="form-group">                                
			                    <label>Email</label>
			                    <div class="input-group">
				                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
				                    <asp:TextBox ID="BUSCAR_EMAIL" runat="server" placeholder="Email" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
			                    </div>                                
		                    </div>
	                    </div>
                        <div class="col-md-4"><!-- Localidad -->
		                    <div class="form-group">                                
			                    <label>DNI</label>
			                    <div class="input-group">
				                    <span class="input-group-addon"><i class="fas fa-card"></i></span>
				                    <asp:TextBox ID="BUSCAR_DNI" runat="server" placeholder="DNI" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
			                    </div>                                
		                    </div>
	                    </div>
                        
                        <div class="col-md-12 text-right">
                            <asp:Button ID="btBuscar" runat="server" Text="Buscar" 
                                CssClass="btn btn-primary" onclick="btBuscar_Click" />
                        </div>
                        <div class="w-100"><p>&nbsp;</p></div>
                        <!-- GRID -->
                        <div class="col-md-12">
                            <asp:GridView ID="GridViewIdentificar" runat="server" DataSourceID="SqlDSAlta" 
                                DataKeyNames="idsujeto" AutoGenerateColumns="False" 
                                onselectedindexchanged="GridViewIdentificar_SelectedIndexChanged" CssClass="table table-bordered table-hover dataTable" CellSpacing="5" AllowPaging="False">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="true" />
                                    <asp:BoundField DataField="idsujeto" HeaderText="ID WCCX" Visible="false" />
                                    <asp:BoundField DataField="Marca" HeaderText="Id Cliente" /> 
                                    <asp:BoundField DataField="Centro" HeaderText="Nombre" />
                                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                                    <asp:BoundField DataField="Poblacion" HeaderText="Población" />
                                    <asp:BoundField DataField="Telefono1" HeaderText="Telefono1" />
                                    <asp:BoundField DataField="Telefono2" HeaderText="Telefono2" />
                                    <asp:BoundField DataField="Agente_Asignado" HeaderText="Agente_Asignado" />
                                    <asp:BoundField DataField="Proximo_Contacto" HeaderText="Proximo_Contacto" />
                                </Columns>

                                <EmptyDataTemplate>
                                    <asp:Label ID="GridViewVacio" runat="server" Text='No se han encontrado resultados.'></asp:Label>
                                </EmptyDataTemplate>
                            </asp:GridView>

                            <asp:SqlDataSource
                                id="SqlDSAlta"
                                runat="server"
                                DataSourceMode="DataReader"
                                ConnectionString="<%$ ConnectionStrings:connectionstring %>"
                                SelectCommand=""
                                ProviderName="<%$ ConnectionStrings:connectionstring.ProviderName %>">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Alta -->
        <div class="col-md-12">
            <div class="box box-info">                
                <div class="box-header with-border">
                    <h3 class="box-title">Alta nuevo cliente</h3>
                </div>
                <div class="box-body">                
                    <div class="row">
                        <div class="col-md-2"><!-- COD -- NUM1 -- -->
		                    <div class="form-group">                                
			                    <label>DNI</label>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fas fa-id-card"></i></span>  
                                    <asp:TextBox ID="ALTA_DNI" runat="server" placeholder="DNI" CssClass="form-control"></asp:TextBox>                     
                                </div>                            
		                    </div>
	                    </div>

	                    <div class="col-md-4"><!-- NOMFIS -- EMPRESA -->
		                    <div class="form-group">
			                    <label>Nombre&nbsp; </label>
                                <asp:TextBox ID="ALTA_NOMBRE" runat="server" placeholder="Nombre" CssClass="form-control"></asp:TextBox>
		                    </div>
	                    </div>

                        <div class="col-md-4"><!-- TELEFONO -->
		                    <div class="form-group">                                
			                    <label>Teléfono</label>
			                    <div class="input-group">
				                    <span class="input-group-addon"><i class="fa fa-phone telefono" ></i></span>
				                    <asp:TextBox ID="ALTA_TELEFONO" runat="server" placeholder="Teléfono" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfTelefono" runat="server" ErrorMessage="Debe incluir un número de teléfono válido para continuar con el alta del registro" ValidationGroup="Validar_telefono" ControlToValidate="ALTA_TELEFONO"></asp:RequiredFieldValidator>
			                    </div>                                
		                    </div>
	                    </div>
	                    	                    
                            
                        <div class="col-md-8"><!-- EMAIL -->
		                    <div class="form-group">                                
			                    <label>Email</label>
			                    <div class="input-group">
				                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
				                    <asp:TextBox ID="ALTA_EMAIL" runat="server" placeholder="Email" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
			                    </div>                                
		                    </div>
	                    </div>

                    </div>
                
                    <div class="col-md-12 text-right">
                        <asp:Button ID="btAlta" runat="server" Text="Alta" CssClass="btn btn-success" 
                            onclick="btAlta_Click" causesvalidation="true" ValidationGroup="Validar_telefono" />
                    </div>
                </div> 
            </div>

        </div>
    </div>


</div>


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">

</asp:Content>

<script runat="server">
   
    Dim strConnEvo As String = "DRIVER={SQL Server};SERVER=10.100.1.211\EVOLUTION;UID=sa;PWD=wGu3Pq2y86In;DATABASE=EVOLUTIONDB;"
    Dim strConnEvoDoc As String = "DRIVER={SQL Server};SERVER=10.100.1.211\EVOLUTION;UID=sa;PWD=wGu3Pq2y86In;DATABASE=EVOLUTIONDBDOC;"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then ' Primera carga

        Else
            CargarGrid() ' Generar Grid
            Traces.Debug("Page_Load por PostBack")
        End If



    End Sub

    Private Sub CargarGrid()

        Dim sSql As String = ""
        Dim sCriterios As String = ""
        Dim iCriterios As Integer = 0
        
        sSql = "select "
        If Not Me.AsignadoA.SelectedValue = "Agente" Then
            sSql = sSql + " top 10 "
        End If
        
        sSql = sSql + " c.idsujeto, IDORIGINAL as 'Marca', CONCAT(C.NOMBRE,' ', C.APELLIDO1) as 'Centro', DIRECCION  as 'Direccion', Poblacion as 'Poblacion', "
        sSql = sSql + " C.Telefono as 'Telefono1',"
        sSql = sSql + " (select Localizador from tbLocalizador where idSujeto = C.idsujeto and nOrden = 0) as 'Telefono2', "
        sSql = sSql + " CONCAT(u.NOMBRE,' ', u.APELLIDO1) as 'Agente_Asignado',isc.TPROXIMOCONTACTO as 'Proximo_Contacto' "
        sSql = sSql + " from clientes c inner join tbIdentidadSujetoCampanya isc on c.IDSUJETO = isc.IDSUJETO "
        sSql = sSql + " inner join USUARIO u on isc.IDAGENTEASIGNADO = u.IDUSUARIO "
        sSql = sSql + " where c.IDSUJETO != 0 and isc.nEstado = 0 and isc.TPROXIMOCONTACTO >= getdate() "
           
        sSql = sSql + " and isc.idcampanya = " + Gestion.Campanya.IdCampanya.ToString()
              
        If Not String.IsNullOrWhiteSpace(Me.Idcliente.Text) Then
            sSql = sSql + " AND IDORIGINAL LIKE '%" + Me.Idcliente.Text + "%'"
        End If

        If Not String.IsNullOrWhiteSpace(Me.BUSCAR_NOMBRE.Text) Then
            sSql = sSql + " AND sNombreCompleto LIKE '%" + Me.BUSCAR_NOMBRE.Text + "%'"
        End If

        If Not String.IsNullOrWhiteSpace(Me.BUSCAR_DNI.Text) Then
            sSql = sSql + " AND sDNI LIKE '%" + Me.BUSCAR_DNI.Text + "%'"
        End If

        If Not String.IsNullOrWhiteSpace(Me.BUSCAR_EMAIL.Text) Then
            sSql = sSql + " AND (EMAIL like '%" + Me.BUSCAR_EMAIL.Text + "%' or EMAIL2 like '%" + Me.BUSCAR_EMAIL.Text + "%' or c.Texto1 like '%" + Me.BUSCAR_EMAIL.Text + "%')"
        End If

        If Not String.IsNullOrWhiteSpace(Me.BUSCAR_TELEFONO.Text) Then
            
            sSql = sSql + " and c.IDSUJETO in (SELECT c.idsujeto FROM clientes C JOIN tbidentidadsujetocampanya ISC on C.idsujeto=ISC.idsujeto  "
            sSql = sSql + " WHERE (ISC.IDCAMPANYA = " + Gestion.Campanya.IdCampanya.ToString() + " And c.idsujeto > 0) AND (telefono='" + Me.BUSCAR_TELEFONO.Text + "' "
            sSql = sSql + " OR TELEFONO2='" + Me.BUSCAR_TELEFONO.Text + "' OR MOVIL='" + Me.BUSCAR_TELEFONO.Text + "' OR movil2='" + Me.BUSCAR_TELEFONO.Text + "' OR "
            sSql = sSql + " EXISTS ((SELECT IDSUJETO FROM dbo.tbLocalizador AS L WHERE(C.idSujeto = L.idSujeto) AND L.Localizador = '" + Me.BUSCAR_TELEFONO.Text + "'))))" 
        End If
        
        If Me.AsignadoA.SelectedValue = "Agente" Then
            sSql = sSql + " AND isc.IDAGENTEASIGNADO = " + Gestion.Agente.IdAgente.ToString
        End If



        Traces.Debug("Registros Identificar: " + sSql)

        SqlDSAlta.SelectCommand = sSql
        Me.GridViewIdentificar.DataBind() 'Cargamos datos en el Grid

    End Sub

    Protected Sub btAlta_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim sNombre As String = "Nombre", sApellido1 As String = "Apellido1", num1 As String = "", sTelefono As String = "", sDNI As String = "", Email As String = "", Apellido2 As String = "Apellido2", Contacto As String = ""
        Dim IdSujeto As Long

        ' Bindear
        If Not String.IsNullOrWhiteSpace(Me.ALTA_DNI.Text) Then sDNI = Me.ALTA_DNI.Text
        If Not String.IsNullOrWhiteSpace(Me.ALTA_NOMBRE.Text) Then sNombre = Me.ALTA_NOMBRE.Text
        If Not String.IsNullOrWhiteSpace(Me.ALTA_TELEFONO.Text) Then sTelefono = Me.ALTA_TELEFONO.Text
        If Not String.IsNullOrWhiteSpace(Me.ALTA_EMAIL.Text) Then Email = Me.ALTA_EMAIL.Text

        'Alta cliente        
        IdSujeto = Clientes.AltaCliente(idCampanya:=Gestion.Campanya.IdCampanya, segmento:="", idOriginal:="", telefono:=sTelefono, nombre:=sNombre, apellido1:=sApellido1, apellido2:="", tipId:=0, localizableDesde:="0000",
                                        localizableHasta:="2359", email:=Email, nombreCompleto:=sNombre)
        Traces.Debug("Alta cliente IdSujeto " + IdSujeto.ToString)
        If IdSujeto >= 0 Then

            'Asociar cliente a Gestion
            Gestion.CargaCliente(IdSujeto)
            EvoAPI.LoadCustomer(IdSujeto)
            AltaLocalizador(sTelefono, "0", 0, Contacto)

            'Identificar cliente (llamada javascript y mover a Cliente.aspx)
            Dim argumentos As String = Gestion.Transaccion.IdTransaccion.ToString + ",  " + IdSujeto.ToString
            Traces.Debug("Asociando: " + argumentos)
            ClientScript.RegisterStartupScript(Me.GetType(), "asociar", "asociar(" + argumentos + ");", True)

            Gestion.Cliente.Save()
            Gestion.Cliente.DatosCliente.Save()
            DatoClienteComponentHelper.GuardaDatosCliente()

        End If

    End Sub


    Public Function AltaLocalizador(ByVal Localizador As String, ByVal Tipo As String, ByVal Orden As Integer _
                                   , Optional ByVal Observaciones As String = "Alta manual en argumentario") As Boolean ' Añade un nuevo localizador al cliente actual

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("EVOLUTION").ConnectionString)
        Dim cmd As SqlCommand = conn.CreateCommand
        Dim result As Integer = 0

        Try
            conn.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "sp_AltaLocalizador"
            cmd.Parameters.Add(New SqlParameter("@idSujeto", Gestion.Cliente.IdSujeto))
            cmd.Parameters.Add(New SqlParameter("@Localizador", Localizador))
            cmd.Parameters.Add(New SqlParameter("@idTipo", Tipo)) ' Si se especifica NULL para @idEstado y @idTipo usa valores por defecto
            cmd.Parameters.Add(New SqlParameter("@nOrden", Orden)) ' Si se especifica NULL para @nOrden se calcula un nuevo orden
            cmd.Parameters.Add(New SqlParameter("@Observaciones", Observaciones))
            cmd.Parameters.Add(New SqlParameter("@idEstado", 0)) ' Si se especifica NULL para @idEstado y @idTipo usa valores por defecto
            cmd.Parameters.Add(New SqlParameter("@bPrincipal", vbNull)) ' Si se especifica NULL para @bPrincipal usa valor por defecto (no principal)
            cmd.Parameters.Add(New SqlParameter("@idLocalizador", vbNull))

            result = cmd.ExecuteNonQuery()
            Log("setLocalizador", "Localizadores insertados: " & result.ToString())
            conn.Close()

        Catch ex As Exception
            Log("setLocalizador", "Error: " + ex.Message)
        End Try

        Return result

    End Function



    Protected Sub GridViewIdentificar_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)



        'comprobamos que el cliente que ha seleccionado este dado de alta en evolution
        Dim IDSUJETO As Long = Me.GridViewIdentificar.SelectedValue

        Dim ANI As String = Gestion.Transaccion.Ani

        Gestion.CargaCliente(IDSUJETO)
        EvoAPI.LoadCustomer(IDSUJETO)
        
        Dim argumentos As String = Gestion.Transaccion.IdTransaccion.ToString + ",  " + IDSUJETO.ToString

        Traces.Debug("GridViewIdentificar: " + Me.GridViewIdentificar.SelectedValue.ToString + " argumentos: " + argumentos)
        ClientScript.RegisterStartupScript(Me.GetType(), "alert", "asociar(" + argumentos + ");", True)

    End Sub


    ' Guarda los datos y finaliza transccion (envía encuesta si procede)
    ' Definir variable DN con el dn de la encuesta a la que transferir

    Protected Sub Finalizar(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim final As Integer = getFinal(sender)

        'guardar()
        ClientScript.RegisterStartupScript(Me.GetType, "CerrarTransaccion", "CerrarTransaccion('" + Gestion.Transaccion.IdTransaccion.ToString + "', '" + final.ToString + "');", True)

    End Sub

    ' Obtiene el Final en base al ID del boton pulsado
    Private Function getFinal(ByVal sender As Object) As Integer

        Dim boton As Button
        Dim botonId As String
        Dim final As Integer = 0

        Try
            boton = CType(sender, Button)
            botonId = boton.ID

            Select Case botonId
                Case "btFinal104" : final =145
                    'Case "btFinal105" : final = 105
                    'Case "btFinal104" : final = 104
                    'Case "btFinal103" : final = 103
            End Select

        Catch ex As Exception
            Log("getFinal", "Error: " + ex.Message + ". " + ex.StackTrace)
        End Try

        Log("getFinal", "Final recuperado: " + final.ToString + ".")

        Return final

    End Function


    Protected Sub btBuscar_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CargarGrid()

    End Sub

    Private Sub Log(ByVal categoria As String, ByVal msg As String)

        msg = "[" + categoria + "] " + msg
        ClientScript.RegisterStartupScript(Me.GetType, "Log", "console.log('" + msg + "');", True)

        Traces.Debug("[" + categoria + "] " + msg)

    End Sub

</script>