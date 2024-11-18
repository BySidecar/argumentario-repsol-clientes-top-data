<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="Site.Master" Debug="true"%>

<%@ Import Namespace="Icr.Evolution.EvolutionLibrary.Models" %>
<%@ Import Namespace="System.Data.Odbc" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="ICR.Evolution.ScriptServer" %>
<%@ Import Namespace="EvoLib=ICR.Evolution.EvolutionLibrary" %>
<%@ Import Namespace="ICR.Comun" %>
<%@ Import Namespace="ICR.Evolution.TZ.Services" %>
<%@ Import Namespace="ICR.Evolution.Types.TZ" %>

<%@ Register assembly="VisualEvolutionLibrary" namespace="Icr.Evolution.VisualEvolutionLibrary" tagprefix="evo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Replanificación
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <table class="formulario-cal" style="width:98%;">
        <thead>
            <tr>
                <th colspan="2" style="text-align:center">
                    Replanificación [<%= wrapUpCodeDescripcion%>]
                </th>
            </tr>
        </thead>
        <tbody>
		    <tr style="height:100px";>
			    <td style="font-weight:bold;text-align:left; width: 250px;">
                    Validez:

                 <span style="font-weight:normal;">&nbsp;<%=FInicioValidez%></span> 
                 a 

                 <span style="font-weight:normal;"><%=FFinalValidez %></span> 
                 <br />
                 Horario cliente:

                 <span style="font-weight:normal;">&nbsp;<%=HDesde%>h</span>
                 a 

                 <span style="font-weight:normal;"><%=HHasta%>h</span>
                 <br />
                <%If sCalendCampanya.Length > 0 Then%>
                Calendario: 

                <span style="font-weight:normal;"><%=sCalendCampanya%></span>
                <%End If%>
                </td>
			    <td  style="font-weight:bold;text-align:center">
                     <%If calSchedule.SelectedDate.Year > 1 Then%>
                           <span style="font-size:small;  font-weight:bold">
                           Reprogramar llamada para el día 
                           </span>
                           <span id="FechaReprog" style="font-size:small;  font-weight:bold; color:Blue">
                           <%=calSchedule.SelectedDate.ToShortDateString() %>
                           </span>
                           <span style="font-size:small;  font-weight:bold">
                           a las 
                           </span>
                           <span id="HoraReprog" style="font-size:small;  font-weight:bold; color:Blue">
                           <%=SelectedTime.Value%>
                           </span>
                            <!-- TimeZone del cliente -->
                           <%If Not IsNothing(EvoAPI.Customer.TimeZone) Then%>
                               <span title="<%=tzFullName %>" style="font-size:small;  font-weight:bold; color:Blue"><%=tzShortName%></span>
                               <span style="font-size:small;  font-weight:bold">
                                Sist:
                               </span>
                               <span id="FechaHoraSistema" style="font-size:small;  font-weight:bold; color:Blue">
                               <%=ToSystemTZDateTime(calSchedule.SelectedDate, SelectedTime.Value).ToString("dd/MM/yyyy HH:mm\h")%>
                               </span>
                           <%End If%>

                           <span style="font-size:small;  font-weight:bold">
                            <%=Asignacion%>
                           </span>
                     <%Else
                             bEnableScheduleButton = False%>
                            
                           <span style="font-size:small;  font-weight:bold">
                                Las restricciones de tiempo no permiten programar la rellamada para ninguna hora este día! 
                           </span>
                     <%End If%>
                </td>
		    </tr>
		    <tr>
			    <td width="250px" valign="top" >				    
                    <div style = "width: 245px; margin-left:auto; margin-right: auto;">
                        <div id="calendar">
                        <asp:Calendar ID="calSchedule" runat="server" 
                            BackColor="White"
                            BorderColor="#2FB5DB" BorderWidth="1px" CellPadding="0" 
                            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                            ForeColor="#646D8A" Height="250px" Width="245px" BorderStyle="None" 
                            ShowGridLines="True" NextMonthText="&gt;" CssClass="calendar" TabIndex="10" 
                                onselectionchanged="calSchedule_SelectionChanged" 
                                OnDayRender="DisabledWeekendsCalendar_DayRender">
                                <DayHeaderStyle BackColor="White" ForeColor="Black" Height="15px" 
                                    BorderColor="#097AA4" BorderStyle="None" HorizontalAlign="Center" />
                                <DayStyle BorderColor="#2FB5DB" BorderStyle="None" HorizontalAlign="Center" 
                                    CssClass="calendar" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="Black" BackColor="White" 
                                    Height="15px" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#FFE7BB" Font-Bold="True" ForeColor="#646D8A" 
                                    BorderColor="#2FB5DB" BorderStyle="Solid" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <TitleStyle BackColor="White" BorderColor="White" BorderWidth="2px" 
                                    Font-Bold="True" Font-Size="10pt" Height="15px" BorderStyle="None" 
                                    ForeColor="Black" HorizontalAlign="Center" />
                                <TodayDayStyle BackColor="#E4F2F5" ForeColor="#646D8A" />                        
                                <WeekendDayStyle BackColor="#C1DEE6" />
                        </asp:Calendar>    
                        </div>                                                                         
                        <asp:CustomValidator ID="valCalendar" runat="server" OnServerValidate="DateCustVal_Validate"
                            ErrorMessage="Fecha incorrecta"></asp:CustomValidator>    
                        <asp:HiddenField ID="SelectedTime" runat="server" value="00:00" />
                        <asp:CustomValidator ID="valTime" runat="server" OnServerValidate="TimeCustVal_Validate"
                                    ErrorMessage="No puede seleccionar una hora anterior a la actual"></asp:CustomValidator> 

                        <%If Request("bMostrarIntervalo") = "1" Then%>

                            <div>
                                Intervalo (minutos):

                                <asp:DropDownList ID="ddlInterval" runat="server">
                                </asp:DropDownList>
                            </div>                             
                        <%End If%>
                    </div>
			    </td>
                <td valign="top">

				        <table width="99%" style="table-layout: fixed;">
				            
                            <tr>
                                
				                <td style="width: 45px;top: -43px; position: relative;">
                                    <span style="font-size:smaller" title="<%=tzFullName %>"><%=tzShortName%></span>
                                    <br />
                                    <br />
                                    Agente
                                    <br />
                                    Grupo

                                </td>
                                <td>
				                    <div id="scheduleDiv" style="overflow-x:auto; width:100%; height: 90px;">
				                        
                                        <asp:GridView ID="GridView1" runat="server" BackColor="White" 
                                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                            EnableModelValidation="True" 
                                            onrowcreated="GridView1_RowCreated" ShowHeader="False" Width="100%" 
                                            CssClass="schedule">
                                            <AlternatingRowStyle BackColor="#DEEBEF"/>
                                            <EmptyDataRowStyle BorderStyle="Solid" />
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <RowStyle ForeColor="#000066"/>
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        </asp:GridView>
                                    </div>
                                    <br />
				                </td>
				            </tr>
                        </table>
                        <table width="98%" style="margin-left: 6px; background-color: #fdfdfb">
                            <tr>
				                <td colspan="2" style="font-weight:bold;text-align:left">
				                    Teléfonos de contacto:
                                </td>
				            </tr>
                            <tr>
                                <td colspan="2"  style="color:Orange; font-weight: bold;">
                                Puede forzarse un teléfono para las siguientes llamadas.<br />

                              
                                   O dejarse vacío para que el sistema seleccione el siguiente teléfono automáticamente.
                               
                                </td>
                            </tr>
					        <tr>
						        <td valign="bottom" style="width: 150px;">Nuevo tlf. forzado:</td>
						        <td>
                                    <asp:TextBox ID="tbxPhone" runat="server" TabIndex="40"></asp:TextBox>
                                    <input type="button" value="Borrar" onclick="SetPhone('');" tabindex="41"/>                                    
                                </td>
					        </tr>                            
					        <tr>
                                <td colspan="2" style="border-bottom: 1px solid #29AFD5">
                                <asp:CustomValidator ID="valPhone" runat="server" OnServerValidate="PhoneCustVal_Validate"
                                    ErrorMessage="Invalid phone"></asp:CustomValidator> 
                                </td>
                            </tr>                        
					        <tr>
						        <td style="width: 150px;">Último tlf. usado:</td>						        
                                <td>
                                    <a href="#" onclick="SetPhone(<%= EvoAPI.Transaction.CurrentLocator%>);"><%= EvoAPI.Transaction.CurrentLocator%></a>
                                </td>
					        </tr>					        						        
                            <% 
                                Dim locators = EvoAPI.Customer.Locators.Where(Function(l) Not l.LocatorValue.Equals(EvoAPI.Transaction.CurrentLocator)).OrderBy(Function(l) l.LocatorValue)
                                If locators.Count > 0 Then
                            %>
					        <tr>
                                <td style="width: 150px;">Otros teléfonos:</td>
						        <td >
                                 <% For i = 0 To locators.Count - 1 %>
                                    <a href="#" onclick="SetPhone('<%= locators.ElementAt(i).LocatorValue%>');"><%= locators.ElementAt(i).LocatorValue%></a>&nbsp;&nbsp;
                                 <%Next%>
                                 </td>
                            </tr>
                                <%End If%>
                            <%If hdnWrapUpCodePlanificacionAgente.Value = "2" Then%>
                            <tr>
				                <td colspan="2" style="font-weight:bold;text-align:left">
				                    Elija gestor al que realizar la programación:</td>
				            </tr>
                            <tr>
                                <td colspan="2" style="border-bottom: 1px solid #29AFD5">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:DropDownList ID="DropDownList1" runat="server" 
                                        DataSourceID="SqlDataSource1" Height="20px" Width="400px" 
                                        onselectedindexchanged="AgenteAsignadoSeleccionado" 
                                        DataTextField="AGENTE" DataValueField="IDUSUARIO" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <%End If%>
                        </table>
			    </td>
            </tr>       
            <tr>
                 <td style="font-weight:bold; vertical-align: middle; text-align: right; padding-right: 10px;">
                 Observaciones:</td>   
                 <td height="90">     
                    <evo:DatosCliente_TextBox ID="DatosCliente_Observations" runat="server" 
                        AtributoCliente="Observaciones" TipoTextBox="MultiLine"  
                        EtiquetaAuto="False" Width="98%" style="margin:10px;" Height="70px"/>
                    <div id="info">Máximo 255 caracteres</div>
                </td>
            </tr>
            <tr>   
          
			    <td style="text-align: right; padding-right: 40px;">				                                
              </td>
                <td style="text-align: center;">
                    <asp:Button ID="btnCloseTransaction" runat="server" Text="Reprogramar y finalizar" 
                        onclick="btnCloseTransaction_Click" Width="150px" TabIndex="100" />                                
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
			          <input type="button" value="Cancelar" 
                        onclick="<%= IIf(String.IsNullOrEmpty(ViewState("PreviousPageUrl")), "", "window.location='" & ViewState("PreviousPageUrl") & "'")%>"                         
                        style="width:150px" tabindex="101"/>
                </td>
		    </tr>
        </tbody>        
    </table>
    
    <asp:HiddenField ID="hdnWrapUpCodePlanificacionAgente" runat="server" />     
    <asp:HiddenField ID="hdnWrapUpCodeDescripcion" runat="server" />    

    <script language="javascript" type="text/javascript">

        // Fecha de reprogramación en base a la TZ del cliente
        customerDateTime=<%=jscustomerDateTime %>;


        function ValidarCaracteres(Control, elEvento, maximoCaracteres) {
            // Obtenemos la tecla pulsada
            var unicode = elEvento.keyCode ? elEvento.keyCode : elEvento.charCode;

            // Permitimos las siguientes teclas:
            // 8 backspace
            // 46 suprimir
            // 37 izquierda
            // 39 derecha
            // 38 subir
            // 40 bajar
            if (unicode == 8 || unicode == 46 || unicode == 37 || unicode == 39 || unicode == 38 || unicode == 40)
                return true;

            // Si ha superado el limite de caracteres devolvemos false
            if (Control.value.length >= maximoCaracteres) {
                Control.value = Control.value.substring(0, (maximoCaracteres - 1));
                return false;
            }

            return true;
        }

        function ActualizaInfo(Control, maximoCaracteres) {
            var info = document.getElementById("info");

            if (Control.value.length == 0) {
                info.innerHTML = "Máximo " + maximoCaracteres + " caracteres";
            }
            else if (Control.value.length <= maximoCaracteres) {
                info.innerHTML = "Puedes escribir hasta " + (maximoCaracteres - Control.value.length) + " caracteres adicionales";
            }
            else {
                info.innerHTML = "¡¡¡ TAMAÑO MÁXIMO EXCEDIDO !!!, se truncarán los últimos " + (Control.value.length - maximoCaracteres) + " caracteres";
            }
        }

        window.onload = function () 
        {
            var ColWidth = 91;
            var divObj = document.getElementById("scheduleDiv");
            if (divObj) 
            {
                // Ancho columna * Hora de inicio * (Minutos/hora) / Gap del visor
                divObj.scrollLeft = ColWidth + ( ColWidth / (60 / <%= schedule_viewer_gap() %>) ) * <%= schedule_viewer_init_hour() %> * 60 / <%= schedule_viewer_gap() %>;
            }
        }
        
        function pad(num, size) {
           var s = "000000000" + num;
           return s.substr(s.length-size);
        }
        
        function ClickCelda(e,fila,col,hora)
        {
            // Calcular la nueva hora en terminos de la TZ del cliente
            newCustomerDateTime=new Date(customerDateTime.getFullYear(),customerDateTime.getMonth()+1,customerDateTime.getDate(),parseInt(hora.substr(0,2)),parseInt(hora.substr(3,2)));
            // Calcular la nueva fecha/hora en términos de la TZ de sistema
            newCustomerDateTime=new Date(newCustomerDateTime.getTime()-(<%=jsTZShift %>));

            // Pintar la hora seleccionada en azul
            var t=document.getElementById('<%=GridView1.ClientID %>');
            for(var i=0; i<t.rows[fila+1].cells.length; i++)
               {
               if (t.rows[1].cells[i].getAttribute("data-selected")==="true")
                    {
                    t.rows[1].cells[i].style.backgroundColor="";
                    t.rows[2].cells[i].style.backgroundColor="";
                    t.rows[1].cells[i].removeAttribute("data-selected");
                    }
               }
            t.rows[1].cells[col].style.backgroundColor="<%=colorSelected%>";
            t.rows[2].cells[col].style.backgroundColor="<%=colorSelected%>";
            t.rows[1].cells[col].setAttribute("data-selected","true");
            t.rows[2].cells[col].setAttribute("data-selected","true");

            // Actualizar labels de hora y minutos seleccionados
            var domHoraReprog=document.getElementById('HoraReprog');
            var domSelectedTime=document.getElementById('<%=SelectedTime.ClientID %>');
            domSelectedTime.value = hora.substring(0, 2) + ":";
            domSelectedTime.value=domSelectedTime.value+hora.substring(3,5);
            domSelectedTime.value=domSelectedTime.value+"h";
            domHoraReprog.innerHTML=domSelectedTime.value;
           <%If Not IsNothing(EvoAPI.Customer.TimeZone) Then%>
                var domFechaHoraSistema=document.getElementById('FechaHoraSistema');
                domFechaHoraSistema.innerHTML=pad(newCustomerDateTime.getDate(),2)+"/"+pad(newCustomerDateTime.getMonth()+1,2)+"/"+pad(newCustomerDateTime.getFullYear(),4)+
                    " "+pad(newCustomerDateTime.getHours(),2)+":"+pad(newCustomerDateTime.getMinutes(),2)+"h";
           <%End if %>

        }
    </script>

    <asp:SqlDataSource
        id="SqlDataSource1"
        runat="server"
        DataSourceMode="DataReader"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
    </asp:SqlDataSource>
                                    
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FooterContent" runat="server">
    <script type="text/javascript">
        function SetPhone(phone) {
            document.getElementById('<%= tbxPhone.ClientID %>').value = phone;
        }
        function ToggleShowConditions() {
            if (document.getElementById('Condiciones').style.display == "none")
                document.getElementById('Condiciones').style.display = "block"
            else
                document.getElementById('Condiciones').style.display = "none";

        }
    </script>
