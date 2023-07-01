<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌상세조회</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


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
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>

		<div class="container mt-5 mb-7" align="center">
			<div class="text-center mb-3">
				<h2>계좌상세조회</h2>
				<p>조회기준일시 : ${formattedNow}</p>
			</div>

			<div class="card mx-auto mb-3" style="width: 30rem;">
				<div class="card-header" align="center">
					<h5 class="card-title">${account.accountNo}
						<button onclick="copyToClipboard('${account.accountNo}')"
							class="btn link-dark btn-sm">
							<i class="fas fa-copy"></i>
						</button>
					</h5>

					<p class="card-text">${deposit.name}
						<c:if test="${not empty account.accountNickname }">
					 (${account.accountNickname})</c:if>
					</p>

					<p class="card-text">신규개설 ${account.createdDate}</p>
					<p class="card-text">
						잔액 <b>${formattedTotalBalance}</b>
					</p>
				</div>
				<div class="card-body">
					<div class="d-flex justify-content-center">
						<div class="btn-group">
							<form action="inquiry.do" method="post">
								<input type="hidden" name="accountNo"
									value="${account.accountNo}">
								<button type="submit" class="btn btn-secondary">전체계좌보기</button>
							</form>
							<form action="transaction.do"
								style="margin-left: 5px; margin-right: 5px;" method="post">
								<input type="hidden" name="accountNo"
									value="${account.accountNo}">
								<button type="submit" class="btn btn-secondary">이체</button>
							</form>
							<form action="inquiry.do" method="post">
								<input type="hidden" name="accountNo"
								value="${account.accountNo}">
							<button type="button" class="btn btn-secondary">통장개설확인서</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<table class="table table-striped fixed-table mb-7"
				style="width: 60rem;">
				<thead class="thead-dark">
					<tr class="text-white bg-secondary">
						<th>거래일자</th>
						<th>거래시각</th>
						<th>구분</th>
						<th>금액</th>
						<th>내용</th>
						<th>잔액</th>
					</tr>
					<c:choose>
						<c:when test="${ empty transactionList }">
							<tr>
								<td colspan="6" class="text-center">거래내역이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="trans" items="${transactionList}">
								<tr>
									<td>${trans.date}</td>
									<td>${trans.time}</td>
									<td>${trans.type}</td>
									<td>${trans.amount}</td>
									<td>${trans.fromMemo}</td>
									<td>${trans.balance}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</thead>
			</table>
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
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>


</body>
</html>