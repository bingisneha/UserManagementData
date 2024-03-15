<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInput.aspx.cs" Inherits="TASK._class" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script>
        function validateForm() {
            
            var name = document.getElementById("<%= txtName.ClientID %>").value;
            if (name.trim() === "") {
                alert("Please enter your name.");
                return false;
            }

           
            var email = document.getElementById("<%= txtEmail.ClientID %>").value;
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false; 
            }

         
            var age = document.getElementById("<%= txtAge.ClientID %>").value;
            if (!isPositiveInteger(age)) {
                alert("Please enter a positive integer for age.");
                return false;
            }

            return true;
        }

        function isPositiveInteger(value) {
            return /^\d+$/.test(value) && parseInt(value) > 0;
         }
     </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const emailInput = document.getElementById("txtEmail");
            const emailErrorMessage = document.getElementById("emailErrorMessage");
            const ageInput = document.getElementById("txtAge");
            const ageErrorMessage = document.getElementById("ageErrorMessage");
      
            emailInput.addEventListener("blur", function () {
                const email = emailInput.value.trim();  

               
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

               
                if (!emailRegex.test(email)) {
                  
                    emailErrorMessage.textContent = "Please enter a valid email address.";
                } else {
                 
                    emailErrorMessage.textContent = "";
                }
            });
            ageInput.addEventListener("blur", function () {
                const age = parseInt(ageInput.value, 10);

                if (isNaN(age) || age < 1 || age > 100) {
                   
                    ageErrorMessage.textContent = "Please enter a valid age between 1 and 100.";
                } else {
                   
                    ageErrorMessage.textContent = "";
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <h2>User Input Form</h2>
            <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Enter Name" ControlToValidate="txtName" ForeColor="Red"></asp:RequiredFieldValidator>
          
            <br /> <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            <p id="emailErrorMessage" style="color: red;"></p>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Enter Email Address" ControlToValidate="txtEmail" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />

            <asp:Label ID="lblAge" runat="server" Text="Age:"></asp:Label>
            <asp:TextBox ID="txtAge" runat="server" type="number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Enter Age" ControlToValidate="txtAge" ForeColor="Red"></asp:RequiredFieldValidator>

            <br />
            <p id="ageErrorMessage" style="color: red;"></p>
            <asp:Label ID="lblDOB" runat="server" Text="Date of Birth:"></asp:Label>
            <asp:TextBox ID="txtDOB" runat="server" type="date"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Enter DOB" ForeColor="Red" ControlToValidate="txtDOB"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"/>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

        </div>
        <div>&nbsp;</div>
        <div>
            <h2>User Data</h2>
            <asp:GridView ID="gvUserData" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Age" HeaderText="Age" />
                    <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" DataFormatString="{0:d}" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
