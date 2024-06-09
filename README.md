# 🥪 RecipeSearch
공공데이터 API를 활용한 레시피 검색 어플입니다.


## 프로젝트 소개
스위프트 스터디원이 발제한 어플(명세서는 [여기](https://confusion-tip-e6c.notion.site/Recipe-Search-4bf5e3f3008647228ed7f9cf00a05f75))을 토대로 약 2주간 진행한 개인 프로젝트

## 기술 스택
![Static Badge](https://img.shields.io/badge/Swift-orange?logo=swift&logoColor=white)
![Static Badge](https://img.shields.io/badge/UIkit-%232D8DB8?logo=UIkit&logoColor=white)
![Static Badge](https://img.shields.io/badge/Alamofire-%23D24125?logo=alamofire&logoColor=white)
![Static Badge](https://img.shields.io/badge/Kingfisher-%231E88F3?logo=Kingfihser&logoColor=white)
![Static Badge](https://img.shields.io/badge/MVC-black?logo=MVVM&logoColor=white)


## 구현 화면

|   시작 화면  |   검색 화면  |  카테고리 별 분류  |
| :--------: | :--------: | :----------:  |
|    ![a]    |   ![b]    |     ![c]      | 

|   북마크 기능  |  상세 화면  |  북마크 리스트  |
| :--------: | :--------: | :----------:  |
|    ![d]    |   ![e]    |     ![f]      | 
<br>

* 시작 화면: My Picks 에는 북마크에 추가한 레시피들이, Recently Registered 에는 레시피 DB에 최근 추가된 레시피들이 보여집니다. 
* 검색 화면: 검색 결과로 나타난 CollectionViewCell들을 터치하면 해당 레시피의 상세 화면으로 이동합니다.
* 카테고리 별 분류: 서치바 터치 시 카테고리 버튼이 보여지고, 이를 누르면 해당 조리 방법의 레시피들이 보여집니다.
* 북마크 기능: 상세 화면에서 오른쪽 상단의 북마크 버튼을 누르면 My Picks와 북마크 리스트 화면에서 보여집니다. 북마크 버튼을 다시 누르면 이 곳에서 레시피가 보여지지 않습니다.
* 북마크 리스트: 북마크된 레시피들을 관리할 수 있습니다. 레시피의 순서를 변경하는 것은 일시적이나, 레시피를 북마크 리스트에서 삭제할 수 있습니다. 삭제 기능은 영구적으로 반영됩니다.

## 구현 기능

### [기능 1: 메인 화면 CollectionView의 Carousel View 레이아웃](https://www.notion.so/1-CollectionView-Carousel-View-051069f9b80b4e59a9bc8002bcc84155?pvs=4)

### [기능 2: SearchController를 이용한 검색](https://www.notion.so/2-SearchController-c8e7cc7ab8764e5cb88fdc4caca23c2b?pvs=4)

### [기능 3: 코어데이터를 이용한 북마크 기능](https://www.notion.so/3-1a58fcdf436b4d10a655c58ad333833a?pvs=4)


<br>

## 배운 점 & 아쉬운 점

- 아쉬운 점
    - 북마크 리스트를 관리하는 화면에서 순서 변경을 해도, 시작 화면의 My Picks에서 보여지는 레시피들의 순서가 변경되지 않습니다. 코어데이터를 linked list 자료구조로 변경하면 이를 해결할 수 있을 것으로 보이지만, 아직 공부가 부족해 구현하지 못한 기능입니다.
    - 서치바에 글자를 입력할 시 카테고리 버튼이 사라지고, 다시 글자가 모두 지워지면 카테고리 버튼이 보여지는 것이 명세서에 적힌 목표 사항이었지만 이를 구현하지 못했습니다. 글자를 입력할 때 버튼이 사라지게 하는 것은 성공했으나, 글자가 모두 지워진 상황에서 어느 델리게이트 패턴의 메소드가 호출되는지 정확하게 파악하지 못해 구현하지 못하였습니다. 여러 메소드들이 후보로 존재하였지만, 모종의 이유로 계속 구현에 실패하여 아쉬운 점 중 하나로 남았습니다.
- 배운 점
    - 전부 코드로 작성한 프로젝트이다 보니, 알게 된 내용이 많습니다. 오토레이아웃을 코드로 적다 보니 좀 더 새롭게 알게 된 점이 있었고, 특히 frame과 bound의 차이, clipstobounds와 maskstobounds의 차이 등에 대해 알았습니다.
    - 이미지를 어둡게 하기 위해 CAGradientLayer에 대해 공부했습니다. 앞으로 프로젝트를 진행할 때 요긴하게 사용할 것으로 기대합니다.

<!-- Refernces -->

[a]: /images/first_screen.gif
[b]: /images/search.gif
[c]: /images/category_search.gif
[d]: /images/bookmark.gif
[e]: /images/detail_screen.gif
[f]: /images/Foryou_tap.gif