</asp:Content>


<script runat="server">    
    Dim idWrapUpCode As String
    Dim wrapUpCodeDescripcion As String
    Dim wrapUpCode As CallDisposition
    Dim FInicioValidez As String = ""
    Dim FFinalValidez As String = ""
    Dim DtInicioValidez As Date
    Dim DtFinalValidez As Date
    Dim HDesde As String = ""
    Dim HHasta As String = ""
    Dim Asignacion As String
    Dim sCalendCampanya As String
    Dim idAgenteAsignado As Long
    Dim tzShortName As String
    Dim tzFullName As String 
    Dim tzSysShortName As String
    Dim tzSysFullName As String
    Dim jscustomerDateTime As String = "null"
    Dim jsTZShift As String = "0"
    Dim bEnableScheduleButton As Boolean = True
    
    Const colorSelected As String = "#b2c2f0" 'Color de la celda de calendario seleccionada
    Const colorForbidden As String = "#e6b8b8" 'Color de la celda de calendario que no se puede seleccionar


    
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Forzar recarga de condiciones de calendario
        EvoAPI.Campaign.LoadCampaignCalendar()

        'Obtener el nombre del calendario de campaña si existe
        sCalendCampanya = ""
        Dim dtrs As ICR.Evolution.ScriptServer.DataTableRS
        dtrs = AdoNet.ExecuteSQLRS(EvoLib.Configuration.EvolutionDbConnectionString, "SELECT s.Name FROM CAMPANYA c with (nolock) JOIN tbSchedule s ON s.idSchedule=c.idSchedule WHERE c.idCampanya=" + EvoAPI.Campaign.CampaignId.ToString)
        If Not dtrs.EOF() And Not dtrs.BOF() Then
            sCalendCampanya = dtrs.Item(0).ToString()
        End If
        dtrs.Close()
        EvoAPI.LoadCustomer(Gestion.Cliente.IdSujeto)

        ' Obtener datos de ISC (restricciones de horario de cliente)
        ObtenerDatosISC()

        idWrapUpCode = Request("idFinal")

        ' Mirar la asignación del final Volver a llamar
        MirarAsignacion()

        If Not IsPostBack AndAlso Not IsCallback AndAlso String.IsNullOrEmpty(Convert.ToString(ViewState("PreviousPageUrl"))) Then

            If Request Is Nothing OrElse Request.UrlReferrer Is Nothing Then
                ViewState("PreviousPageUrl") = ""
            Else
                ViewState("PreviousPageUrl") = Request.UrlReferrer.ToString()
            End If

            ValidateInput()

            SetColtrolsData()

            hdnWrapUpCodePlanificacionAgente.Value = wrapUpCode.AgentCallBack.ToString
            hdnWrapUpCodeDescripcion.Value = wrapUpCodeDescripcion

            ShowDaySchedule()

        End If

        wrapUpCodeDescripcion = hdnWrapUpCodeDescripcion.Value

        If Not IsPostBack Then
            ' Obtener agentes BACK a los que poder agendar la rellamada, listarlos sobre DropDownList1
            ObtenerAgentesBack()

            'Deshabilita el control RegularExpressionValidator incrustado en observaciones
            'Establecemos un control por js para su tamaño máximo 255
            For Each control As WebControl In DatosCliente_Observations.Controls

                If (TypeOf control Is RegularExpressionValidator) Then
                    CType(control, RegularExpressionValidator).Enabled = False
                ElseIf (TypeOf control Is TextBox) Then
                    CType(control, TextBox).Attributes.Add("onkeypress", " ValidarCaracteres(this, event, 255);")
                    CType(control, TextBox).Attributes.Add("onkeyup", " ActualizaInfo(this, 255);")
                End If
            Next
        End If
        
        tzShortName = If(IsNothing(EvoAPI.Customer.TimeZone), "", EvoAPI.Customer.TimeZone.Abbreviation)
        tzFullName = If(IsNothing(EvoAPI.Customer.TimeZone), "", EvoAPI.Customer.TimeZone.AuxLabelZoneName)
            
    End Sub


    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        
        'Inicializar la fecha/hora de reprogramación que pasaremos a Javascript
        jscustomerDateTime = String.Format("new Date({0},{1},{2},{3},{4})", calSchedule.SelectedDate.Year, calSchedule.SelectedDate.Month, calSchedule.SelectedDate.Day, SelectedTime.Value.Substring(0, 2), SelectedTime.Value.Substring(3, 2))
        
        If Not IsNothing(EvoAPI.Customer.TimeZone) Then
            jsTZShift = EvoAPI.Customer.TimeZone.LocalShift.TotalMilliseconds.ToString()
        End If
        
    End Sub

    Protected Sub ObtenerDatosISC()
        Dim dtISC As DataTable
        Dim Sql As String

        Sql = "select * from tbIdentidadSujetoCampanya WHERE IDSUJETO=" + EvoAPI.Customer.CustomerId.ToString
        dtISC = AdoNet.ExecuteSQL(EvoLib.Configuration.EvolutionDbConnectionString, Sql)
        If dtISC.Rows.Count() > 0 Then
            HDesde = String.Format("{0:00}:{1:00}", Math.Truncate(Int32.Parse(dtISC.Rows(0).Item("Llamar_desde").ToString) / 100), Int32.Parse(dtISC.Rows(0).Item("Llamar_desde").ToString) Mod 100)
            HHasta = String.Format("{0:00}:{1:00}", Math.Truncate(Int32.Parse(dtISC.Rows(0).Item("Llamar_hasta").ToString) / 100), Int32.Parse(dtISC.Rows(0).Item("Llamar_hasta").ToString) Mod 100)
            FInicioValidez = Date.Parse(dtISC.Rows(0).Item("TInicioValidez").ToString).ToShortDateString()
            DtInicioValidez = Date.Parse(dtISC.Rows(0).Item("TInicioValidez").ToString)
            FFinalValidez = Date.Parse(dtISC.Rows(0).Item("TFinalValidez").ToString).ToShortDateString()
            DtFinalValidez = Date.Parse(dtISC.Rows(0).Item("TFinalValidez").ToString)
            idAgenteAsignado = Convert.ToInt64(dtISC.Rows(0).Item("idAgenteAsignado").ToString)
        End If

    End Sub


    Protected Sub MirarAsignacion()
        Asignacion = ""
        For Each final As Icr.Evolution.EvolutionLibrary.Models.CallDisposition In EvoAPI.Campaign.CallDispositions
            If final.CallDispositionId = Convert.ToInt64(idWrapUpCode) Then
                If final.AgentCallBack = 0 Then
                    Asignacion = "to group"

                    Exit For
                End If
                If final.AgentCallBack = 1 Then
                    Asignacion = "to agent"

                    Exit For
                End If
                If final.AgentCallBack = 2 Then
                    If idAgenteAsignado = 0 Then
                        Asignacion = "to group"

                    Else
                        Asignacion = "to agent"

                    End If
                    Exit For
                End If
            End If
        Next

    End Sub

    ' Convierte un día y hora expresados en TZ Cliente a una fecha expresada en la TZ de sistema
    Protected Function ToSystemTZDateTime(ByVal dia As Date, ByVal hora As String) As Date
        Dim mm = 0
        Dim hh = 0
        
        If Not Integer.TryParse(hora.Left(2), hh) Then
            hh = 0
        End If
        If Not Integer.TryParse(hora.Substring(3, 2), mm) Then
            mm = 0
        End If
        Dim dt As Date = New Date(dia.Year, dia.Month, dia.Day, hh, mm, 0)
        
        Return ToSystemTZDateTime(dt)
    End Function

    Protected Function ToSystemTZDateTime(ByVal dia As Date) As Date
        Dim tz = EvoAPI.Customer.TimeZone
        Dim currentCustomerShift As TimeSpan = If(tz IsNot Nothing, tz.LocalShift, New TimeSpan(0))
       
       'Si nos pasan el día 1/1/1 quiere decir que no han seleccionado fecha. Si restaramos el Shift se produciría excepción o sea que retornamos Nothing
        If dia.Year = 1 And dia.Month = 1 And dia.Day = 1 Then
            Return Nothing
        End If

        Return dia - currentCustomerShift
    End Function

    'Convierte un dia/hora de sistema en dia/hora de la TZ del cliente
    Protected Function ToCustomerTZDateTime(ByVal dia As Date) As Date
        Dim tz = EvoAPI.Customer.TimeZone
        Dim currentCustomerShift As TimeSpan = If(tz IsNot Nothing, tz.LocalShift, New TimeSpan(0))

        Return dia + currentCustomerShift
    End Function

    
    Protected Sub ObtenerAgentesBack()
        Dim conn As OdbcConnection = New OdbcConnection
        Dim sqlComm As OdbcCommand = New OdbcCommand
        Dim dr As OdbcDataReader
        Dim Item As ListItem

        ' Añadimos ítems siempre presentes
        Item = New ListItem("Previous assignation", "-1")
        Item.Selected = True
        DropDownList1.Items.Add(Item)
        Item = New ListItem("GROUP", "0")
        DropDownList1.Items.Add(Item)

        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionString").ToString
        conn.Open()
        sqlComm.Connection = conn
        sqlComm.CommandType = Data.CommandType.Text

        ' Obtenemos el Skill de agentes BACK para esta campaña
        Dim SkillBACK As String = ""
        EvoAPI.Campaign.GetData("SkillBACK", SkillBACK)
        ' Si está definido
        If Not String.IsNullOrEmpty(SkillBACK) Then
            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> INI select agentes SkillBACK")
            sqlComm.CommandText = "select (USUARIO.NOMBRE + ' ' + USUARIO.APELLIDO1 + ' ' + USUARIO.APELLIDO2) as AGENTE, IDUSUARIO"
            sqlComm.CommandText = sqlComm.CommandText + " from (tbUserSkill with(NOLOCK) inner join tbSkill with(NOLOCK) on tbUserSkill.IdSkill=tbSkill.IdSkill)"
            sqlComm.CommandText = sqlComm.CommandText + " inner join USUARIO with(NOLOCK) on tbUserSkill.IdUser=USUARIO.IDUSUARIO"
            sqlComm.CommandText = sqlComm.CommandText + " where Descripcion='" + SkillBACK + "'"
            sqlComm.CommandText = sqlComm.CommandText + " order by AGENTE"
        Else ' Si no está definido listamos todos los agentes con permisos sobre esta campaña
            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> INI select agentes campaña")
            sqlComm.CommandText = "select (u.NOMBRE + ' ' + u.APELLIDO1 + ' ' + u.APELLIDO2) as AGENTE, u.idUsuario as IDUSUARIO"
            sqlComm.CommandText = sqlComm.CommandText + " from OPORTPART with(NOLOCK)"
            sqlComm.CommandText = sqlComm.CommandText + " inner join GRUPACDCAMPANYA gc with(NOLOCK) on OPORTPART.IDGRUPACD=gc.IDGRUPACD"
            sqlComm.CommandText = sqlComm.CommandText + " inner join GRUPOUSUARIOS g with(NOLOCK) on OPORTPART.idparticipante=g.IDGrupo"
            sqlComm.CommandText = sqlComm.CommandText + " inner join PARTICIPANTE_EN_GRUPOUSUARIOS ug with(NOLOCK) on g.idgrupo=ug.idgrupo"
            sqlComm.CommandText = sqlComm.CommandText + " inner join USUARIO u with(NOLOCK) on u.IDUSUARIO=ug.idparticipante"
            sqlComm.CommandText = sqlComm.CommandText + " where (u.IDTIPO = 0)"
            sqlComm.CommandText = sqlComm.CommandText + " and gc.IDCAMPANYA=" + EvoAPI.Campaign.CampaignId.ToString()
            sqlComm.CommandText = sqlComm.CommandText + " union"
            sqlComm.CommandText = sqlComm.CommandText + " select (u.NOMBRE + ' ' + u.APELLIDO1 + ' ' + u.APELLIDO2) as AGENTE, u.idUsuario as IDUSUARIO"
            sqlComm.CommandText = sqlComm.CommandText + " from OPORTPART with(NOLOCK)"
            sqlComm.CommandText = sqlComm.CommandText + " inner join GRUPACDCAMPANYA gc with(NOLOCK) on OPORTPART.IDGRUPACD=gc.IDGRUPACD"
            sqlComm.CommandText = sqlComm.CommandText + " inner join USUARIO  u with(NOLOCK) on OPORTPART.idparticipante=u.idusuario"
            sqlComm.CommandText = sqlComm.CommandText + " where (u.IDTIPO = 0)"
            sqlComm.CommandText = sqlComm.CommandText + " and gc.IDCAMPANYA=" + EvoAPI.Campaign.CampaignId.ToString()
        End If

        Traces.Debug("Sql: " + sqlComm.CommandText)

        dr = sqlComm.ExecuteReader()

        ' Añadimos ítems según resultados de la query
        While dr.Read
            Item = New ListItem(dr("AGENTE"), dr("IDUSUARIO"))
            DropDownList1.Items.Add(Item)
        End While

        dr.Close()
        conn.Close()
        Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> FIN select agentes")


    End Sub


    Protected Sub DisabledWeekendsCalendar_DayRender(sender As Object, e As DayRenderEventArgs)
        If e.Day.Date < Date.Today Or e.Day.Date < DtInicioValidez Or e.Day.Date > DtFinalValidez OrElse Not TestCampaignSchedule(e.Day.Date, Nothing) Then
            e.Day.IsSelectable = False
            e.Cell.ForeColor = System.Drawing.Color.LightGray
        End If

    End Sub

    Protected Function schedule_viewer_gap() As Integer

        Try
            If ConfigurationManager.AppSettings("schedule-viewer-gap") = [String].Empty OrElse ConfigurationManager.AppSettings("schedule-viewer-gap") Is Nothing Then
                Throw New Exception()
            End If

            Dim gap As Integer

            gap = Convert.ToInt32(ConfigurationManager.AppSettings("schedule-viewer-gap"))

            If gap > 60 Then
                gap = 60
            End If

            If gap < 5 Then
                gap = 5
            End If

            schedule_viewer_gap = gap

        Catch ex As Exception
            schedule_viewer_gap = 15
        End Try

    End Function


    Protected Function schedule_viewer_init_hour() As Integer

        Try
            If ConfigurationManager.AppSettings("schedule-viewer-init-hour") = [String].Empty OrElse ConfigurationManager.AppSettings("schedule-viewer-init-hour") Is Nothing Then
                Throw New Exception()
            End If

            Dim initHour As Integer

            initHour = Convert.ToInt32(ConfigurationManager.AppSettings("schedule-viewer-init-hour"))

            If initHour > 23 Then
                initHour = 23
            End If

            If initHour < 0 Then
                initHour = 0
            End If


            schedule_viewer_init_hour = initHour

        Catch ex As Exception
            schedule_viewer_init_hour = 9
        End Try

    End Function


    Protected Function schedule_viewer_in_list() As String
        Try
            schedule_viewer_in_list = ConfigurationManager.AppSettings("schedule-viewer-in-list")
            If String.IsNullOrEmpty(schedule_viewer_in_list) Then
                schedule_viewer_in_list = "10"
            End If

        Catch ex As Exception
            schedule_viewer_in_list = "10"
            Traces.Trace("Error retrieving AppSetting schedule-viewer-init-hour (defaulting to '10')")
        End Try

    End Function

    Protected Sub GridView1_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.Header Then

            Dim gvr As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
            Dim thc As New TableHeaderCell()

            thc.Wrap = False
            thc.BorderWidth = Unit.Parse("1px")
            'thc.Text = "&nbsp;Asignación&nbsp;"
            'gvr.Cells.Add(thc)

            For hora As Integer = 0 To 23
                'For hora As Integer = HoraIni To HoraFin

                thc = New TableHeaderCell()
                thc.ColumnSpan = 60 / schedule_viewer_gap()
                thc.Wrap = False
                'thc.Width = Unit.Parse("100px")
                thc.BorderWidth = Unit.Parse("1px")

                If hora < 12 Then
                    thc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; " + hora.ToString("00") + " am &nbsp;&nbsp;&nbsp;"
                Else
                    thc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; " + hora.ToString("00") + " pm &nbsp;&nbsp;&nbsp;"
                End If

                gvr.Cells.Add(thc)

            Next

            GridView1.Controls(0).Controls.AddAt(0, gvr)

        End If

    End Sub


    Protected Sub calSchedule_SelectionChanged(sender As Object, e As System.EventArgs)
        AgenteAsignadoSeleccionado(sender, e)
        'ShowDaySchedule()

    End Sub

    Protected Sub ShowDaySchedule()

        Dim dt As DataTable
        Dim sql As String
        Dim gap As Integer
        Dim col_name As String
        Dim cols_raw As String
        Dim cols_format As String
        Dim in_list As String

        gap = schedule_viewer_gap()
        in_list = schedule_viewer_in_list()

        For hour As Integer = 0 To 23
            For min As Integer = 0 To 59 Step gap
                col_name = "[" + hour.ToString("00") + ":" + min.ToString("00") + "]"
                cols_raw = cols_raw + col_name + ","
                cols_format = cols_format + "nullif(" + col_name + ", 0) as " + col_name + ","
            Next
        Next

        Dim tz = EvoAPI.Customer.TimeZone
        Dim currentCustomerShift As Double = If(tz IsNot Nothing, tz.LocalShift.TotalSeconds, 0)
                
        cols_raw = cols_raw.Substring(0, cols_raw.Length - 1)
        cols_format = cols_format.Substring(0, cols_format.Length - 1)

        'Calcular la fecha desde el punto de vista del cliente de la gestion actual (TPROXCONTACTOCalculado = TPROXCONTACTO + shiftClienteGestionActual - shiftOtroCliente)
        Dim calculatedTProxContacto As String = " dateadd(ss, " + currentCustomerShift.ToString() + " - tz.LocalShift, TPROXIMOCONTACTO) "

        sql = "SELECT [Asignación], " + cols_format + " FROM ( "
        sql = sql + "SELECT [Asignación], " + cols_raw + " FROM (select 'Al Agente' as [Asignación], REPLICATE( '0', 2-DATALENGTH( CAST( datepart(hour, " + calculatedTProxContacto + ") as varchar) ) ) +  CAST( datepart(hour, " + calculatedTProxContacto + ") as varchar) + ':' + REPLICATE( '0', 2-DATALENGTH(CAST((datepart(MINUTE, " + calculatedTProxContacto + ")/" + gap.ToString() + ")*" + gap.ToString() + " as varchar)) ) + CAST((datepart(MINUTE, " + calculatedTProxContacto + ")/" + gap.ToString() + ")*" + gap.ToString() + " as varchar) as Hora, IDSUJETO from tbIdentidadSujetoCampanya as isc with (nolock) left join TZ_Shift AS tz on isc.IdTimeZoneShift = tz.IdTimeZoneShift where DATEADD(dd, 0, DATEDIFF(dd, 0, " + calculatedTProxContacto + ") ) = CONVERT (datetime, '" + calSchedule.SelectedDate.ToString("dd/MM/yyyy") + "', 103)  and IDAGENTEASIGNADO = " + If(idAgenteAsignado = 0, EvoAPI.Agent.AgentId.ToString(), idAgenteAsignado.ToString()) + " and nEstado=0 and nLista in (" + in_list + ") and idCampanya = " + EvoAPI.Campaign.CampaignId.ToString() + " ) as SourceTable1 PIVOT ( count(IDSUJETO) FOR Hora IN ( " + cols_raw + " ) ) AS PivotTable1"
        sql = sql + " union "
        sql = sql + "SELECT [Asignación], " + cols_raw + " FROM (select 'Al Grupo' as [Asignación], REPLICATE( '0', 2-DATALENGTH( CAST( datepart(hour, " + calculatedTProxContacto + ") as varchar) ) ) +  CAST( datepart(hour, " + calculatedTProxContacto + ") as varchar) + ':' + REPLICATE( '0', 2-DATALENGTH(CAST((datepart(MINUTE, " + calculatedTProxContacto + ")/" + gap.ToString() + ")*" + gap.ToString() + " as varchar)) ) + CAST((datepart(MINUTE, " + calculatedTProxContacto + ")/" + gap.ToString() + ")*" + gap.ToString() + " as varchar) as Hora, IDSUJETO from tbIdentidadSujetoCampanya as isc with (nolock) left join TZ_Shift AS tz on isc.IdTimeZoneShift = tz.IdTimeZoneShift where DATEADD(dd, 0, DATEDIFF(dd, 0, " + calculatedTProxContacto + ") ) = CONVERT (datetime, '" + calSchedule.SelectedDate.ToString("dd/MM/yyyy") + "', 103)  and IDAGENTEASIGNADO = 0 and nEstado=0 and nLista in (" + in_list + ") and idCampanya = " + EvoAPI.Campaign.CampaignId.ToString() + " ) as SourceTable2 PIVOT ( count(IDSUJETO) FOR Hora IN ( " + cols_raw + " ) ) AS PivotTable2"
        sql = sql + " ) as temp"

        Traces.Debug("select asignacion SQL: " + sql)
        dt = AdoNet.ExecuteSQL(EvoLib.Configuration.EvolutionDbConnectionString, sql)

        GridView1.RowStyle.BackColor = Drawing.Color.White

        Dim dtOrdered As New DataTable

        dtOrdered = dt.Clone
        dtOrdered.Clear()

        If dt.Rows.Count = 1 Then

            If dt.Rows(0)(0) = "Al Grupo" Then

                Dim AgentRow As DataRow = dtOrdered.NewRow
                AgentRow(0) = "Al Agente"
                dtOrdered.Rows.Add(AgentRow)

                dtOrdered.ImportRow(dt.Rows(0))

            Else
                dtOrdered.ImportRow(dt.Rows(0))

                Dim GroupRow As DataRow = dtOrdered.NewRow
                GroupRow(0) = "Al Grupo"
                dtOrdered.Rows.Add(GroupRow)

            End If

        ElseIf dt.Rows.Count = 0 Then
            Dim dr As DataRow = dtOrdered.NewRow
            dr(0) = "Al Agente"

            dtOrdered.Rows.Add(dr)
            dr = dtOrdered.NewRow
            dr(0) = "Al Grupo"

            dtOrdered.Rows.Add(dr)
        ElseIf dt.Rows.Count = 2 Then
            dtOrdered = dt.Copy
        End If

        'Quitar la columna de asignación
        dtOrdered.Columns.RemoveAt(0)

        GridView1.DataSource = dtOrdered
        GridView1.DataBind()

        Dim i = 0, j = 0, hora = 0, mi = 0
        Dim b As Boolean
        Dim iSelected As Integer = -1
        
        Dim Ahora = ToCustomerTZDateTime(Date.Now)
        Dim customDate As Date
 
        For Each r As GridViewRow In GridView1.Rows
            j = 0
            hora = 0
            mi = 0
            For Each c As TableCell In r.Cells

                ' Deshabilitar las horas fuera de rango de cliente
                b = Integer.Parse(HDesde.Left(2)) < hora Or (Integer.Parse(HDesde.Left(2)) = hora And Integer.Parse(HDesde.Substring(3)) <= mi)
                ' La hora límite consideramos la que ha dicho el cliente menos 1 minuto (o sea, si dice hasta las 19h no le podemos llamar a las 19h, sí a las 18:59)
                b = b And (hora < Integer.Parse(HHasta.Left(2)) Or (Integer.Parse(HHasta.Left(2)) = hora And mi < Integer.Parse(HHasta.Substring(3))))

                ' Si han seleccionado el día de hoy...
                If calSchedule.SelectedDate = Ahora.Date Then
                    ' Deshabilitar las horas del día que ya han transcurrido
                    If hora < Ahora.Hour Then
                        b = False

                    ElseIf hora = Ahora.Hour And mi < Ahora.Minute Then
                        b = False


                    End If
                End If

                ' Deshabilitar las horas fuera de calendario de campaña TO-DO
                If b Then
                    customDate = ToSystemTZDateTime(calSchedule.SelectedDate, hora.ToString("D2") + ":" + mi.ToString("D2"))
                    b = TestCampaignSchedule(customDate, customDate)
                End If


                If b Then

                    c.Attributes("onclick") = "javascript:ClickCelda(this," + i.ToString() + "," + j.ToString() + ",'" + hora.ToString("D2") + ":" + mi.ToString("D2") + "');"
                    c.Attributes("style") += "cursor:pointer;cursor:hand;"
                    If iSelected < 0 Then
                        iSelected = j

                        'Inicializar la hora de selección
                        SelectedTime.Value = hora.ToString("D2") + ":" + mi.ToString("D2") + "h"
                    End If
                Else
                    c.Attributes("style") = "background-color:" + colorForbidden + ";"
                End If
                j = j + 1
                mi += gap

                If mi >= 60 Then
                    hora += 1
                    mi = 0
                End If
            Next
            i = i + 1
        Next

        If iSelected >= 0 Then
            ' Marcar como seleccionada la columna iSelected
            GridView1.Rows(0).Cells(iSelected).Attributes("style") += "background-color:" + colorSelected + ";"
            GridView1.Rows(1).Cells(iSelected).Attributes("style") += "background-color:" + colorSelected + ";"
            GridView1.Rows(0).Cells(iSelected).Attributes("data-selected") = "true"
            GridView1.Rows(1).Cells(iSelected).Attributes("data-selected") = "true"
        Else
            'No hay ninguna hora seleccionable en el día de hoy, deseleccionar fecha
            calSchedule.SelectedDates.Clear()
        End If
    End Sub

    Protected Sub SetColtrolsData()
        Dim minutesStep As Integer = schedule_viewer_gap()

        Dim dtNextContact = ("" + Request("tProxContacto")).Replace("T", " ").ToDateTimeRellamada()
        
        Dim Ahora = ToCustomerTZDateTime(Date.Now)
        
        Dim dtCalendar = dtNextContact.GetValueOrDefault(Ahora)

        ' Date
        calSchedule.SelectedDate = dtCalendar.Date
        calSchedule.VisibleDate = dtCalendar.Date

        ' Calling interval        
        If Request("bMostrarIntervalo") = "1" Then
            For i = 5 To 60 Step minutesStep
                ddlInterval.Items.Add(New ListItem(i.ToString("00")))
            Next

            Dim interval As Integer = IIf(Integer.TryParse(Request("Intervalo"), interval), interval, 60)
            ddlInterval.SelectedIndex = Math.Round(interval / minutesStep) Mod (60 / minutesStep)
        End If

        ' Current phone
        tbxPhone.Text = EvoAPI.Customer.Phone
    End Sub

    ' Validation of input data
    Protected Sub ValidateInput()
        If EvoAPI.Customer.CustomerId = 0 Then
            Message.ShowError("No se puede replanificar una llamada para un sujeto anonimo.")

        End If

        'Dim idWrapUpCode = Request("idFinal")
        'Dim wrapUpCode = Gestion.Campanya.Finales.FirstOrDefault(Function(f) f.IdFinal = idWrapUpCode)
        wrapUpCode = EvoAPI.Campaign.CallDispositions.FirstOrDefault(Function(f) f.CallDispositionId = idWrapUpCode)
        If wrapUpCode Is Nothing Then
            Message.ShowError("El final aplicado a la gestión no existe en la campaña activa.")

        ElseIf wrapUpCode.CallDispositionClass <> 3 Then
            Message.ShowError("El final aplicado a la gestión no admite replanificación de llamadas.")

        End If

        wrapUpCodeDescripcion = wrapUpCode.Description
    End Sub

    ' Calendar selected date validation
    Protected Sub DateCustVal_Validate(ByVal source As Object, ByVal args As ServerValidateEventArgs)
        If calSchedule.SelectedDate = Nothing Then
            valCalendar.ErrorMessage = "La fecha no puede estar en blanco"
            args.IsValid = False
            Return
        End If
        Dim Ahora = ToCustomerTZDateTime(Date.Now)

        If calSchedule.SelectedDate.Date < Ahora.Date Then
            valCalendar.ErrorMessage = "No puede seleccionar una fecha anterior al día en curso"

            args.IsValid = False
            Return
        End If
        args.IsValid = True
    End Sub

    ' Time validation
    Protected Sub TimeCustVal_Validate(ByVal source As Object, ByVal args As ServerValidateEventArgs)
        Dim sHora, sMin As String
        sMin = ""
        sHora = ""
        If SelectedTime.Value.Length >= 5 Then
            sHora = SelectedTime.Value.Substring(0, 2)
            sMin = SelectedTime.Value.Substring(3, 2)
        End If

        Dim Ahora = ToCustomerTZDateTime(Date.Now)
        If String.IsNullOrEmpty(sHora) Or String.IsNullOrEmpty(sMin) Then
            args.IsValid = False
            valTime.ErrorMessage = "No se ha seleccionado un día/hora para programar la llamada."

            Return
        End If
        Dim dtSchedule = New Date(calSchedule.SelectedDate.Year, calSchedule.SelectedDate.Month, calSchedule.SelectedDate.Day, Convert.ToInt32(sHora), Convert.ToInt32(sMin), 0)
        args.IsValid = Not valCalendar.IsValid OrElse dtSchedule > Ahora
    End Sub

    ' Phone number validation
    Protected Sub PhoneCustVal_Validate(ByVal source As Object, ByVal args As ServerValidateEventArgs)
        If String.IsNullOrWhiteSpace(tbxPhone.Text) Then
            If EvoAPI.Customer.Locators.Count = 0 Then
                valPhone.ErrorMessage = "El teléfono forzado no puede estar en blanco"

                args.IsValid = False ' Empty phone and no locators
                Return
            End If
            args.IsValid = True
            Return
        End If

        Dim regex = New Regex(IIf(String.IsNullOrWhiteSpace(Request("sMascara")), "^[0-9]+$", Request("sMascara")))
        If Not regex.IsMatch(tbxPhone.Text) Then
            valPhone.ErrorMessage = "Formato incorrecto del teléfono" + IIf(String.IsNullOrWhiteSpace(Request("sMascara")), "", ". Máscara: " + Request("sMascara"))
            args.IsValid = False ' sMascara or Numeric format requiered
            Return
        End If

        args.IsValid = True
    End Sub

    Protected Sub btnCloseTransaction_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If bEnableScheduleButton AndAlso valCalendar.IsValid AndAlso valPhone.IsValid AndAlso valTime.IsValid Then
            ' Save phone and comments            
            EvoAPI.Customer.Phone = tbxPhone.Text
            'Gestion.Cliente.Observaciones = DatosCliente_Observations.TextValue
            EvoAPI.Customer.Save()
            Guardar_Observacion(sender, e)
            
            Dim dtSchedule = New Date(calSchedule.SelectedDate.Year, calSchedule.SelectedDate.Month, calSchedule.SelectedDate.Day, Convert.ToInt32(SelectedTime.Value.Left(2)), Convert.ToInt32(SelectedTime.Value.Substring(3, 2)), 0)

            Dim i As Integer
            Dim share As Integer? = IIf(Integer.TryParse(Request("Cuota"), i), i, Nothing)
            Dim interval As Integer?
            If Request("bMostrarIntervalo") = "1" Then
                interval = IIf(Integer.TryParse(ddlInterval.SelectedValue, i), i, Nothing)
            Else
                interval = IIf(Integer.TryParse(Request("Intervalo"), i), i, Nothing)
            End If

            ActualizaAgenteAsignado()

            EvoAPI.ApplyCallDisposition(idWrapUpCode, dtSchedule, interval, share)
        End If
    End Sub


    Protected Function TestCampaignSchedule(ByVal dia As Date, ByVal hora As Date?) As Boolean
        Dim b As Boolean

        If IsNothing(hora) Then
            b = EvoAPI.Campaign.GetCampaignCalendarStatus(dia, Nothing)
        Else
            ' Caso especial: si la hora a testar es EXCTAMENTE IGUAL al límite de hora superior
            ' la campaña estaría activa...un segundo. Como estoy evaluando para permitir o no reprogramaciones 
            ' voy a testar siempre la hora que me pasan... más un segundo. 
            b = EvoAPI.Campaign.GetCampaignCalendarStatus(dia, hora.Value.AddSeconds(1))
        End If

        Return b
    End Function

    Protected Sub AgenteAsignadoSeleccionado(ByVal sender As Object, ByVal e As System.EventArgs)
        If DropDownList1.SelectedValue = -1 Then
            ObtenerDatosISC()
            MirarAsignacion()
        ElseIf DropDownList1.SelectedValue = 0 Then
            Asignacion = "al grupo"
            idAgenteAsignado = 0
        Else
            Dim NombreAgente As String = DropDownList1.SelectedItem.Text
            Asignacion = "al agente (" + If(NombreAgente.Length < 20, NombreAgente, NombreAgente.Substring(0, 17) + "...") + ")"
            idAgenteAsignado = DropDownList1.SelectedValue
        End If

        'Refrescamos la programación según la selección de asignación de agente realizada
        ShowDaySchedule()

    End Sub

    Protected Sub ActualizaAgenteAsignado()
        'Sólo si ha elegido en el desplegable algo distinto a "Asignación precedente"
        If (DropDownList1.SelectedValue <> -1) Then
            SqlDataSource1.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure

            'Siempre lo pasamos a grupo (porque si es a agente y ya estuviese asignado a otro sp_IdentSujCampToAgent no tiene efecto
            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> INI Asigna Grupo")
            SqlDataSource1.UpdateParameters.Clear()
            SqlDataSource1.UpdateCommand = "{call sp_IdentSujCampToGroup (?,?)}"
            SqlDataSource1.UpdateParameters.Add("@vIdSujCamp", System.Data.DbType.Int32, EvoAPI.Customer.CustomerId.ToString)
            SqlDataSource1.UpdateParameters.Add("@vIdCampanya", System.Data.DbType.Int32, EvoAPI.Campaign.CampaignId.ToString)
            SqlDataSource1.Update()
            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> FIN Asigna Grupo")

            'Si se ha elegido un agente concreto se establece
            If DropDownList1.SelectedValue <> 0 Then
                Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> INI Asigna Agente")
                SqlDataSource1.UpdateParameters.Clear()
                SqlDataSource1.UpdateCommand = "{call sp_IdentSujCampToAgent (?,?)}"
                SqlDataSource1.UpdateParameters.Add("@vIdAgent", System.Data.DbType.Int32, DropDownList1.SelectedValue)
                SqlDataSource1.UpdateParameters.Add("@vIdSujCamp", System.Data.DbType.Int32, EvoAPI.Customer.CustomerId.ToString)
                SqlDataSource1.Update()
                Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> FIN Asigna Agente")
            End If
        End If

    End Sub

    Protected Sub Guardar_Observacion(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sSql As String = ""

        If Not String.IsNullOrEmpty(DatosCliente_Observations.TextValue) Then
            ' Salvamos la última observación recogida           
            EvoAPI.Customer.Remarks = DatosCliente_Observations.TextValue
            EvoAPI.Customer.Save()

            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> INI Guardar Observación")
            SqlDataSource1.UpdateCommandType = SqlDataSourceCommandType.Text
            sSql = "update transaccion set observaciones = ? "
            sSql = sSql + " where idTransaccion=" + EvoAPI.Transaction.TransactionId.ToString
            SqlDataSource1.UpdateCommand = sSql
            SqlDataSource1.UpdateParameters.Add("@observaciones", System.Data.DbType.String, DatosCliente_Observations.TextValue)


            Traces.Debug("sSql: " + sSql)
            SqlDataSource1.Update()
            Traces.Debug("Transaccion: " + EvoAPI.Transaction.TransactionId.ToString + " Rellamadas --> FIN Guardar Observación")
        End If

    End Sub

</script>