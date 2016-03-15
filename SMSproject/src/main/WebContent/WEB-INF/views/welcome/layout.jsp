<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title><tiles:insertAttribute name="title" ignore="true" /></title>
        <tiles:insertAttribute name="stylecss" />
</head>
<body id="welcome">
        <tiles:insertAttribute name="body" />
        <tiles:insertAttribute name="scriptjs" />
</body>
</html>