<%@page language="java"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.net.*"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URLEncoder"%>

<%
Connection con= null;
PreparedStatement ps = null;
ResultSet rs = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/sams";
String user = "root";
String dbpsw = "";

String sql = "INSERT INTO student_login (s_no,password,mobile_number) VALUES (?,?,?);";

String roll_no = request.getParameter("roll_no");
String m_no = request.getParameter("mobile_number");

if((!(roll_no.equals(null) || roll_no.equals("")) && !(m_no.equals(null) || m_no.equals(""))))
{
try{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
ps = con.prepareStatement(sql);
ps.setString(1, roll_no);
ps.setString(2, m_no);
ps.setString(3, m_no);
ps.execute();
ps.close(); 
		try {
			String apiKey = "apikey=" + "HK3llx1T3Ww-c7D6528oPD873xVVCfBWpgyUME4N6Y";
			String message = "&message=" + "We are from team SAMS. Thank you for registering with us. Your default password is "+m_no+". Please feel free to change password";
			String sender = "&sender=" + "TXTLCL";
			String numbers = "&numbers=" + m_no;
			
			HttpURLConnection conn = (HttpURLConnection) new URL("https://api.textlocal.in/send/?").openConnection();
			String data = apiKey + numbers + message + sender;
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
			conn.getOutputStream().write(data.getBytes("UTF-8"));
			final BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			final StringBuffer stringBuffer = new StringBuffer();
			String line;
			while ((line = rd.readLine()) != null) {
				stringBuffer.append(line);
			}
			rd.close();
			
			
		} catch (Exception e) {
			System.out.println("Error SMS "+e);
		}
%>
<html>
<head>
<script LANGUAGE='JavaScript'>
     window.alert('Account created successfully, Check your phone for password');
     window.location.href='index.jsp';
    </script>
	</head>
	</html>
<%


}
catch(SQLException sqe)
{
out.println(sqe);
} 

}
else
{
%>
<html>
<head>
<script LANGUAGE='JavaScript'>
     window.alert('Account creation failed!!! please try again.');
     window.location.href='index.jsp';
    </script>
	</head>
	</html>
<%
}
%>