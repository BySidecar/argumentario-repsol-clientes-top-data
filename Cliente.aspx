<%@ Page Language="vb" debug="true" AutoEventWireup="false" MasterPageFile="Site.Master" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="System.Net" %>

<%@ Import Namespace="System.Net.Mail" %>

<%@ Import Namespace="System.Globalization" %>

<%@ Register assembly="VisualEvolutionLibrary" namespace="Icr.Evolution.VisualEvolutionLibrary" tagprefix="evo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<header class="main-header"></header>

<div class="content container-fluid">

    <!-- NAVBAR -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="#">Sentido <b>
                                <%= getOrigen()%>
                            </b></a></li>
                </ul>


            </div>

        </div>
    </nav>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">INFO SEGMENTO</h3>
                        </div>
                    </div>
                </div>

                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <p>SEGMENTO: <strong><asp:Label ID="TipoSegmento" runat="server"></asp:Label></strong></p>
                            <p>NOMBRE SEGMENTO: <strong><asp:Label ID="NombreSegmento" runat="server"></asp:Label></strong></p>
                            <p>DESCRIPCIÓN SEGMENTO: <strong><asp:Label ID="DescSegmento" runat="server"></asp:Label></strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- CUERPO DATOS CLIENTE -->
    <div class="row">
        <!-- DATOS CLIENTE -->
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">Datos Cliente</h3>
                        </div>
                        <div class="col-md-9 text-right">
                            <asp:Button ID="btAlta" runat="server" Text="Cambio de Cliente" CssClass="btn btn-success" onclick="BuscarClientes_Click" />
                        </div>
                    </div>
                </div>

                <!-- DATOS PERSONALES -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Argumentario por tipo de base de datos</label>
                                <asp:TextBox ID="textotipobbdd" runat="server" placeholder="Argumentario tipo BBDD" CssClass="form-control" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-group">
                                <label>IDOriginal</label>
                                <asp:TextBox ID="idoriginal" runat="server" placeholder="IdOriginal" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Nombre</label>
								<asp:TextBox ID="Nombre" runat="server" placeholder="Nombre Donante" CssClass="form-control"></asp:TextBox>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Primer Apellido</label>
								<asp:TextBox ID="Apellido_1" runat="server" placeholder="Apellido1" CssClass="form-control"></asp:TextBox>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Segundo Apellido</label>
								<asp:TextBox ID="Apellido_2" runat="server" placeholder="Apellido2" CssClass="form-control"></asp:TextBox>
							</div>
						</div>                        
                        <div class="col-md-1">
                            <div class="form-group">
                                <label>BBDD</label>
                                <asp:TextBox ID="BBDD" runat="server" placeholder="" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-group">
                                <label>Tipo Base de Datos</label>
                                <asp:TextBox ID="TIPOBBDD" runat="server" placeholder="" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Empresa</label>
                                <asp:TextBox ID="empresa" runat="server" placeholder="" CssClass="form-control"
                                    ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Persona contacto</label>
                                <div class="input-group">
                                    <asp:TextBox ID="PERSONA_CONTACTO" runat="server" placeholder="" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Teléfono del cliente</label>
                                <asp:TextBox ID="ANI_" runat="server" placeholder="" CssClass="form-control"
                                    ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>DDI al que ha llamado</label>
                                <asp:TextBox ID="DNIS_" runat="server" placeholder="" CssClass="form-control"
                                    ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label>Comentarios BBDD</label><br />
                            <asp:TextBox ID="COMENTARIOS" runat="server" TextMode="MultiLine" EtiquetaAuto="False" Width="98%" style="margin:10px;" Height="70px" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            <div id="Div2" style="text-align: right; font-size: 12px;">Máximo 255 caracteres</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <div class="row">
                            <div class="col-md-3">
                                <h3 class="box-title">Datos Direccion</h3>
                            </div>

                        </div>
                    </div>
                    <!-- DATOS PERSONALES -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Tipo Via</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-arrows-alt-h"></i></span>
                                        <asp:DropDownList ID="Tipovia" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="select" Text="Seleccione una opción" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="avenida" Text="Avenida"></asp:ListItem>
                                            <asp:ListItem Value="calle" Text="Calle"></asp:ListItem>
                                            <asp:ListItem Value="Paseo" Text="Paseo"></asp:ListItem>
                                            <asp:ListItem Value="Travesia" Text="Travesia"></asp:ListItem>
                                            <asp:ListItem Value="Plaza" Text="Plaza"></asp:ListItem>
                                            <asp:ListItem Value="Camino" Text="Camino"></asp:ListItem>
                                            <asp:ListItem Value="Vereda" Text="Vereda"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label>Calle</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="Calle" runat="server" placeholder="Calle"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Número</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="Numero" runat="server" placeholder="Número"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Piso</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="Piso" runat="server" placeholder="Piso"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Puerta</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="Puerta" runat="server" placeholder="Puerta"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Codigo Postal</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="cpostal" runat="server" placeholder="Codigo Postal"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Localidad</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:TextBox ID="localidad" runat="server" placeholder="Localidad"
                                            CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Provincia</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-city"></i></span>
                                        <asp:DropDownList ID="Provincia" runat="server"
                                            CssClass="form-control">
                                            <asp:ListItem Selected="True" Text="Seleccione una opción" Value="select"></asp:ListItem>
                                            <asp:ListItem Text="NS/NC" Value="NS/NC"></asp:ListItem>
                                            <asp:ListItem Text="A Coruña" Value="A Coruña"></asp:ListItem>
                                            <asp:ListItem Text="Álava" Value="Álava"></asp:ListItem>
                                            <asp:ListItem Text="Albacete" Value="Albacete"></asp:ListItem>
                                            <asp:ListItem Text="Alicante" Value="Alicante"></asp:ListItem>
                                            <asp:ListItem Text="Almería" Value="Almería"></asp:ListItem>
                                            <asp:ListItem Text="Asturias" Value="Asturias"></asp:ListItem>
                                            <asp:ListItem Text="Ávila" Value="Ávila"></asp:ListItem>
                                            <asp:ListItem Text="Badajoz" Value="Badajoz"></asp:ListItem>
                                            <asp:ListItem Text="Islas Baleares" Value="Islas Baleares"></asp:ListItem>
                                            <asp:ListItem Text="Barcelona" Value="Barcelona"></asp:ListItem>
                                            <asp:ListItem Text="Burgos" Value="Burgos"></asp:ListItem>
                                            <asp:ListItem Text="Cáceres" Value="Cáceres"></asp:ListItem>
                                            <asp:ListItem Text="Cádiz" Value="Cádiz"></asp:ListItem>
                                            <asp:ListItem Text="Cantabria" Value="Cantabria"></asp:ListItem>
                                            <asp:ListItem Text="Castellón" Value="Castellón"></asp:ListItem>
                                            <asp:ListItem Text="Ceuta " Value="Ceuta "></asp:ListItem>
                                            <asp:ListItem Text="Ciudad Real" Value="Ciudad Real"></asp:ListItem>
                                            <asp:ListItem Text="Córdoba" Value="Córdoba"></asp:ListItem>
                                            <asp:ListItem Text="Cuenca" Value="Cuenca"></asp:ListItem>
                                            <asp:ListItem Text="Girona" Value="Girona"></asp:ListItem>
                                            <asp:ListItem Text="Granada" Value="Granada"></asp:ListItem>
                                            <asp:ListItem Text="Guadalajara" Value="Guadalajara"></asp:ListItem>
                                            <asp:ListItem Text="Guipúzcoa" Value="Guipúzcoa"></asp:ListItem>
                                            <asp:ListItem Text="Huelva" Value="Huelva"></asp:ListItem>
                                            <asp:ListItem Text="Huesca" Value="Huesca"></asp:ListItem>
                                            <asp:ListItem Text="Jaén" Value="Jaén"></asp:ListItem>
                                            <asp:ListItem Text="La Rioja" Value="La Rioja"></asp:ListItem>
                                            <asp:ListItem Text="Las Palmas" Value="Las Palmas"></asp:ListItem>
                                            <asp:ListItem Text="León" Value="León"></asp:ListItem>
                                            <asp:ListItem Text="Lleida" Value="Lleida"></asp:ListItem>
                                            <asp:ListItem Text="Lugo" Value="Lugo"></asp:ListItem>
                                            <asp:ListItem Text="Madrid" Value="Madrid"></asp:ListItem>
                                            <asp:ListItem Text="Melilla" Value="Melilla"></asp:ListItem>
                                            <asp:ListItem Text="Málaga" Value="Málaga"></asp:ListItem>
                                            <asp:ListItem Text="Murcia" Value="Murcia"></asp:ListItem>
                                            <asp:ListItem Text="Navarra" Value="Navarra"></asp:ListItem>
                                            <asp:ListItem Text="Orense" Value="Orense"></asp:ListItem>
                                            <asp:ListItem Text="Palencia" Value="Palencia"></asp:ListItem>
                                            <asp:ListItem Text="Pontevedra" Value="Pontevedra"></asp:ListItem>
                                            <asp:ListItem Text="Salamanca" Value="Salamanca"></asp:ListItem>
                                            <asp:ListItem Text="Segovia" Value="Segovia"></asp:ListItem>
                                            <asp:ListItem Text="Sevilla" Value="Sevilla"></asp:ListItem>
                                            <asp:ListItem Text="Soria" Value="Soria"></asp:ListItem>
                                            <asp:ListItem Text="Tarragona" Value="Tarragona"></asp:ListItem>
                                            <asp:ListItem Text="Santa Cruz de Tenerife" Value="Santa Cruz de Tenerife"></asp:ListItem>
                                            <asp:ListItem Text="Teruel" Value="Teruel"></asp:ListItem>
                                            <asp:ListItem Text="Toledo" Value="Toledo"></asp:ListItem>
                                            <asp:ListItem Text="Valencia" Value="Valencia"></asp:ListItem>
                                            <asp:ListItem Text="Valladolid" Value="Valladolid"></asp:ListItem>
                                            <asp:ListItem Text="Vizcaya" Value="Vizcaya"></asp:ListItem>
                                            <asp:ListItem Text="Zamora" Value="Zamora"></asp:ListItem>
                                            <asp:ListItem Text="Zaragoza" Value="Zaragoza"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">Datos de contacto</h3>
                        </div>

                    </div>
                </div>

                <!-- DATOS PERSONALES -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Teléfonos</label>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-phone telefono" onclick="LlamarV1(<%=Gestion.Transaccion.IdTransaccion %>)"></i></span>
                                    <asp:DropDownList ID="TELEFONOS" runat="server" CssClass="form-control"></asp:DropDownList>
                                    <span class="input-group-addon" data-toggle="modal" data-target="#altaLocalizador"><i class="fa fa-plus add-telefono" onclick="(<%guardar()%>)"></i></span>
                                    <span class="input-group-addon" data-toggle="modal" data-target="#verLocalizadores"><i class="fa fa-eye" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">                                
                                <label>Email</label>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fas fa-at"></i></span>
                                    <asp:TextBox ID="email" runat="server" placeholder="Email" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>                                
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">                                
                                <label>Email contacto</label>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fas fa-at"></i></span>
                                    <asp:TextBox ID="EmailContacto" runat="server" placeholder="Email contacto" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">Encuesta</h3>
                        </div>
                    </div>
                </div>

                <!-- DATOS PERSONALES -->
                <div class="box-body">
                    
                    <div class="row">
                        <div class="col-md-12">
                            <p>Hola, <%= Gestion.Cliente.Nombre %>. Soy <strong> <%= Gestion.Agente.Nombre %> <%= Gestion.Agente.Apellido1%> </strong> y te llamo de Repsol.</p>
                            <p><b>El motivo de mi llamada no es comercial <%= Gestion.Cliente.Nombre %></b>,
                                <% 
                                    Dim segmento As String = Gestion.Cliente.DatosCliente("SEGMENTO")
                                    Select Case segmento
                                        Case "1"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y gas y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "2"
                                            Response.Write("sabemos que eres <b>accionista de Repsol</b> y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "3"
                                            Response.Write("sabemos usas mucho nuestra APP de Waylet y por todo eso, queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "4"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y <b>eres accionista de Repsol</b> y por todo eso, queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "5"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "6"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y gas, <b>además eres accionista de Repsol</b> y por todo eso, queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "7"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y gas y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "1"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y gas, además tienes placas y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "8"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo con 2 suministros de luz y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case "9"
                                            Response.Write("sabemos que eres cliente nuestro desde hace tiempo de luz y gas, además <b>tienes placas</b> y queríamos agradecerte personalmente la confianza que tienes en nosotros, y además")
                                        Case Else
                                            Response.Write("")
                                    End Select
                                %> 
                                , <%= Gestion.Cliente.Nombre %> queremos escucharte. Conocer tu experiencia con Repsol 
                                <% 
                                    Select Case segmento
                                    Case "1" 
                                        Response.Write("y con nuestra APP waylet")
                                    Case "2" 
                                        Response.Write("y con waylet")
                                    Case "3" 
                                        Response.Write("y con Waylet")
                                    Case "4" 
                                        Response.Write("y con Waylet")
                                    Case "5" 
                                        Response.Write("y con waylet")
                                    Case "6" 
                                        Response.Write("y con Waylet")
                                    Case "7" 
                                        Response.Write("y con waylet")
                                    Case "8" 
                                        Response.Write("y con waylet")
                                    Case "9" 
                                        Response.Write("y con waylet")
                                    End Select
                                %> 
                                , asegurarnos de que te estamos ofreciendo lo que te mereces, además poder mejorar nuestros servicios. No nos llevará mucho tiempo y creemos que tu opinión es importante y clave para ofrecerte una mejor experiencia como cliente. ¿Solo son 5 minutos?
                            
                                

                            </p>
                            <p><span class="text-blue">(Entrevistador: preguntar en abierto e intentar recodificar las respuestas abiertas entre los siguientes motivos)</span></p>
                            <br />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label>1. ¿Cómo ha ido este año? ¿Cómo de contento / satisfecho estás con Repsol? </label>
                            <div class="input-group">
                                <asp:DropDownList ID="Respuesta1" runat="server" CssClass="form-control" AutoPostBack="true" RepeatLayout="Flow"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>2. ¿Hay algo que te haya gustado especialmente este año de tu experiencia con Repsol o que haya sido útil para ti?</label>
                            <div class="input-group">
                                <asp:DropDownList ID="Respuesta2" runat="server" CssClass="form-control" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Si" Text="Sí"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <% If Me.Respuesta2.SelectedValue = "Si" Then %>
                            <br />
                            <div class="form-group">
                                <asp:TextBox ID="RespuestaOtros2" runat="server" placeholder="Especificar" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                            <% End If %>

                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>3. ¿Hay algo que no te haya gustado o que hayas echado en falta?</label>
                            <div class="input-group">
                                <asp:DropDownList ID="Respuesta3" runat="server" CssClass="form-control" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Si" Text="Sí"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            
                            <% If Me.Respuesta3.SelectedValue = "Si" Then %>
                            <br />
                            <div class="form-group">
                                <asp:TextBox ID="RespuestaOtros3" runat="server" placeholder="Especificar" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                            <% End If %>

                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>4. ¿Qué fue lo que te llevó a elegirnos como tu compañía energética?</label>
                            <div class="input-group">
                                <asp:CheckBoxList ID="Respuesta4" runat="server" CssClass="checkbox-list" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="Confianza en la marca" Text="Confianza en la marca"></asp:ListItem>
                                    <asp:ListItem Value="Servicio / Atención al cliente / Trato" Text="Servicio / Atención al cliente / Trato"></asp:ListItem>
                                    <asp:ListItem Value="Precio" Text="Precio"></asp:ListItem>
                                    <asp:ListItem Value="Asesoramiento energético" Text="Asesoramiento energético"></asp:ListItem>
                                    <asp:ListItem Value="No tener problemas / Fiabilidad" Text="No tener problemas / Fiabilidad "></asp:ListItem>
                                    <asp:ListItem Value="Información facilitada / Claridad de la información" Text="Información facilitada / Claridad de la información"></asp:ListItem>
                                    <asp:ListItem Value="Promociones / descuentos ofrecidos" Text="Promociones / descuentos ofrecidos"></asp:ListItem>
                                    <asp:ListItem Value="Otros" Text="Otros"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>

                            <% If Me.Respuesta4.Items.FindByValue("Otros").Selected Then %>
                            <div class="form-group">
                                <asp:TextBox ID="RespuestaOtros4" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                            <% End If %>
        
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>5. ¿Hay algo que te haya hecho mantenerte con nosotros?</label>
                            <div class="input-group">
                                <asp:CheckBoxList ID="Respuesta5" runat="server" CssClass="checkbox-list" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="Confianza en la marca" Text="Confianza en la marca"></asp:ListItem>
                                    <asp:ListItem Value="Servicio / Atención al cliente / Trato" Text="Servicio / Atención al cliente / Trato"></asp:ListItem>
                                    <asp:ListItem Value="Precio" Text="Precio"></asp:ListItem>
                                    <asp:ListItem Value="Asesoramiento energético" Text="Asesoramiento energético"></asp:ListItem>
                                    <asp:ListItem Value="No tener problemas / Fiabilidad" Text="No tener problemas / Fiabilidad "></asp:ListItem>
                                    <asp:ListItem Value="Información facilitada / Claridad de la información" Text="Información facilitada / Claridad de la información"></asp:ListItem>
                                    <asp:ListItem Value="Promociones / descuentos ofrecidos" Text="Promociones / descuentos ofrecidos"></asp:ListItem>
                                    <asp:ListItem Value="Otros" Text="Otros"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>

                            <% If Me.Respuesta5.Items.FindByValue("Otros").Selected Then %>
                            <div class="form-group">
                                <asp:TextBox ID="RespuestaOtros5" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                            <% End If %>
        
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>6. En tu relación con compañías de energía, ¿hay algún valor o servicio que te parezca esencial o al que le des especial importancia?</label>
                            <div class="form-group">
                                <asp:TextBox ID="Respuesta6" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>7. ¿Te podemos ofrecer ayuda con alguna necesidad que tengas? Te pondremos en contacto con un equipo experto si lo necesitas.
                                <br /><strong style="color: red;">**IMPORTANTE:  todos los casos en los que el cliente nos haya dicho que SÍ tiene alguna necesidad de ATC o de venta, debemos compartirlos diariamente con el equipo correspondiente.</strong></label>

                            <div class="input-group">
                                <asp:DropDownList ID="Respuesta7" runat="server" CssClass="form-control" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Si" Text="Sí"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <% If Me.Respuesta7.SelectedValue = "Si" Then %>
                            <br />
                            <div class="col-md-12">
                                <label>7.1. ¿En qué? (Necesidad energética  / Explicación o resolución de dudas  / Ayuda en alguna gestión)</label>
                                <div class="input-group">
                                    <asp:RadioButtonList ID="Respuesta7a" runat="server" CssClass="checkbox-list" AutoPostBack="true" RepeatLayout="Flow">
                                        <asp:ListItem Value="Necesidad energética" Text="Necesidad energética"></asp:ListItem>
                                        <asp:ListItem Value="Explicación o resolución de dudas" Text="Explicación o resolución de dudas"></asp:ListItem>
                                        <asp:ListItem Value="Ayuda en alguna gestión" Text="Ayuda en alguna gestión"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
        
                                <% If Not String.IsNullOrEmpty(Me.Respuesta7a.SelectedValue) Then %>
                                <br />
                                <div class="form-group">
                                    <asp:TextBox ID="RespuestaOtros7a" runat="server" placeholder="Especificar" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>
                                <% End If %>
            
                            </div>
                        <% End If %>
                    </div>
                    <br />

                    <% If Not {"6", "7", "9"}.Contains(Gestion.Cliente.DatosCliente("SEGMENTO")) Then %>
                        <div class="row">
                            <div class="col-md-12">
                                <label>8. Teniendo en cuenta que
                                <% If Gestion.Cliente.DatosCliente("SEGMENTO") = "1" %>
                                    eres cliente de luz y gas, ¿por qué no usas Waylet? Estás perdiendo 15cént de saldo por litro de carburante.
                                <% End If %>
                                <% If {"2", "3"}.Contains(Gestion.Cliente.DatosCliente("SEGMENTO")) Then %>
                                    repostas bastante en Repsol y pagas tus repostajes con Waylet., ¿Por qué no tienes la luz o el gas con Repsol? Tendrías 10 o 15cént de saldo por litro de carburante, en vez de 5cént.]
                                <% End If %>
                                <% If {"4", "5"}.Contains(Gestion.Cliente.DatosCliente("SEGMENTO")) Then %>
                                    eres cliente de luz  y utilizas Waylet para pagar tus repostajes, ¿Por qué no tienes el gas con Repsol? Tendrías 15cént de saldo por litro de carburante en vez de 10cént.]
                                <% End If %>
                                <% If Gestion.Cliente.DatosCliente("SEGMENTO") = "8" %>
                                    eres cliente de luz y utilizas Waylet para pagar tus repostajes, ¿Por qué no tienes el gas con Repsol?]
                                <% End If %>
                                </label>
                                <div class="form-group">
                                    <asp:TextBox ID="Respuesta8" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                    <% End If %>

                    <div class="row">
                        <div class="col-md-12">
                            <label>9. En tu relación con Repsol ¿por qué vías prefieres comunicarte?</label>
                            <div class="input-group">
                                <asp:CheckBoxList ID="Respuesta9" runat="server" CssClass="checkbox-list" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="Teléfono" Text="Teléfono"></asp:ListItem>
                                    <asp:ListItem Value="Presencial (en oficinas o Estaciones de Servicio)" Text="Presencial (en oficinas o Estaciones de Servicio)"></asp:ListItem>
                                    <asp:ListItem Value="Email" Text="Email"></asp:ListItem>
                                    <asp:ListItem Value="Whatsapp" Text="Whatsapp"></asp:ListItem>
                                    <asp:ListItem Value="Apps " Text="Apps"></asp:ListItem>
                                    <asp:ListItem Value="Web" Text="Web"></asp:ListItem>
                                    <asp:ListItem Value="Otros" Text="Otros"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                            <% If Me.Respuesta9.Items.FindByValue("Otros").Selected Then %>
                            <div class="form-group">
                                <asp:TextBox ID="RespuestaOtros9" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                            <% End If %>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>10. ¿Conoces nuestras plataformas digitales?</label>
                            <div class="input-group">
                                <asp:DropDownList ID="Respuesta10" runat="server" CssClass="form-control" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Si" Text="Sí"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            
                        </div>
                        <% If Me.Respuesta10.SelectedValue = "Si" Then %>
                            <br />
                            <div class="col-md-12">
                                <label>10.1. ¿Cuáles?</label>
                                <div class="input-group">
                                    <asp:CheckBoxList ID="Respuesta10a" runat="server" CssClass="checkbox-list" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                        <asp:ListItem Value="Waylet" Text="Waylet"></asp:ListItem>
                                        <asp:ListItem Value="Vivit" Text="Vivit"></asp:ListItem>
                                        <asp:ListItem Value="Área Cliente" Text="Área Cliente"></asp:ListItem>
                                        <asp:ListItem Value="Pide tu Bombona" Text="Pide tu Bombona"></asp:ListItem>
                                        <asp:ListItem Value="Otros" Text="Otros"></asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
        
                                <% If Me.Respuesta10a.Items.FindByValue("Otros").Selected Then %>
                                <br />
                                <div class="form-group">
                                    <asp:TextBox ID="RespuestaOtros10a" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>
                                <% End If %>
            
                            </div>
                        <% End If %>
                    </div>
                    <br />

                    <% If Me.Respuesta10.SelectedValue = "Si" Then %>
                    <div class="row">
                        <div class="col-md-12">
                            <label>11.De todas ellas, ¿cúales sueles usar porque te resultan útiles?</label>
                            <div class="input-group">
                                <asp:CheckBoxList ID="Respuesta11" runat="server" CssClass="checkbox-list" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                    <asp:ListItem Value="Waylet" Text="Waylet"></asp:ListItem>
                                    <asp:ListItem Value="Vivit" Text="Vivit"></asp:ListItem>
                                    <asp:ListItem Value="Área Cliente" Text="Área Cliente"></asp:ListItem>
                                    <asp:ListItem Value="Pide tu Bombona" Text="Pide tu Bombona"></asp:ListItem>
                                    <asp:ListItem Value="Otros" Text="Otros"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                            <% If Me.Respuesta11.Items.FindByValue("Otros").Selected Then %>
                                <div class="form-group">
                                    <asp:TextBox ID="RespuestaOtros11" runat="server" placeholder="Otros" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                </div>
                                <% End If %>
                        </div>
                    </div>
                    <br />
                    <% End If %>

                    <div class="row">
                        <div class="col-md-12">
                            <label>12.¿Qué tipo de consultas o gestiones te gustaría hacer de forma digital?</label>
                            <div class="form-group">
                                <asp:TextBox ID="Respuesta12" runat="server" placeholder="" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>13.¿Hay algo que consideres que podríamos mejorar o que te gustaría ver de nosotros en el futuro?</label>
                            <div class="form-group">
                                <asp:TextBox ID="Respuesta13" runat="server" placeholder="" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col-md-12">
                            <label>14.¿Te ha parecido útil esta llamada?</label>
                            <div class="input-group">
                                <div class="input-group">
                                    <asp:DropDownList ID="Respuesta14" runat="server" CssClass="form-control" AutoPostBack="true" SelectionMode="Multiple" RepeatLayout="Flow">
                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                        <asp:ListItem Value="Si" Text="Sí"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />

                    <p>Muchas gracias por tu ayuda, tus respuestas nos ayudan a mejorar nuestros servicios</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <!-- HISTORICO TRANSACCIONES -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">Histórico de transacciones</h3>
                        </div>
                    </div>
                </div>
                <!-- HISTORICO DE TRANSACCIONES -->
                <div class="box-body">
                    <div class="tab-pane active" id="historicoTransacciones">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="btAlternarVisbilidadEmail" runat="server"
                                    CssClass="btn btn-info btn-enlinea btn-sm" Text="Mostrar Historial"
                                    Font-Bold="True" Font-Size="8pt" OnClick="btAlternarVisbilidadGrid_Click" />
                            </div>
                            <div class="col-md-12">
                                <asp:GridView ID="GridHistorial" runat="server" DataSourceID="SqlHistorico"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-hover dataTable" CellSpacing="5"
                                    AllowPaging="False">
                                    <Columns>
                                        <asp:BoundField DataField="Fecha_Fin" HeaderText="Fecha"
                                            DataFormatString="{0:dd-MM-yyyy HH:mm:ss}" />
                                        <asp:BoundField DataField="Agente" HeaderText="Agente" />
                                        <asp:BoundField DataField="Final" HeaderText="Final" />

                                    </Columns>

                                    <EmptyDataTemplate>
                                        <asp:Label ID="GridViewVacio" runat="server"
                                            Text='No se han encontrado resultados.'></asp:Label>
                                    </EmptyDataTemplate>

                                </asp:GridView>

                                <asp:SqlDataSource id="SqlHistorico" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:connectionstring %>"
                                    SelectCommand=""
                                    ProviderName="<%$ ConnectionStrings:connectionstring.ProviderName %>">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                    </div>
                </div>
                </div>


            <!-- FINALES -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h3 class="box-title">Finales</h3>
                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="IrFinal" runat="server" Value="0" />
                <!-- FINALES -->
                <div class="box-body">
                    <div class="box-body">
                        <div class="row">

                            <div class="col-md-12">
                                <label>Observaciones</label><br />
                                <asp:TextBox ID="DatosCliente_Observaciones" runat="server" TextMode="MultiLine"
                                    EtiquetaAuto="False" Width="98%" style="margin:10px;" Height="70px">
                                </asp:TextBox>
                                <div id="Div1" style="text-align: right; font-size: 12px;">Máximo 255 caracteres
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Finales</h3>
                                </div>

                                <div class="box-body"><!--FinalizarTransaccion-->
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Categoria</label>
                                            <div class="input-group">
                                                <asp:DropDownList ID="cmbMotivo" runat="server"
                                                    CssClass="form-control w-auto inlineblock"
                                                    AutoPostBack="True"
                                                    OnSelectedIndexChanged="cmbMotivo_SelectedIndexChanged">
                                                    <asp:ListItem Value="-1" Text="N/A" Selected="True">
                                                    </asp:ListItem>

                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>SubCategoria</label>
                                            <div class="input-group">
                                                <asp:DropDownList ID="cmbFinales" runat="server"
                                                    CssClass="form-control w-auto inlineblock"
                                                    AutoPostBack="True"
                                                    OnSelectedIndexChanged="cmbFinales_SelectedIndexChanged">
                                                    <asp:ListItem Value="-1" Text="N/A" Selected="True">
                                                    </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12"></div>
                                    <div class="col-md-4">
                                        <asp:Button ID="btFinal" runat="server" Text="Finalizar"
                                            CssClass="btn btn-primary" onclick="Finalizar" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="altaLocalizador" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Alta localizador</h4>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Alta localizador</label>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                    <asp:TextBox ID="txtAltaLocalizador" runat="server" TextMode="Number"
                                        MaxLength="16" CssClass="form-control w-45" Wrap="True"></asp:TextBox>
                                    <asp:DropDownList ID="cmbAltaLocalizador" runat="server"
                                        CssClass="form-control w-20">
                                        <asp:ListItem Selected="True" Value="2">Móvil</asp:ListItem>
                                        <asp:ListItem Value="1">Fijo</asp:ListItem>
                                        <asp:ListItem Value="0">Otro</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button ID="btAltaLocalizador" runat="server" CssClass="btn btn-primary" Text="Añadir"
                        onclick="btAltaLocalizador_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="verLocalizadores" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Vista de localizadores</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <asp:GridView ID="GridLocalizador" runat="server" DataSourceID="SqlLocalizador"
                                AutoGenerateColumns="False"
                                CssClass="table table-bordered table-hover dataTable" CellSpacing="5"
                                AllowPaging="False">
                                <Columns>
                                    <asp:BoundField DataField="Localizador" HeaderText="Telefonos" />
                                    <asp:BoundField DataField="Operador" HeaderText="Tipo" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <asp:Label ID="GridViewVacio" runat="server"
                                        Text='No se han encontrado resultados.'></asp:Label>
                                </EmptyDataTemplate>
                            </asp:GridView>

                            <asp:SqlDataSource id="SqlLocalizador" runat="server"
                                ConnectionString="<%$ ConnectionStrings:connectionstring %>" SelectCommand=""
                                ProviderName="<%$ ConnectionStrings:connectionstring.ProviderName %>">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
  
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server"></asp:Content>

