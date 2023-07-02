<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 비대면 계좌개설</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-beta1/js/bootstrap.bundle.min.js"></script>

<style>
    .modal-body {
        max-height: calc(100vh - 210px);
        overflow-y: auto;
    }
</style>

</head>
<body>
<!-- Terms and Conditions Modals -->
<div class="modal fade" id="terms1Modal" tabindex="-1" aria-labelledby="terms1ModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="terms1ModalLabel">제1조 (목적)</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        이 약관은 본 은행과 고객 간의 예금 상품 가입 및 관련 업무에 대한 일반적인 사항을 정함을 목적으로 합니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="agree1">동의합니다</button>
      </div>
    </div>
  </div>
</div>
<!-- Repeat above modal for term2 and term3, remember to change the modal id, modal title, modal content, and button id -->

<!-- Form -->
<form id="createAccountForm">
  <div class="form-group">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="check1" data-toggle="modal" data-target="#terms1Modal">
      <label class="form-check-label" for="check1">제1조 (목적) 동의</label>
    </div>
    <!-- Repeat above for check2 and check3 -->
  </div>
  
  <button class="btn btn-primary" type="submit" id="signup-btn" disabled>계좌개설</button>
</form>

<script>
$(document).ready(function() {
  $('#agree1').click(function() {
    $('#terms1Modal').modal('hide');
    $('#check1').prop('checked', true);
    enableSubmitIfAllChecked();
  });
  // Repeat above for agree2 and agree3

  function enableSubmitIfAllChecked() {
    if ($('#check1').is(':checked') && $('#check2').is(':checked') && $('#check3').is(':checked')) {
      $('#signup-btn').prop('disabled', false);
    }
  }
});
</script>

</body>
</html>
