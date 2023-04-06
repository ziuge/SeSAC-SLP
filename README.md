# SeSAC-SLP
새싹에서 진행하는 Service Level Project를 구현하고 매일 일지를 작성합니다.

<br>

## 1주차
### 목표: 회원 인증 / 홈 탭 / 위치 권한

| 날짜 | 오늘 한 일 | 고민한 부분 | 키워드 | 비고 |
|------|------------|-------------|--------|------|
| 1107  | <li>프로젝트 생성 및 초기 설정</li><li>온보딩 화면</li><li>휴대폰 인증 UI</li>  | <li>UILabel 일부 색 변경</li><li>Font 적용(Add to Target)</li><li>Button Extension</li> | `Firebase` `.gitignore` `Extension`       |      |
| 1108     | <li>Firebase 연동 및 가상 번호 인증 시도 완료</li><li>유효성 검사 Rx 활용</li>           | <li>런치스크린이 해제되지 않는 오류 발생 &rarr; 커스텀 버튼 LayoutSubviews() 재귀 호출 문제</li>            | `Firebase` `MVVM` `Rx`       |      |
| 1109     | <li>실기기 번호 인증 완료(번호 인증 token mismatch 오류 해결)</li><li>인증번호 UI 및 로그인 완료</li><li>유효성 검사 MVVM 및 Rx 활용</li><li>닉네임 UI</li>          | <li>Rx 활용한 토스트 메시지 띄우기</li>            | `Firebase` `Rx` `MVVM` `Toast`       |      |
| 1110     | <li>유효성 토스트 띄우기</li><li>네트워크 테스트 완료 (회원가입, 로그인)</li>           | <li>비슷한 뷰가 많은데 겹치는 코드를 더 줄일 방법이 없을까?</li>            | `Network` `Toast`       |      |
| 1111    | <li>UI(생년월일, 이메일)</li>           |             | `SnapKit`       |       |
| 1112     | <li>Input TextField 수정</li><li>NavigationBarItem 수정</li><li>성별 화면 세부 작업 중</li>           | <li>StackView로 구현했던 부분들 수정(키보드 높이 받아오기)</li>            |        |      |
| 1113     | <li>성별 화면 완성</li>           |             |        |      |

<br>

## 2주차
### 목표: 홈 탭 / 위치 권한 / 스터디 찾기 / 주변 스터디 목록 / 스터디 매칭 기능

| 날짜 | 오늘 한 일 | 고민한 부분 | 키워드 | 비고 |
|------|------------|-------------|--------|------|
| 1114     | <li>서버 코드 넣기</li><li>홈 탭 구성</li>           | <li>네트워크 연결 확인하기</li>             | `API` `Network` `TabBar`       |      |
| 1115     | <li>내 정보 화면</li>           |             |        |      |
| 1116     | <li>내 정보 화면</li>           |             |        |      |
| 1117     | <li>내 정보 화면</li><li>네트워크 통신 코드</li><li>런치스크린 VC</li>           |   <li>로그인 로직 재점검 필요할 듯</li>          |        |      |
| 1118     | <li>로그인 로직 확인 및 수정</li>           |             |        |      |

<br>

## 3주차

| 날짜 | 오늘 한 일 | 고민한 부분 | 키워드 | 비고 |
|------|------------|-------------|--------|------|
|  1122    |<li>네이버 지도 API</li><li>위치 지정(새싹 좌표)</li><li>로그인 정보 반영</li>            |  PropertyWrapper 관련 더 찾아볼 것           | `UserDefaults` `NaverMap` `PropertyWrapper`       |      |
|1123|<li>스터디 입력 화면 UI</li>|<li>새싹 홈 - 스터디 화면 개발 순서</li>|`UI` `UICollectionView` `MultiSlider`||
|1124|<li>지도에 새싹 이미지 띄우기</li><li>GPS 버튼 클릭 시 현재 위치로 이동</li><li>스터디 입력 화면 - API 추천 목록 내용 반영</li>||`NaverMap` `API` `UI`||
|1125|<li>스터디 검색 화면 - 입력, 터치 반영</li><li>유저 매칭 화면</li>||`Tabman` `CompositionalLayout`||
|1126|<li>새싹 찾기 UI</li>||`UI` `CompositionalLayout`||

<br>

### 4주차
| 날짜 | 오늘 한 일 | 고민한 부분 | 키워드 | 비고 |
|------|------------|-------------|--------|------|
|1128|<li>스터디 매칭 뷰</li>||`UI`||
|1129|<li>주변 새싹 리스트 받아오기</li><li>받은 요청 리스트 받아오기</li>||`API`||
|1201|<li>스터디 매칭 팝업 만들기</li>||`CustomView`||
|1202|<li>새싹 매칭(요청, 수락)</li>|요청 에러 - 내 state를 바꿔줬는지 확인함|||

<br>

### 5주차
| 날짜 | 오늘 한 일 | 고민한 부분 | 키워드 | 비고 |
|------|------------|-------------|--------|------|
|1212|<li>매칭 쪽 레이아웃 수정</li><li>매칭 API 연결</li><li>수락하기 연결 시도</li>|post 코드에서 response를 아예 받아오지 않는 이슈|`API` `Network`||
|1213|<li>스터디 찾기 화면 태그 중복 삭제</li><li>메인 화면에서 매칭 대기중 처리</li><li>새싹 매칭(요청, 수락) 성공</li><li>채팅 VC UI</li>|<li>POST 요청 501 -> parameter로 넘겨주는 애가 nobracket 설정이 되어있는지 확인할 것!!!</li>|`API` `Network` `UI`||
|1214|<li>채팅방 UI 완성</li><li>세부 UI 수정</li><li>소켓 통신 시작</li>||`Socket` `UI` `채팅`||
|1215|<li>소켓 연결 및 소켓 코드 복습</li>||`Socket` `Alamofire` `채팅`||

