# RepositoryProvider
`RepositoryProvider`는 하위 위젯에 repository를 제공하기 위해 사용
Database 또는 Remote Datasource 에서 데이터를 가져오기 위해 사용
![](/../screenshot/repository.png)
- Data Provider: Datasource와 연결되어데이터에 대한 CRUD 동작
- Repository: DataProviders를  wrapping 하여 개발자에게 숨김
  
![](/../screenshot/repository.png)
`BlocProvide`와 유사하게 정의하여 사용

***사용은 뒤에 나오는 예제에서 사용*** 