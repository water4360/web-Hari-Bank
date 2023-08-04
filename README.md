# 💰하리은행(오픈뱅킹 웹페이지)
## 1. 제작기간 & 참여인원
- 2023.06.17 ~ 07.03
- 부분 팀프로젝트(4인)
  
## 2. 사용 기술
**[Back-End]**
- Java 11
- Spring 
  
**[Front-End]**
- JavaScript


## 3. ERD 설계
![01bank-erd](https://github.com/water4360/web-Hari-Bank/assets/121849929/34293b94-ec3b-42d5-ba63-b1796e1ffce4)

## 4. 핵심 기능
4명의 조원이 각각 서로의 DB(외부)에 접속하여사용자 정보로 동일인을 확인하는 경우
사용자가 어느 은행에서든 당행/타행 계좌조회 및 이체를 가능하게 하는 것이 오픈뱅킹의 핵심입니다.
다만, 조원 모두가 릴레이션 및 속성명까지 통일해야 한다는 점을 간과하여 개별 데이터베이스를 구성하였습니다.

그래서 현재는 오픈뱅킹 시스템 내에서는 오픈뱅킹 조회만 가능하며 오픈뱅킹 이체는 미구현된 기능으로,
타행계좌이체 기능에 대해 우선 안내드립니다.

<details>
<summary><b>기능설명 펼치기</b></summary>


<!-- summary 아래 한칸 공백 두어야함 -->
당행계좌조회와 달리 타행계좌이체의 경우 외부DB에 한 번 더 접속하는 과정이 있고

![당행계좌조회 타행계좌이체_시퀀스](https://github.com/water4360/web-Hari-Bank/assets/121849929/e46e76d8-4ad8-4946-90a3-0bea2f5ff88d)

사용자 입력값을 받는 부분이 많았으므로 완전히 이체를 실행하기 전, DAO쪽과 jsp 상에서의 ajax를 이용한 유효성 검사를 철저히 하려 했습니다.
![이체유효성검사](https://github.com/water4360/web-Hari-Bank/assets/121849929/a7114e46-e024-48eb-b809-349160993f50)

</details>

## 5. 트러블슈팅

## 6. 회고 / 느낀점

