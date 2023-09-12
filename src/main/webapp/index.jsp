<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>LOGON</title>
    <style>
        form {
            text-align: center;
            font-size: 18px ;
        }
        input:hover{
            background-color: #0066ff;
            color: white;
        }
        input{
            margin-left: 18px;
            font-size: 18px;
        }
    </style>
</head>
<body>
<form action="logon" method="post">
    <h1 >Logon </h1> <br>
      UserName: <input type="text" name="userName"> <br> <br>
      Password: <input type="password" name="mk"> <br> <br>
    <input type="submit" value="Logon">
    <input type="reset" value="Clear">
</form>
</body>
</html>