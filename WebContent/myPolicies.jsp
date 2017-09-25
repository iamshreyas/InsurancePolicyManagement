<%@ page import="JDBC.jsp.*"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DatabaseMetaData"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<html>
<head>
<link href="dashboard/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

</head>

<body style="color:#03275A !important;">

	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading -->
		<h1 class="my-4">My Policies</h1>
		<%
			String pName = "";
			String pDuration = "";
			String pLatefee = "";
			String pPremium = "";
			String pComission = "";
			int modeli = 1;
			try {
				String type = (String) session.getAttribute("type");
				Connection conn = new Connect().myDBConnect();
				int id = (Integer) session.getAttribute("Id");
				String policydetails = "select pol_no from customer_policy where cust_id=" + id;
				Statement s = conn.createStatement();
				ResultSet agentlist = s.executeQuery(policydetails);
				while (agentlist.next()) {
					String sql = "select p_name, duration, late_fee, premium, commision from policy where pol_no=?";
					PreparedStatement stmt = conn.prepareStatement(sql);
					stmt.setInt(1, agentlist.getInt(1));
					ResultSet rs = stmt.executeQuery();
					while (rs.next()) {
						pName = rs.getString(1);
						pDuration = rs.getString(2);
						pLatefee = rs.getString(5);
						pPremium = rs.getString(3);
						pComission = rs.getString(4);
		%>
		<hr>

		<!-- Project One -->

		<div class="row">
			<div class="col-md-4">
				<a href="#"> <img class="img-fluid rounded mb-3 mb-md-0"
					src="http://placehold.it/700x300" alt="">
				</a>
			</div>
			<div class="col-md-8">
				<h3>
					<%
						out.println(pName);
					%>
				</h3>
				<p>
					<b>Policy Duration: </b>
					<%
						out.println(pDuration);
					%><br> <b>Late Fee: </b>
					<%
						out.println(pLatefee);
					%><br> <b>Premium Amount: </b>
					<%
						out.println(pPremium);
					%><br> <b>Agent Comission Amount: </b>
					<%
						out.println(pComission);
					%>
				</p>
				<!-- Button trigger modal -->
				<button type="button" style="margin-left:80%;margin-top:-40%;" class="btn btn-primary" data-toggle="modal"
					data-target="#polDetModal<%out.print(modeli);%>">Policy
					Details</button>

				<%
					String polDetailsSql = "select descp from policy_description where p_name='" + pName + "';";
								Statement polDetCon = conn.createStatement();
								ResultSet polDescRes = polDetCon.executeQuery(polDetailsSql);
								polDescRes.next();
				%>

				<!-- Modal -->
				<div class="modal fade" id="polDetModal<%out.print(modeli);%>"
					tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">
									<%
										out.println(pName);
									%>
								</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<%
									out.println(polDescRes.getString(1));
								%>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
		<hr>
		<%
			modeli++;
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		%>
	</div>
	<!-- /.container -->
</body>


</html>