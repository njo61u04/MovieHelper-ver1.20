# MovieHelper-ver1.20

給喜歡去電影院看電影的人所使用的小工具

## 關於

- 主要是給喜歡去電影院看電影的人所使用的小工具
- 使用的程式語言為`Swift`
- 項目的主要功能和特點為能查看臺灣院線上映和即將上映電影之相關資訊，並且可以查看附近的電影院
- 開發環境的配置要求為`Xcode`
- 電影相關資訊是先用`Python`的爬蟲技術從第三方網站抓資料下來放到`Firebase`，再由這隻程式讀取`Firebase`的資料

## 使用套件

- `Kingfisher`
- `Firebase`
- `GoogleSignIn`

## 檔案結構

- 讀取上映中電影並用`collection view`呈現
<[MovieHelper/OnlineMovie](https://github.com/njo61u04/MovieHelper-ver1.20/tree/main/MovieHelper/OnlineMovie)>
- 讀取即將上映電影並用`collection view`呈現
<[MovieHelper/CommingMovie](https://github.com/njo61u04/MovieHelper-ver1.20/tree/main/MovieHelper/CommingMovie)>
- 讀取票房電影並用`collection view`呈現
<[MovieHelper/BoxOffice](https://github.com/njo61u04/MovieHelper-ver1.20/tree/main/MovieHelper/BoxOffice)>
- 顯示附近的電影院，做法是用`MKLocalSearch`搜尋關鍵字“電影院”，並把搜尋到的結果用`MapView`在地圖上建立圖標顯示。每個圖標點了之後可以導航到這個電影院或致電。
<[MovieHelper/Map](https://github.com/njo61u04/MovieHelper-ver1.20/tree/main/MovieHelper/Map)>
- 點選電影欄位時會導到詳細資訊畫面，這些程式是負責呈現點選電影之詳細資訊。主要做法是將三個`Container View`包在`Scroll View`裡面，分別呈現電影資訊、時刻表和預告片，可以藉由滑動或點選上方的`Segmented Control`來切換頁面
<[MovieHelper/MovieInformation](https://github.com/njo61u04/MovieHelper-ver1.20/tree/main/MovieHelper/MovieInformation)>

