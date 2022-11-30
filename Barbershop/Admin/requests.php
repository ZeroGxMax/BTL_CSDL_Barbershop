<?php
    session_start();

     //Page Title
    $pageTitle = 'Customers';

    //Includes
    include 'connect.php';
    include 'Includes/functions/functions.php'; 
    include 'Includes/templates/header.php';

    //Check If user is already logged in
    if(isset($_SESSION['username_barbershop_Xw211qAAsq4']) && isset($_SESSION['password_barbershop_Xw211qAAsq4']))
    {
?>
        <!-- Begin Page Content -->
        <div class="container-fluid">
    
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">Requests</h1>
                <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                    <i class="fas fa-download fa-sm text-white-50"></i>
                    Generate Report
                </a>
            </div>

            <!-- Customers Table -->
            <?php
                $stmt = $con->prepare("SELECT * 
                    FROM appointments a , customers c
                    where a.customer_id = c.customer_id
                    order by start_time;");
                $stmt->execute(array());
                $rows = $stmt->fetchAll(); 
            ?>
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Requests</h6>
                </div>
                <div class="card-body">
                    
                    <!-- Customers Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">ID#</th>
                                    <th scope="col">Start time</th>
                                    <th scope="col">End time</th>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Employee</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($rows as $row)
                                    {
                                        echo "<tr>";
                                            echo "<td>";
                                                echo $row['appointment_id'];
                                            echo "</td>";
                                            echo "<td>";
                                                echo $row['start_time'];
                                            echo "</td>";
                                            echo "<td>";
                                                echo $row['end_time_expected'];
                                            echo "</td>";
                                            echo "<td>";
                                                $stmtCustomers= $con->prepare("SELECT first_name, last_name
                                                        from customers c, appointments a
                                                        where c.customer_id = a.customer_id
                                                        and a.appointment_id = ?");
                                                $stmtCustomers->execute(array($row['appointment_id']));
                                                $rowsCustomers= $stmtCustomers->fetchAll();
                                                foreach($rowsCustomers as $rowsCustomer)
                                                {
                                                    echo $rowsCustomer['first_name']." ".$rowsCustomer['last_name'];
                                                }
                                            echo "</td>";
                                            echo "<td>";
                                                $stmtEmployees = $con->prepare("SELECT first_name,last_name
                                                        from employees e, appointments a
                                                        where e.employee_id = a.employee_id
                                                        and a.appointment_id = ?");
                                                $stmtEmployees->execute(array($row['appointment_id']));
                                                $rowsEmployees = $stmtEmployees->fetchAll();
                                                foreach($rowsEmployees as $rowsEmployee)
                                                {
                                                    echo $rowsEmployee['first_name']." ".$rowsEmployee['last_name'];
                                                }
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