<script runat="server">

    Dim strConnEvo As String = "DRIVER={SQL Server};SERVER=10.100.1.211\EVOLUTION;UID=sa;PWD=wGu3Pq2y86In;DATABASE=EVOLUTIONDB;"
    Dim strConnEvoDoc As String = "DRIVER={SQL Server};SERVER=10.100.1.211\EVOLUTION;UID=sa;PWD=wGu3Pq2y86In;DATABASE=EVOLUTIONDBDOC;"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    
        If Not IsPostBack Then ' Primera carga
            cargar()
            cargarMotivos()
            AddItemsToDropDown1to10(Respuesta1)
        Else
            Log("Page_Load", "Page_Load por PostBack")
            ClientScript.RegisterStartupScript(Me.GetType(), "irfinal", "window.scrollTo(0,document.body.scrollHeight);", True)
        End If

    End Sub

    '-------------------'
    ' ---- CARGAR ----- '
    '-------------------'


    Private Sub cargar()
        
        Me.idoriginal.Text = Gestion.Cliente.IdOriginal
        Me.Nombre.Text = Gestion.Cliente.Nombre
        Me.Apellido_1.Text = Gestion.Cliente.Apellido1
        Me.Apellido_2.Text = Gestion.Cliente.Apellido2
        Me.Calle.Text = Gestion.Cliente.Direccion
        Me.Numero.Text = Gestion.Cliente.Num1.ToString
        Me.Piso.Text = Gestion.Cliente.DatosCliente("Piso")
        Me.BBDD.Text = Gestion.Cliente.Texto3
        Me.Puerta.Text = Gestion.Cliente.DatosCliente("Puerta")
        Me.cpostal.Text = Gestion.Cliente.CodigoPostal
        Me.localidad.Text = Gestion.Cliente.Poblacion
        Me.Provincia.SelectedValue = Gestion.Cliente.Provincia
        Me.email.Text = Gestion.Cliente.Email
        Me.EmailContacto.Text = Gestion.Cliente.DatosCliente("EmailContacto")
        Me.empresa.Text = Gestion.Cliente.Empresa
        Me.TIPOBBDD.Text = Gestion.Cliente.DatosCliente("TIPOBBDD")
        Me.COMENTARIOS.Text = Gestion.Cliente.DatosCliente("COMENTARIOS")
        Me.PERSONA_CONTACTO.Text = Gestion.Cliente.DatosCliente("PERSONA_CONTACTO")
        Me.DatosCliente_Observaciones.Text = Gestion.Cliente.Observaciones

       
        Me.TipoSegmento.Text = Gestion.Cliente.DatosCliente("SEGMENTO")
        Me.NombreSegmento.Text = Gestion.Cliente.DatosCliente("NOMBRE SEGMENTO")
        Me.DescSegmento.Text = Gestion.Cliente.DatosCliente("DESCRIPCIÓN SEGMENTO")
        

        Me.Respuesta1.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta1")
        Me.Respuesta2.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta2")
        Me.RespuestaOtros2.Text = Gestion.Cliente.DatosCliente("RespuestaOtros2")
        Me.Respuesta3.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta3")
        Me.RespuestaOtros3.Text = Gestion.Cliente.DatosCliente("RespuestaOtros3")
        LoadCheckBoxListItems(Me.Respuesta4, Gestion.Cliente.DatosCliente("Respuesta4"))
        Me.RespuestaOtros4.Text = Gestion.Cliente.DatosCliente("RespuestaOtros4")
        LoadCheckBoxListItems(Me.Respuesta5, Gestion.Cliente.DatosCliente("Respuesta5"))
        Me.RespuestaOtros5.Text = Gestion.Cliente.DatosCliente("RespuestaOtros5")
        Me.Respuesta6.Text = Gestion.Cliente.DatosCliente("Respuesta6")
        Me.Respuesta7.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta7")
        Me.Respuesta7a.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta7a")
        Me.RespuestaOtros7a.Text = Gestion.Cliente.DatosCliente("RespuestaOtros7a")
        Me.Respuesta8.Text = Gestion.Cliente.DatosCliente("Respuesta8")
        LoadCheckBoxListItems(Me.Respuesta9, Gestion.Cliente.DatosCliente("Respuesta9"))
        Me.RespuestaOtros9.Text = Gestion.Cliente.DatosCliente("RespuestaOtros9")
        Me.Respuesta10.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta10")
        LoadCheckBoxListItems(Me.Respuesta10a, Gestion.Cliente.DatosCliente("Respuesta10a"))
        Me.RespuestaOtros10a.Text = Gestion.Cliente.DatosCliente("RespuestaOtros10a")
        LoadCheckBoxListItems(Me.Respuesta11, Gestion.Cliente.DatosCliente("Respuesta11"))
        Me.RespuestaOtros11.Text = Gestion.Cliente.DatosCliente("RespuestaOtros11")
        Me.Respuesta12.Text = Gestion.Cliente.DatosCliente("Respuesta12")
        Me.Respuesta13.Text = Gestion.Cliente.DatosCliente("Respuesta13")
        Me.Respuesta14.SelectedValue = Gestion.Cliente.DatosCliente("Respuesta14")

        If Left(Gestion.Transaccion.Ani, 1) = "1" Then
            Me.ANI_.Text = Right(Gestion.Transaccion.Ani, 9)
        Else : Me.ANI_.Text = Gestion.Transaccion.Ani
        End If
        Me.DNIS_.Text = Gestion.Transaccion.Dnis
        
        CargarGrid()
        'cargarFinales()
        cargarTelefonos()
        CargarGridLocalizadores()
    End Sub

    Private Sub AddItemsToDropDown1to10(ByVal dropdown As DropDownList)
        ' Genera los ítems del 1 al 10 y los agrega al DropDownList especificado
        dropdown.Items.Add(New ListItem("", ""))
        For i As Integer = 1 To 10
            dropdown.Items.Add(New ListItem(i.ToString(), i.ToString()))
        Next
    End Sub
    
    Protected Sub CargarGridLocalizadores()

        Dim sSql As String = ""

        sSql = "SELECT 	Localizador, case idTipo WHEN 1 THEN 'Fijo' WHEN 2 THEN 'Móvil' ELSE 'Otros' END AS Operador FROM [EVOLUTIONDB].dbo.tbLocalizador WHERE idSujeto=" & Gestion.Cliente.IdSujeto.ToString

        'Traces.Debug("Sql1: " + sSql)

        
        Log("CargarGridLocalizadores", "Query (| -> comillas): " + sSql.Replace("'", "|"))

        SqlLocalizador.SelectCommand = sSql


    End Sub
   
    
   
    
    Public Function CargarSegmento() As String
        Dim valor As String = ""

        Dim reader As Odbc.OdbcDataReader
        Dim command As Odbc.OdbcCommand
        Dim strSQL As String = "select atributo_segmento from tbIdentidadSujetoCampanya where IDSUJETO = " & Gestion.Cliente.IdSujeto.ToString

        Log("CargarSegmento", "strSQL: " + strSQL)

        Using connection As New Odbc.OdbcConnection(strConnEvo)

            command = New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                If reader.HasRows Then
                    While (reader.Read())
                        valor = reader.GetString(0)
                    End While
                End If

                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("CargarSegmento", "Error: " + ex.Message)
            End Try

        End Using

        Log("CargarSegmento", "Valor Segmento: " + valor)

        Return valor

    End Function
    

    Protected Sub CargarGrid()

        Dim sSql As String = ""

        sSql = "Select top 10 idTransaccion, tInicio as Fecha_Inicio, tFinal as Fecha_Fin,"
        sSql = sSql + " sNombreUsuario +' '+ sApellido1Usuario as Agente, sDescripcionFinal as Final, observaciones as DatosDonacion"
        sSql = sSql + " from vwTransacciones2"
        sSql = sSql + " where idSujeto=" + Gestion.Cliente.IdSujeto.ToString
        sSql = sSql + " and tFinal is not null"
        sSql = sSql + " order by idTransaccion desc"

        Traces.Debug("Sql1: " + sSql)

        Log("CargarGrid", "Query (| -> comillas): " + sSql.Replace("'", "|"))

        SqlHistorico.SelectCommand = sSql

    End Sub

    Protected Sub CargarComboSubmotivo()

        Dim strSQL As String = ""
        Dim telefono As String = Gestion.Transaccion.Dnis
        Dim strConn As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim reader As Odbc.OdbcDataReader

        strSQL = "select descripcion, idFinal from finales where idFinal in (select idFinal from FinalGrupo where idGrupoFinal IN (select idGrupoFinal from GruposFinal where sDescripcion ='FINALES MOSTRAR' and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString() + "))  and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString()
        Log("CargarComboSubmotivo", strSQL)

        Using connection As New Odbc.OdbcConnection(strConn)

            Dim command As New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                Log("CargarComboSubmotivo", "Hay finales?: " + reader.HasRows.ToString)


                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("CargarComboSubmotivo", "Error: " + ex.Message)

            End Try

        End Using

    End Sub

    Public Sub cargarTelefonos()

        Me.TELEFONOS.Items.Clear()
        For Each telefono In getLocalizadores()
            Me.TELEFONOS.Items.Add(New ListItem(text:=telefono.Key & " (" & telefono.Value & ")", value:=telefono.Key))
        Next
    End Sub

    '----------------------'
    ' -- GRID HISTORIAL -- '
    '----------------------'

    Protected Sub btAlternarVisbilidadGrid_Click(sender As Object, e As EventArgs)

        If Me.GridHistorial.Visible = True Then
            Me.GridHistorial.Visible = False
            Me.btAlternarVisbilidadEmail.Text = "Mostrar Historial"
        Else
            Me.btAlternarVisbilidadEmail.Text = "Ocultar Historial"
            Me.GridHistorial.Visible = True
        End If

    End Sub

    Private Function getSentido() As String

        Log("getSentido", "ContactoInicial.Origen: " + Gestion.Transaccion.ContactoInicial.Origen)

        Select Case Gestion.Transaccion.SentidoContacto
            Case 1 : Return "Llamada entrante"
            Case 2 : Return "Llamada saliente"
            Case 3 : Return "Llamada saliente manual"
            Case Else : Return "Desconocido"
        End Select

    End Function
    
    Private Function getOrigen() As String

        Dim resultado As String = ""
        Dim strSQL As String = "select nOrigenTransaccion from TRANSACCION where idTransaccion =  " + Gestion.Transaccion.IdTransaccion.ToString()

        Traces.Debug("[getOrigen], sSql: " + strSQL)
       
        Try

            Using connection As New Odbc.OdbcConnection(strConnEvo)

                Dim command As New Odbc.OdbcCommand(strSQL, connection)
                connection.Open()

                Dim reader As Odbc.OdbcDataReader = command.ExecuteReader()

                While reader.Read()
                    resultado = reader.GetInt32(0)
                End While

                reader.Close()
                connection.Close()
                connection.Dispose()

            End Using

        Catch ex As Exception
            Traces.Error("MostrarDatoScript devolvió el error: " & ex.Message)
            Return "Desconocido"
        End Try


        Log("getOrigen", "Sentido:" + resultado + ".")

        If resultado = 0 Then
            Return "Undefined"
        ElseIf resultado = 1 Then
            Return "Entrante"
        ElseIf resultado = 2 Then
            Return "Entrante"
        ElseIf resultado = 3 Then
            Return "Saliente - Presencial"
        ElseIf resultado = 4 Then
            Return "Saliente - Vista Previa"
        ElseIf resultado = 5 Then
            Return "Saliente - Marcador"
        ElseIf resultado = 6 Then
            Return "ReQueue"
        Else
            Return "Desconocido"
        End If

    End Function
    
    Private Function getTelefono() As String

        Dim telefono As String = Gestion.Cliente.Telefono
        Dim ANI As String = Gestion.Transaccion.Ani
        Dim DNIS As String = Gestion.Transaccion.Dnis

        Dim PLocalizador As String = 0
        If (Gestion.Cliente.Localizadores.Count > 0) Then
            telefono = Gestion.Cliente.Localizadores.First().LocalizadorValue
            PLocalizador = telefono
        End If

        If Gestion.Transaccion.SentidoContacto = 1 Then ' -- TRANS. ENTRANTE
            Log("getTelefono", "Tel. ENTRANTE -> ANI: " + ANI + ", DNIS: " + DNIS + ", Localizador:" + PLocalizador)
        Else ' -- TRANS. SALIENTE
            Log("getTelefono", "Tel. SALIENTE -> ANI: " + ANI + ", DNIS: " + DNIS + ", Localizador:" + PLocalizador)
        End If

        Log("getTelefono", "Resultado: " + telefono)

        Return telefono

    End Function

    '----------------------'
    ' ------ GUARDAR ----- '
    '----------------------'

    Private Sub guardar()
        If Not String.IsNullOrWhiteSpace(Me.Numero.Text) Then
            If IsNumeric(Me.Numero.Text) Then
                Gestion.Cliente.Num1 = Int32.Parse(Me.Numero.Text)
            End If
   
        End If
        
        Gestion.Cliente.Observaciones = Me.DatosCliente_Observaciones.Text
        Gestion.Cliente.IdOriginal = Me.idoriginal.Text
        Gestion.Cliente.Nombre = Me.Nombre.Text
        Gestion.Cliente.Apellido1 = Me.Apellido_1.Text
        Gestion.Cliente.Apellido2 = Me.Apellido_2.Text        
        Gestion.Cliente.DatosCliente("TipoVia") = Me.Tipovia.SelectedValue
        Gestion.Cliente.Direccion = Me.Calle.Text
        Gestion.Cliente.DatosCliente("Piso") = Me.Piso.Text
        Gestion.Cliente.DatosCliente("Puerta") = Me.Puerta.Text
        Gestion.Cliente.CodigoPostal = Me.cpostal.Text
        Gestion.Cliente.Poblacion = Me.localidad.Text
        Gestion.Cliente.Provincia = Me.Provincia.SelectedValue
        Gestion.Cliente.Email = Me.email.Text
        Gestion.Cliente.DatosCliente("EmailContacto") = Me.EmailContacto.Text
        Gestion.Cliente.Empresa = Me.empresa.Text
        Gestion.Cliente.DatosCliente("COMENTARIOS") = Me.COMENTARIOS.Text
        Gestion.Cliente.DatosCliente("PERSONA_CONTACTO") = Me.PERSONA_CONTACTO.Text
        Gestion.Cliente.DatosCliente("TIPOBBDD") = Me.TIPOBBDD.Text ' importado

        Gestion.Cliente.DatosCliente("Respuesta1") = Me.Respuesta1.SelectedValue
        Gestion.Cliente.DatosCliente("Respuesta2") = Me.Respuesta2.SelectedValue
        Gestion.Cliente.DatosCliente("RespuestaOtros2") = Me.RespuestaOtros2.Text
        Gestion.Cliente.DatosCliente("Respuesta3") = Me.Respuesta3.SelectedValue
        Gestion.Cliente.DatosCliente("RespuestaOtros3") = Me.RespuestaOtros3.Text
        Gestion.Cliente.DatosCliente("Respuesta4") = String.Join(";", Me.Respuesta4.Items.Cast(Of ListItem)().Where(Function(item) item.Selected).Select(Function(item) item.Value))
        Gestion.Cliente.DatosCliente("RespuestaOtros4") = Me.RespuestaOtros4.Text
        Gestion.Cliente.DatosCliente("Respuesta5") = String.Join(";", Me.Respuesta5.Items.Cast(Of ListItem)().Where(Function(item) item.Selected).Select(Function(item) item.Value))
        Gestion.Cliente.DatosCliente("RespuestaOtros5") = Me.RespuestaOtros5.Text
        Gestion.Cliente.DatosCliente("Respuesta6") = Me.Respuesta6.Text
        Gestion.Cliente.DatosCliente("Respuesta7") = Me.Respuesta7.SelectedValue
        Gestion.Cliente.DatosCliente("Respuesta7a") = Me.Respuesta7a.SelectedValue
        Gestion.Cliente.DatosCliente("RespuestaOtros7a") = Me.RespuestaOtros7a.Text
        Gestion.Cliente.DatosCliente("Respuesta8") = Me.Respuesta8.Text
        Gestion.Cliente.DatosCliente("Respuesta9") = String.Join(";", Me.Respuesta9.Items.Cast(Of ListItem)().Where(Function(item) item.Selected).Select(Function(item) item.Value))
        Gestion.Cliente.DatosCliente("RespuestaOtros9") = Me.RespuestaOtros9.Text
        Gestion.Cliente.DatosCliente("Respuesta10") = Me.Respuesta10.SelectedValue
        Gestion.Cliente.DatosCliente("Respuesta10a") = String.Join(";", Me.Respuesta10a.Items.Cast(Of ListItem)().Where(Function(item) item.Selected).Select(Function(item) item.Value))
        Gestion.Cliente.DatosCliente("Respuesta11") = String.Join(";", Me.Respuesta11.Items.Cast(Of ListItem)().Where(Function(item) item.Selected).Select(Function(item) item.Value))
        Gestion.Cliente.DatosCliente("RespuestaOtros11") = Me.RespuestaOtros11.Text
        Gestion.Cliente.DatosCliente("Respuesta12") = Me.Respuesta12.Text
        Gestion.Cliente.DatosCliente("Respuesta13") = Me.Respuesta13.Text
        Gestion.Cliente.DatosCliente("Respuesta14") = Me.Respuesta14.SelectedValue

        ' Guardar
        Gestion.Cliente.Save()
        Gestion.Cliente.DatosCliente.Save()
        DatoClienteComponentHelper.GuardaDatosCliente()
    End Sub

    '----------------------'
    ' ------ OTROS ------- '
    '----------------------'

    Protected Sub BuscarClientes_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        guardar()
        Response.Redirect("Alta.aspx")
    End Sub

    Protected Sub cargarFinalesNegativos()

        Dim strSQL As String = ""
        Dim telefono As String = Gestion.Transaccion.Dnis
        Dim strConn As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim reader As Odbc.OdbcDataReader

        strSQL = "select descripcion, idFinal from finales where idFinal in (select idFinal from FinalGrupo where idGrupoFinal IN (select idGrupoFinal from GruposFinal where sDescripcion ='NO CONTACTADO' and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString() + "))  and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString() + " order By descripcion asc"
        Log("cargarFinalesNegativos", "Query (| -> comillas): " + strSQL.Replace("'", "|"))

        Using connection As New Odbc.OdbcConnection(strConn)

            Dim command As New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                Log("cargarFinalesNegativos", "Hay finales?: " + reader.HasRows.ToString)

                With Me.cmbMotivo.Items

                    .Clear()
                    .Add(New ListItem("Seleccione una Opción", "-1"))
                    If reader.HasRows Then
                        While (reader.Read())
                            'Log("cargarFinales", "Final: " + reader.GetValue("DESCRIPCION"))
                            .Add(New ListItem(reader.GetString(0), reader.GetInt32(1)))
                        End While
                    Else
                        .Add(New ListItem("No Existe grupo", 0))
                    End If
                End With

                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("cargarFinales", "Error: " + ex.Message)

            End Try

        End Using

    End Sub

    Protected Sub cargarMotivos()

        Dim strSQL As String = ""
        Dim telefono As String = Gestion.Transaccion.Dnis
        Dim strConn As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim reader As Odbc.OdbcDataReader

        strSQL = "Select idGrupoFinal, sDescripcion from GruposFinal where sDescripcion != 'NO CONTACTADO' and idGrupoFinal != 0 and IDCAMPANYA = " + Gestion.Campanya.IdCampanya.ToString() + " order By sDescripcion asc"
        Log("cargarFinales", strSQL)

        Using connection As New Odbc.OdbcConnection(strConn)

            Dim command As New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                Log("cargarMotivos", "Hay finales?: " + reader.HasRows.ToString)

                With Me.cmbMotivo.Items

                    .Clear()
                    .Add(New ListItem("Seleccione una Opción", "-1"))
                    If reader.HasRows Then
                        While (reader.Read())
                            Log("cargarMotivos", "sDescripción: " + reader.GetString(1) + " idGrupo: " + reader.GetValue(0).ToString + ".")
                            .Add(New ListItem(reader.GetString(1), reader.GetValue(0)))
                        End While
                    Else
                        .Add(New ListItem("No Existe grupo", 0))
                    End If
                End With

                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("cargarFinales", "Error: " + ex.Message)

            End Try

        End Using

    End Sub


    Protected Sub cargarSubMotivos()

        Dim strSQL As String = ""
        Dim telefono As String = Gestion.Transaccion.Dnis
        Dim strConn As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim reader As Odbc.OdbcDataReader

        strSQL = "select descripcion, idFinal from finales where idFinal in (select idFinal from FinalGrupo where idGrupoFinal = " + Me.cmbMotivo.SelectedValue + " and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString() + ")  and IDCAMPANYA= " + Gestion.Campanya.IdCampanya.ToString() + " order By descripcion asc"
        Log("cargarSubMotivos", strSQL)

        Using connection As New Odbc.OdbcConnection(strConn)

            Dim command As New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                Log("cargarSubMotivos", "Hay finales?: " + reader.HasRows.ToString)

                With Me.cmbFinales.Items

                    .Clear()
                    .Add(New ListItem("Seleccione una Opción", "-1"))
                    If reader.HasRows Then
                        While (reader.Read())
                            Log("cargarSubMotivos", "sDescripción: " + reader.GetString(0) + " idFinal: " + reader.GetValue(1).ToString + ".")
                            .Add(New ListItem(reader.GetString(0), reader.GetValue(1)))
                        End While
                    Else
                        .Add(New ListItem("No Existe grupo", 0))
                    End If
                End With

                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("cargarFinales", "Error: " + ex.Message)

            End Try

        End Using

    End Sub

    Protected Sub LimpiarComboSubMotivos()
       
        With Me.cmbFinales.Items
            .Clear()
            .Add(New ListItem("Seleccione una Opción", "-1"))
        End With
       
    End Sub
   
    
    
    '----------------------'
    ' --- VALIDACIONES --- '
    '----------------------'

    Private Function validaciones(ByVal final As Integer) As Boolean

        Dim mensaje As String = ""
           
        If final = "0" Or final = "-1" Then
            Log("validaciones", "Final Incorrecto:" + final.ToString + ".")
            mensaje = "Debe seleccionar un final correcto"
        End If
        If Not String.IsNullOrWhiteSpace(Me.email.Text) Then
            Log("validaciones", "email no nulo")
            If Not IsEmail(Me.email.Text) Then
                mensaje = "El email introducido en el campo email no es válido"
            End If
        End If
        
      

       
        
        Log("validaciones", "Tras validar se dará el mensaje: " + mensaje + ". (vacío implica que pasa todas las validaciones)")

        If mensaje <> "" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('" & mensaje & "');", True)
            Return False
        Else
            Return True
        End If

    End Function

    Private Function IsEmail(ByVal sCheckEmailAddress As String) As Boolean
        Dim cumple As Boolean
        cumple = Regex.IsMatch(sCheckEmailAddress, "^([\w-]+\.)*?[\w-]+@[\w-]+\.([\w-]+\.)*?[\w]+$")
        Log("IsEmail", "Valida email? " + cumple.ToString())
        Return cumple
    End Function


    '-------------------'
    ' ------ LOG ------ '
    '-------------------'


    Private Sub Log(ByVal categoria As String, ByVal msg As String)

        msg = "[" + categoria + "] " + msg
        ClientScript.RegisterStartupScript(Me.GetType, "Log", "console.log('" + msg + "');", True)

        Traces.Debug("[" + categoria + "] " + msg)

    End Sub



    '-------------------'
    ' ---- FINALES ---- '
    '-------------------'
    Protected Sub cmbMotivo_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

       
        cargarSubMotivos()
        Me.IrFinal.Value = 1
        guardar()
    End Sub


    Protected Sub cmbFinales_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
        guardar()

    End Sub

    

    Protected Sub Finalizar(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim final As Integer = 0
        final = Me.cmbFinales.SelectedValue

        Gestion.FinalGestion(final)
        guardar()
        
    End Sub


        
   


    '-------------------------'
    ' ---- Localizadores ---- '
    '-------------------------'

    Protected Sub btAltaLocalizador_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        
        guardar()

        If Me.txtAltaLocalizador.Text = "" Then
            ClientScript.RegisterStartupScript(Me.GetType, "AlertaLocalizador", "alert('Alta localizador fallida. No se ha indicado un número de teléfono.');", True)
        Else
            setLocalizador(Localizador:=Me.txtAltaLocalizador.Text, Tipo:=Me.cmbAltaLocalizador.SelectedValue, Orden:=Me.TELEFONOS.Items.Count, Observaciones:="Alta manual en argumentario")
            Response.Redirect(Request.RawUrl)
        End If
        
        guardar()

    End Sub

    Public Function setLocalizador(ByVal Localizador As String, ByVal Tipo As String, ByVal Orden As Integer, Optional ByVal Observaciones As String = "Alta manual en argumentario") As Boolean ' Añade un nuevo localizador al cliente actual

        guardar()
        
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
            cmd.Parameters.Add(New SqlParameter("@bPrincipal", 0)) ' Si se especifica NULL para @bPrincipal usa valor por defecto (no principal)
            cmd.Parameters.Add(New SqlParameter("@idLocalizador", vbNull))

            result = cmd.ExecuteNonQuery()
            Log("setLocalizador", "Localizadores insertados: " & result.ToString())
            conn.Close()

        Catch ex As Exception
            Log("setLocalizador", "Error: " + ex.Message)
        End Try

        Return result
        
        guardar()

    End Function
    
    Public Function getLocalizadores() As Dictionary(Of String, String) ' Obtiene los localizadores del cliente actual

        Dim Localizadores As New Dictionary(Of String, String)
        Dim reader As Odbc.OdbcDataReader
        Dim command As Odbc.OdbcCommand
        Dim strSQL As String = "SELECT 	Localizador, case idTipo WHEN 1 THEN 'Fijo' WHEN 2 THEN 'Móvil' ELSE 'Otros' END AS Tipo, case Observaciones WHEN '' THEN 'Desconocido' WHEN null then 'Desconocido' ELSE coalesce(Observaciones, 'Desconocido') END AS Contacto FROM [EVOLUTIONDB].dbo.tbLocalizador WHERE idSujeto=" & Gestion.Cliente.IdSujeto.ToString

        Using connection As New Odbc.OdbcConnection(strConnEvo)

            command = New Odbc.OdbcCommand(strSQL, connection)
            connection.Open()
            reader = command.ExecuteReader()

            Try
                If reader.HasRows Then
                    While (reader.Read())
                        Localizadores.Add(key:=reader.GetString(0), value:=reader.GetString(1) + " - " + reader.GetString(2))
                    End While
                End If

                connection.Close()
                connection.Dispose()

            Catch ex As Exception
                Log("getLocalizadores", "Error: " + ex.Message)
            End Try

        End Using

        Return Localizadores

    End Function
    
    Private Sub LoadCheckBoxListItems(ByVal checkBoxList As CheckBoxList, ByVal savedValues As String)
        If Not String.IsNullOrEmpty(savedValues) Then
            Dim values As String() = savedValues.Split(";"c)
            For Each value As String In values
                Dim item As ListItem = checkBoxList.Items.FindByValue(value)
                If item IsNot Nothing Then
                    item.Selected = True
                End If
            Next
        End If
    End Sub

</script>