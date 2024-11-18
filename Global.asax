<script language="C#" runat="server">

public void Session_OnEnd()
{
    var o = Session["SYS_EVOCOMMMISC"];
    if (o != null)
    {
        var comm = ((ICR.Comun.icrCommMisc)o);
        if (comm.IsConnectionStarted())
            comm.Stop();
        comm.Dispose();
    }
}

</script>