function _change() {
	$("#vCode").attr("src", "/FloralShop/VerifyCodeServlet?" + new Date().getTime());
}