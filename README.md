# Table of Contents

- [Contributors](#contributors)
- [ToDo](#todo)
- [Summary](#summary)
- [Features](#features)
- [Tech](#tech)
- [Getting Started](#getting-started)
- [License](#license)

# Contributors
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="25%"><a href="https://github.com/wingflower"><img src="https://avatars.githubusercontent.com/u/11768589?v=4" width="100px;" alt="WingFlower"/><br /><sub><b>Dongho Gwak</b></sub></a><br /></td>
      <td></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="25%"><a href="https://github.com/KimJJangGuv"><img src="https://avatars.githubusercontent.com/u/130346919?v=4" width="100px;" alt="
KimJJangGu"/><br /><sub><b>
KimJJangGu</b></sub></a><br /></td>
      <td></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="25%"><a href="https://github.com/sc2bat/"><img src="https://avatars.githubusercontent.com/u/87482415?v=4" width="100px;" alt="
sc2bat"/><br /><sub><b>
sc2bat</b></sub></a><br /></td>
      <td></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="25%"><a href="https://github.com/dodocap"><img src="https://avatars.githubusercontent.com/u/13670800?v=4" width="100px;" alt="dodocap"/><br /><sub><b>Su Young, Kim</b></sub></a><br /></td>
      <td></td>
    </tr>
  </tbody>
</table>
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

# ToDo

### figma Link
https://www.figma.com/file/OldTPFBBEOLmVd9GxBrZMV/Untitled?type=design&mode=design&t=XSx1PJWzuheQVJ1A-0

### notion
https://www.notion.so/2789-76dc7c6eae17445fa252a65f36eb1c18?pvs=4

### ppt
https://docs.google.com/presentation/d/1XKyIopnsb7QRJ6wxCLxZcRwWdIEbu0hh6Q7nbRvqHEE/edit?usp=sharing

1. [x] 로딩

|진행|화면|기능|
|---|---|---|
|:heavy_check_mark:|로딩|로그인 여부 확인하여 초기화<br>[로그온-메인화면, 로그아웃-로그인화면]|


2. [x] 계정

|진행|화면|기능|
|---|---|---|
|:heavy_check_mark:|로그인|이메일, 패스워드로 로그인|
|:heavy_check_mark:|회원가입|이메일, 패스워드, 패스워드 확인하여 등록 준비|
|:heavy_check_mark:|이메일인증|등록한 이메일을 인증하여 최종 승인|
|:heavy_check_mark:|비밀번호 초기화|비밀번호를 초기화|

3. [x] 메인

|진행|화면|기능|
|---|---|---|
|진행중|메인(목록)|- 도감 나열<br>[오름차순, 보유 / 미보유 구분]<br> - 가이드<br>[사용자 가이드 아이콘 표시]<br> - 룰렛타이머<br>[룰렛 활성화 아이콘표시]<br> - 로그아웃<br>[로그아웃 아이콘 표시]|
||플로팅|- 룰렛 이동<br>- 도감 정렬<br>- 유형 이동|

3.1 :heavy_check_mark: 데이터 파싱
- type_data
https://gist.githubusercontent.com/sc2bat/f495ec7cf9ce22bad0e69f42f656194f/raw/abf6f776ab9e11dc68eb675a44a58f730c22318c/type_data.json
- pokemon_data
https://gist.githubusercontent.com/sc2bat/28d2991fb9e361f0e50fd52ac7c40774/raw/48a3eb10ff8094a300775471c1d8b7e0bbb29f09/pokemon_data.json

4. [x] 룰렛

|진행|화면|기능|
|---|---|---|
|진행중|룰렛|- 활성화 시간 표시<br>- 룰렛 버튼<br>[활성화/비활성화]|

5. [x] 정보

|진행|화면|기능|
|---|---|---|
|:heavy_check_mark:|상세|- 이미지 표시<br>- 정보 표시<br>- 스탯 표시<br>- 진화 표시<br>- 유형 표시|
|:heavy_check_mark:|유형|- 유형 종류 표시<br>- 유형 효과 표시|

6. [ ] Firestore

|진행|화면|기능|
|---|---|---|
|:heavy_check_mark:|연동||
|:heavy_check_mark:|Read||
|:heavy_check_mark:|Create||
|:heavy_check_mark:|Update||
||Delete||


# Features
- 포켓몬 정보
- 포켓몬 수집



# App Preview
# App Preview

![Firebase login](https://github.com/wingflower/flutter-pokedex-clean/assets/87482415/062f0f12-d1fc-4732-aa16-c855ad0f57d6)
Firebase login

![Filter Option](https://github.com/wingflower/flutter-pokedex-clean/assets/87482415/05e33e6e-35fb-4d8b-a61c-d4bcd0780725)
Filter Option

![Detail Screen](https://github.com/wingflower/flutter-pokedex-clean/assets/87482415/fb7bdcd4-0881-4593-8f17-180a3f0db600)
Detail Screen

![Roulette](https://github.com/wingflower/flutter-pokedex-clean/assets/87482415/5ac8e702-ca2c-4e8d-b8dc-ac2a938c9ff6)
Roulette


# Tech
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white)
![Vim](https://img.shields.io/badge/VIM-%2311AB00.svg?style=for-the-badge&logo=vim&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)



# Getting Started


# License
[![Licence](https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge)](./LICENSE)

[(Back to top)](#table-of-contents)
