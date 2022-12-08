<?php 
	session_start();

	//Check If user is already logged in
	if(isset($_SESSION['username_barbershop_Xw211qAAsq4']) && isset($_SESSION['password_barbershop_Xw211qAAsq4']))
	{
        //Page Title
        $pageTitle = 'Dashboard';

        //Includes
        include 'connect.php';
        include 'Includes/functions/functions.php'; 
        include 'Includes/templates/header.php';

?>
	<!-- Begin Page Content -->
	<div class="container-fluid">
		
		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">Statistics</h1>
			<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
				<i class="fas fa-download fa-sm text-white-50"></i>
				Generate Report
			</a>
		</div>

		<!-- Content Row -->
		<div class="row">
		</div>

		<!-- Appointment Tables -->
        <div class="card shadow mb-4">
            <div class="card-header tab" style="padding: 0px !important;background: #36b9cc!important">
            	<button class="tablinks active" onclick="openTab(event, 'Top barbers')">
            		Top barbers
            	</button>
                <button class="tablinks" onclick="openTab(event, 'Top customers')">
                	Top customers
                </button>
                <button class="tablinks" onclick="openTab(event, 'Top services')">
                	Top services
                </button>
            </div>
            <div class="card-body">
            	<div class="table-responsive">
                	<table class="table table-bordered tabcontent" id="Top barbers" style="display:table" width="100%" cellspacing="0">
                  		<thead>
                                <tr>
                                    <th style="text-align:center">
                                        Name
                                    </th>
                                    <th style="text-align:center">
                                        Ordered times
                                    </th>
                                    <th style="text-align:center">
                                        Average rate
                                    </th>
                                </tr>
                            </thead>
                            <tbody>

                                <?php
                                    $stmt = $con->prepare("SELECT * FROM
                                    (SELECT e.employee_id, e.first_name, e.last_name
                                    FROM employees e) AS tbl1,
                                    
                                    (SELECT employee_id, COUNT(employee_id) AS bookedTimes
                                    FROM appointments a
                                    GROUP BY employee_id) AS tbl2,
                                    
                                    (SELECT a.employee_id, AVG(f.rate) AS avgRate
                                    FROM feedbacks f
                                    INNER JOIN appointments a 
                                    ON f.appointment_id = a.appointment_id
                                    GROUP BY a.employee_id) AS tbl3
                                    
                                    WHERE tbl1.employee_id = tbl2.employee_id
                                    AND tbl2.employee_id = tbl3.employee_id
                                    ORDER BY tbl2.bookedTimes DESC, tbl3.avgRate DESC;");
                                    $stmt->execute();
                                    $rows = $stmt->fetchAll(); 

                                    foreach($rows as $row)
                                        {
                                            echo "<tr>";
                                                echo "<td>";
                                                    echo $row['first_name']." ".$row['last_name'];
                                                echo "</td>";
                                                echo "<td>";
                                                    echo $row['bookedTimes'];
                                                echo "</td>";
                                                echo "<td>";
                                                    echo $row['avgRate'];
                                                echo "</td>";
                                            echo "</tr>";
                                        }
                                ?>

                            </tbody>
                	</table>
                	<table class="table table-bordered tabcontent" id="Top customers" width="100%" cellspacing="0">
                  		<thead>
                            <tr>
                                <th style="text-align:center">
                                    ID
                                </th>
                                <th style="text-align:center">
                                    Name
                                </th>
                                <th style="text-align:center">
                                    Visit Times
                                </th>
                                <th style="text-align:center">
                                    Total spending
                                </th>
                            </tr>
                        </thead>
                        <tbody>

                            <?php
                                $stmt = $con->prepare("SELECT *
                                FROM (SELECT customer_id, first_name, last_name
                                FROM customers c) AS tbl1,
                                
                                (SELECT customer_id, COUNT(customer_id) AS visitTimes
                                FROM appointments
                                GROUP BY customer_id) AS tbl2,
                                
                                (SELECT customer_id, SUM(price) AS totalSpending
                                FROM appointments a,
                                (SELECT appointment_id, SUM(s.service_price) AS price
                                FROM services s
                                INNER JOIN services_booked sb
                                ON s.service_id = sb.service_id
                                GROUP BY sb.appointment_id) AS price
                                WHERE a.appointment_id = price.appointment_id
                                GROUP BY customer_id) AS tbl3
                                
                                WHERE tbl1.customer_id = tbl2.customer_id
                                AND tbl2.customer_id = tbl3.customer_id
                                ORDER BY tbl3.totalSpending DESC, tbl2.visitTimes DESC;");
                                $stmt->execute();
                                $rows = $stmt->fetchAll();

                                foreach($rows as $row)
                                {
                                    echo "<tr>";
                                        echo "<td>";
                                            echo $row['customer_id'];
                                        echo "</td>";
                                        echo "<td>";
                                            echo $row['first_name']." ".$row['last_name'];
                                        echo "</td>";
                                        echo "<td>";
                                            echo $row['visitTimes'];
                                        echo "</td>";
                                        echo "<td>";
                                            echo $row['totalSpending'];
                                        echo "</td>";
                                    echo "</tr>";
                                }        
                            ?>
                        </tbody>
                	</table>
                	<table class="table table-bordered tabcontent" id="Top services" width="100%" cellspacing="0">
                  		<thead>
                            <tr>
                                <th style="text-align:center">
                                    Service Name
                                </th>
                                <th style="text-align:center">
                                    Ordered Times
                                </th>
                                <th style="text-align:center">
                                    Average Rate
                                </th>
                            </tr>
                        </thead>
                        <tbody>

                            <?php
                                $stmt = $con->prepare("SELECT * FROM 

                                (SELECT service_id, service_name
                                FROM services) AS tbl1,
                                
                                (SELECT service_id, COUNT(service_id) AS orderedTimes
                                FROM services_booked
                                GROUP BY service_id) AS tbl2,
                                
                                (SELECT sb.service_id, AVG(f.rate) AS averageRate
                                FROM services_booked sb
                                INNER JOIN appointments a 
                                ON sb.appointment_id = a.appointment_id
                                INNER JOIN feedbacks f
                                ON f.appointment_id = a.appointment_id
                                GROUP BY sb.service_id) AS tbl3
                                
                                WHERE tbl1.service_id = tbl2.service_id
                                AND tbl2.service_id = tbl3.service_id
                                ORDER BY tbl3.averageRate DESC, tbl2.orderedTimes DESC;
                                                ");
                                $stmt->execute();
                                $rows = $stmt->fetchAll();

                                foreach($rows as $row)
                                {
                                    echo "<tr>";
                                        echo "<td>";
                                            echo $row['service_name'];
                                        echo "</td>";
                                        echo "<td>";
                                            echo $row['orderedTimes'];
                                        echo "</td>";
                                        echo "<td>";
                                            echo $row['averageRate'];
                                        echo "</td>";
                                    echo "</tr>";
                                }
                            ?>

                        </tbody>
                	</table>
              	</div>
            </div>
        </div>
	</div>


<?php
        
		//Include Footer
		include 'Includes/templates/footer.php';
	}
	else
    {
    	header('Location: login.php');
        exit();
    }

?>
