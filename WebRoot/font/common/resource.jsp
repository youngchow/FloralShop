<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<link href="<c:url value='/templatemo_style.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/orman.css'/>" type="text/css" media="screen" />
<link rel="stylesheet" href="<c:url value='/css/nivo-slider.css'/>" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/ddsmoothmenu.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/font/pager/pager.css'/>" />
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ddsmoothmenu.js'/>"></script>
<script type="text/javascript" src="<c:url value='/font/pager/pager.js'/>"></script>
<script type="text/javascript">
ddsmoothmenu.init({
	mainmenuid: "templatemo_menu", //menu DIV id
	orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
	classname: 'ddsmoothmenu', //class added to menu's outer DIV
	//customtheme: ["#1c5a80", "#18374a"],
	contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
})
function clearText(field)
{
    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;
}
</script>
<link rel="stylesheet" href="<c:url value='/css/slimbox2.css'/>" type="text/css" media="screen" /> 
<script type="text/JavaScript" src="<c:url value='/js/slimbox2.js'/>"></script> 
