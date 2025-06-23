# Mofic 리뷰 분석 Flutter 프로젝트

## 소개

이 프로젝트는 Google Play 스토어의 "모픽(Mofic)" 앱 리뷰 데이터를 수집·분석하여, 점수별 리뷰 개수와 주요 단어 빈도를 시각적으로 보여주는 Flutter 기반 데이터 분석/시각화 앱입니다.

- **클린 아키텍처**와 **GetX** 상태관리를 적용하여 확장성과 유지보수성을 높였습니다.
- 리뷰 데이터는 크롤링 후 JSON 파일(`analysis_result.json`)로 저장되어 앱에서 불러와 분석 결과를 시각화합니다.
- 점수별 주요 단어는 파이차트로, 리뷰 개수는 리스트로 한눈에 볼 수 있습니다.

## 주요 기능

- Google Play 리뷰 데이터(JSON) 로딩 및 분석
- 점수(별점)별 리뷰 개수 집계 및 시각화
- 점수별 주요 단어 빈도 파이차트 시각화
- GetX 기반 상태관리
- 클린 아키텍처 기반의 견고한 코드 구조

## 폴더 구조

```
lib/
  core/           # 공통 DI, 테마 등
  data/
    datasource/   # 데이터소스 구현체
    repository/   # 레포지토리 구현체
    model/        # 모델(데이터 모델)
  domain/
    entity/       # 엔티티(비즈니스 모델)
    repository/   # 레포지토리
    usecase/      # 유스케이스
  presentation/
    controller/   # GetX 컨트롤러
    page/         # 화면(UI)
    widget/         # 화면(UI)
  assets/         # 분석 결과 JSON 등 리소스
```

## 기술 스택

- Flutter 3.x
- GetX (상태관리/DI)
- fl_chart (차트 시각화)
- Google Fonts (폰트)
- 클린 아키텍처


## 데이터 수집/분석

- 리뷰 데이터는 별도의 파이썬 크롤러(`comment_crawling.ipynb`)로 수집 후, 분석 결과를 JSON 파일로 저장합니다.
- 분석 결과 예시(JSON):
  ```json
  {
    "total_reviews": 34,
    "overall_counts": {"1": 6, "2": 1, ...},
    "analysis": {
      "5": {"review_count": 19, "top_words": [{"word": "최고", "frequency": 4}, ...]},
      ...
    }
  }
  ```
