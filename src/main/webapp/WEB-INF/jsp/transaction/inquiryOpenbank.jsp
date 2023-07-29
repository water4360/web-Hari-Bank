<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 오픈뱅킹 계좌조회</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<style>
.fixed-table {
	table-layout: fixed;
}

.fixed-table th, .fixed-table td {
	width: auto;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

</head>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container mt-5">
			<div class="text-center mb-4">
				<h2>오픈뱅킹 계좌조회</h2>
			</div>
		</div>

		<div class="row justify-content-center">
			<div class="col-md-10">
				<table class="table table-striped fixed-table">
					<thead class="thead-dark">
						<tr class="text-white bg-secondary table-lg">
							<th style="text-align: left;">입출금(총 ${accountCount} 계좌)</th>
							<th >잔액 ${formattedTotalBalance}</th>
							<th colspan="3" style="text-align: right;">조회기준일시 :
								${formattedNow}</th>
						</tr>
						<tr>
							<th style="text-align: left;">은행코드</th>
							<th style="text-align: left;">계좌별칭</th>
							<th  style="text-align: left; width: 40%;">계좌번호</th>
							<th style="text-align: left; width: 40%;">잔액(원)</th>
							<th style="text-align: center;">업무</th>
						</tr>
					</thead>
					<tbody>
					<%-- JH지현 계좌 --%>
							<c:if test="${not empty JHaccountList.size()}">
								<c:forEach var="account" items="${JHaccountList}">
									<tr>
										<td style="text-align: left;">JH은행</td>
										<td style="text-align: left;">${account.accountNickname}</td>
										<td  style="text-align: left;">${account.accountNo}
											<button onclick="copyToClipboard('${account.accountNo}')"
												class="btn link-dark btn-sm">
												<i class="fas fa-copy"></i>
											</button>
										</td>
										<td style="text-align: left;"><b>${account.totalBalance}</b></td>
										<td style="text-align: center;">
											<form action="inquiryDetail-Openbank.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="조회">
											</form>
											<form action="transaction.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="이체">
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<%-- BGH은헁 계좌 --%>
							<c:if test="${not empty BGHaccountList.size()}">
								<c:forEach var="account" items="${BGHaccountList}">
									<tr>
										<td style="text-align: left;">BGH은행</td>
										<td style="text-align: left;">${account.accountNickname}</td>
										<td style="text-align: left;">${account.accountNo}
											<button onclick="copyToClipboard('${account.accountNo}')"
												class="btn link-dark btn-sm">
												<i class="fas fa-copy"></i>
											</button>
										</td>
										<td style="text-align: left;"><b>${account.totalBalance}</b></td>
										<td style="text-align: center;">
											<form action="inquiryDetail-Openbank.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="조회">
											</form>
											<form action="transaction.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="이체">
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<%-- HJ현종은헁 계좌 --%>
							<c:if test="${not empty HJaccountList.size()}">
								<c:forEach var="account" items="${HJaccountList}">
									<tr>
										<td style="text-align: left;">HJ은행</td>
										<td style="text-align: left;">${account.productCode}</td>
										<td  style="text-align: left;">${account.accountNo}
											<button onclick="copyToClipboard('${account.accountNo}')"
												class="btn link-dark btn-sm">
												<i class="fas fa-copy"></i>
											</button>
										</td>
										<td style="text-align: left;"><b>${account.totalBalance}</b></td>
										<td style="text-align: center;">
											<form action="inquiryDetail-Openbank.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="조회">
											</form>
											<form action="transaction.do" method="post"
												style="display: inline-block;">
												<input type="hidden" name="accountNo"
													value="${account.accountNo}"> <input type="hidden"
													name="productCode" value="${account.productCode}">
												<input type="submit" class="btn btn-basic" value="이체">
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							
							
							
							
							
					</tbody>
				</table>
			</div>
		</div>

		<script>
function copyToClipboard(text) {
    navigator.clipboard.writeText(text)
        .then(() => {
            // 모달 표시
            alert('계좌번호가 복사되었습니다. ctrl+v로 붙여넣기 할 수 있습니다.');
        })
        .catch((error) => {
            console.error("계좌번호 복사 실패:", error);
        });
    }
</script>



	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/include/footer.jsp"></jsp:include>
	</footer>


</body>
</html>