# Shoesome
> 브랜드별 인기 및 신상 신발을 검색하고 좋아요, 필터링 등 맞춤 기능을 제공하는 신발 조회 앱
<br/>

## 스크린샷

|![Simulator Screenshot - iPhone 15 Pro - 2024-10-25 at 18 26 15](https://github.com/user-attachments/assets/8d1959a6-53b7-41ee-ab10-fe83760f22ca)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-25 at 18 28 12](https://github.com/user-attachments/assets/7a38a7b5-486c-4cb9-83bd-95c07ee792c4)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-25 at 19 54 01](https://github.com/user-attachments/assets/d316a069-2286-461e-8926-2f87b4cce497)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-25 at 18 27 41](https://github.com/user-attachments/assets/ac89d4f8-52a8-42bb-9bd5-8c1cc6e055dc)|
|--|--|--|--|


<br>

## 프로젝트 환경
- 개발 인원:
  - iOS 1명
- 개발 기간:
  - 24.06.11 - 24.06.18 ( 7일 )
- 개발 환경:

    | iOS version | <img src="https://img.shields.io/badge/iOS-15.0+-black?logo=apple"/> |
    |:-:|:-:|
    | Framework | UIKit |
    | Architecture | MVVM |
    | Reactive | Custom Observable |

<br/>

## 기술 스택 및 라이브러리
- UI: `SnapKit`, `Toast`
- Network: `URLSession`, `Kingfisher`, `Reachability`
- Database: `CoreData`

<br/>

## 핵심 기능

- 각 브랜드 별 인기 신발 및 신상 신발 소개
- 검색 기반 신발 조회
- 정확도, 날짜순, 가격높은순, 가격낮은순 필터 기능
- 최근 검색어
- 좋아요한 상품 확인, 총 가격 조회
- 사용자 프로필 사진, 이름 설정 및 수정
- 탈퇴하기

<br/>
 
## 핵심 기술 구현 사항

- ### Custom Observable
  - 반응형 프로그래밍을 1st party에서 구현하기 위해 RxSwift에 있는 Observable을 커스텀하여 사용
  - ViewModel에 검색어나 좋아요 버튼과 같은 이벤트를 Observable 객체를 생성하여 받고 구독한 결과를 다시 Observable 객체로 반환하여 ViewController에게 넘겨줌
  
<br>

- ### 상태코드 분기 처리
  - 네트워크 통신 시 발생할 수 있는 에러의 상태코드를 분기하여 각 상태코드에 따른 에러메세지를 보여줌
  - enum 타입으로 에러 케이스를 나누고 각 상태코드에 따른 에러메세지를 정의함으로써 네트워크 통신 시 발생할 수 있는 문제들을 빠르게 파악할 수 있도록 설계함
 
<br>

- ### 상품 조회
  - 네이버 Shopping API를 이용하여 브랜드 별 신발, 신상품, 사용자 검색에 따른 신발들을 조회함
  - 신상품은 API명세에 date필터를 이용해서 최신순으로 보여줌
  - 각 신발 브랜드를 enum case로 정의하고 브랜드 클릭 시 enum값이 검색어에 입력되어 통신하도록 설계함   

<br>

- ### 네트워크 통신 단절 시 메세지 알림
  - Reachability 라이브러리를 이용하여 사용자가 신발 검색 시 네트워크 통신을 확인하고 연결이 안됐을 경우 Toast를 통해 메세지를 알림
 
<br>

- ### Compositional Layout, Diffable DataSource
  - 홈 화면에서 신발 브랜드 종류, 신발 정보, 신상 신발 등 섹션별로 다른 셀 크기와 데이터 타입을 효과적으로 처리하기 위해 Compositional Layout과 Diffable DataSource를 활용하여 레이아웃을 구성
  - NSDiffableDataSourceSnapshot을 사용해 섹션별로 데이터를 추가하고, CellRegistration을 사용하여 셀의 데이터 타입에 맞는 레이아웃을 설정

<br/>

## 트러블 슈팅
### 1. 상품 이미지를 불러올 때 원본 이미지를 필요한 크기만큼만 축소하여 보여줌으로써 메모리 절약
- 상황
  - 사용자가 상품을 검색하면 관련 상품을 컬렉션뷰 형태로 보여주고 각 셀에서 Kingfisher를 이용하여 이미지를 보여줌
  
- 원인 분석
  - 네이버 쇼핑 API 응답값에서 주는 url은 원본이미지를 기반으로 보여주게 되는데 원본이미지는 크기가 매우 크므로 불러올 때 시간이 걸리고 메모리를 많이 사용

- 해결
  - Kingfisher에 있는 DownsamplingImageProcessor로 필요한 크기만큼 이미지를 축소하여 메모리 절약

  <br>

   <img width="426" alt="스크린샷 2024-10-19 오후 6 29 50" src="https://github.com/user-attachments/assets/3068fb33-2713-489a-b08a-79d002114de0">     
   <img width="417" alt="스크린샷 2024-10-19 오후 6 30 47" src="https://github.com/user-attachments/assets/e41fca70-2ff9-41fb-bfa3-edf34243f3f7">
   
    <br>

     ```swift
     func setImage(_ url: String?) {
        guard let url = url, let source = URL(string: url) else { return }
        kf.setImage(with: source, placeholder: UIImage(named: "shop-placeholder"), options: [
            .transition(.fade(1)),
            .forceTransition,
            .processor(DownsamplingImageProcessor(size: CGSize(width: 300, height: 400))),
            .scaleFactor(UIScreen.main.scale),
            .progressiveJPEG(.init(isBlur: false, isFastestScan: true, scanInterval: 0.1)),
            .cacheOriginalImage
        ])
    }
     ```
<br>

### 2. DiffableDataSource를 이용하여 각 섹션마다 다른 타입을 적용할 때의 고민
- 상황
  - Home 화면에서 브랜드 카테고리 컬렉션뷰, 브랜드별 신발을 보여주는 컬렉션뷰, 신상 신발을 보여주는 컬렉션뷰를  DiffableDataSource를 이용해서 각 섹션으로 나누고 데이터를 구성함
  - 첫번째 섹션은 String타입, 나머지 섹션은 신발에 대한 정보가 담긴 구조체 타입으로 각 섹션 별 들어가는 타입이 다름
 
- 원인 분석
  - 특정 프로토콜을 정의하고 각 섹션 별 들어가는 타입에 이 프로토콜을 채택
  - DiffableDataSource ItemIdentifierType에 프로토콜을 넣어줌으로써 추상화하려 했지만 구체적인 타입만이 들어갈 수 있음
  
- 해결 
  - Hashable을 채택한 다른 타입의 객체들을 AnyHashable의 형태로 선언
  - DataSource를 구현할 때 섹션별로 identifier에 각 타입에 맞게 타입 캐스팅을 해줌
    
  <br>
    
     ```swift
     private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

     dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: mainCollectionView) {
         (collectionView: UICollectionView, indexPath: IndexPath, identifier: AnyHashable) -> UICollectionViewCell? in
    
         let section = Section(rawValue: indexPath.section)
        
         switch section {
             case .categories:
             return collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: identifier as? BrandCategory)
             case .brands:
             return collectionView.dequeueConfiguredReusableCell(using: brandCellRegistration, for: indexPath, item: identifier as? SearchResultDetail)
             case .recents:
             return collectionView.dequeueConfiguredReusableCell(using: recentCellRegistration, for: indexPath, item: identifier as? SearchResultDetail)
             default:
                 return nil
             }
     }
     ```
    
    







