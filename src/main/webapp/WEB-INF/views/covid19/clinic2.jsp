<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>코로나 선별진료소</title>
</head>
<body>
	<div id="map" style="width: 100%; height: 100vh;"></div>

	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=92068749f55230080ea930abfa4851b9&libraries=clusterer"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
			level : 13, // 지도의 확대 레벨
			mapTypeId : kakao.maps.MapTypeId.ROADMAP
		// 지도종류
		};

		//지도를 생성한다.
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 마커 클러스터러를 생성합니다 
		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			minLevel : 10, //클러스터 할 최소 지도 레벨 
			disableClickZoom : true
		// 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		});

		var hospital = [ '','강남구보건소', '삼성서울병원', '연세대학교의과대학강남세브란스병원',
				'강동경희대학교의대병원', '강동구보건소', '성심의료재단강동성심병원', '한국보훈복지의료공단중앙보훈병원',
				'강북구보건소', '강서구보건소', '이화여자대학교의과대학부속서울병원', '관악구보건소',
				'관악구보건소 신사동 코로나19 건강상담소', '에이치플러스양지병원', '광진구보건소', '건국대학교병원',
				'구로구보건소', '구로구보건소 가리봉동선별진료소', '구로성심병원', '금천구보건소', '독산보건분소',
				'희명병원', '노원구보건소', '노원을지대학교병원', '인제대학교상계백병원', '도봉구보건소',
				'동대문구보건소', '경희대학교병원', '삼육서울병원', '서울특별시동부병원', '서울성심병원',
				'동작구보건소', '동작구보건소 신대방선별진료소', '마포구보건소', '서대문구보건소',
				'학교법인연세대학교의과대학세브란스병원', '서초구보건소', '학교법인가톨릭학원가톨릭대학교서울성모병원',
				'서울특별시 어린이병원', '성동구보건소', '한양대학교병원', '성동군자의원', '성북구보건소',
				'(학)고려대학교의과대학부속병원(안암병원)', '송파구보건소', '재단법인아산사회복지재단서울아산병원',
				'경찰병원', '양천구보건소', '서울특별시 서남병원', '이화여자대학교의과대학부속목동병원', '홍익병원',
				'영등포구보건소', '한림대학교강남성심병원', '가톨릭대학교 여의도성모병원', '성애의료재단성애병원',
				'명지성모병원', '용산구보건소', '순천향대학교 부속 서울병원', '은평구보건소', '서울특별시립 서북병원',
				'서울특별시 은평병원', '가톨릭대학교 은평성모병원', '청구성심병원', '종로구보건소', '강북삼성병원',
				'서울적십자병원', '서울지구병원', '인제대학교서울백병원', '중구보건소', '중구보건소 명동선별상담소',
				'중랑구보건소', '서울의료원', '강서구보건소', '갑을녹산병원', '금정구보건소', '세웅병원',
				'동남권원자력의원', '기장군보건소', '남구 보건소', '부산성모병원', '봉생병원', '동구보건소',
				'좋은문화병원', '대동병원', '동래구보건소 ', '인제대학교부산백병원', '부산진구보건소', '온종합병원',
				'동의병원', '춘해병원', '북구보건소', '의료법인 인당의료재단 부민병원', '구포성심병원',
				'사상구보건소', '좋은삼선병원', '사하구보건소', '서구 보건소', '동아대학교병원', '고신대학교복음병원',
				'삼육부산병원', '좋은강안병원', '비에이치에스한서병원', '수영구보건소', '연제구보건소', '영도구보건소',
				'영도병원', '해동병원', '중구 보건소', '메리놀병원', '해운대구보건소', '해운대부민병원',
				'인제대학교해운대백병원', '영남대학교병원', '대구 가톨릭대학교병원', '남구보건소', '굿모닝병원',
				'드림병원', '달서구보건소', '계명대학교 동산병원', '보광병원', '의료법인구의료재단 구병원',
				'삼일병원', '더블유병원', '세강병원', '달성군보건소', '대구파티마병원', '동구보건소',
				'칠곡경북대학교병원', '북구보건소', '대구가톨릭대학교 칠곡가톨릭병원', '서구보건소', '수성구보건소',
				'중구보건소', '강화군보건소', '비에스종합병원', '한림병원', '메디플렉스 세종병원', '계양구보건소',
				'남동구보건소', '의료법인성수의료재단인천백병원', '동구보건소', '현대유비스 병원', '미추홀구보건소',
				'인천사랑병원', '가톨릭대학교 인천성모병원', '부평세림병원', '근로복지공단 인천병원', '부평구보건소',
				'국제성모병원', '나은병원', '성민병원', '검단탑병원', '온누리병원', '서구보건소',
				'나사렛 국제병원', '연수구보건소', '인천적십자병원', '옹진군보건소', '백령병원', '인천기독병원',
				'중구보건소', '영종보건지소', '광산구보건소', '첨단종합병원', 'KS병원', '광주기독병원',
				'남구보건소', '동구보건소', '광주일곡병원', '북구보건소', '서광병원', '서구보건소', '대덕구보건소',
				'대전보훈병원', '근로복지공단 대전병원', '동구보건소', '대전한국병원', '서구보건소', '건양대학교병원',
				'을지대학교병원', '유성구보건소', '유성선병원', '중구보건소', '대전선병원', '대전성모병원',
				'울산병원', '좋은삼정병원', '남구보건소', '동구보건소', '울산시티병원', '북구보건소',
				'서울산보람병원', '울주군보건소', '남부통합보건지소', '동강병원', '중구보건소', '세종특별자치시보건소',
				'세종특별자치시보건소(충남대학교병원세종의원)', '가평군보건소', 'HJ매그놀리아국제병원', '덕양구 보건소',
				'일산동구보건소', '인제대학교 일산백병원', '동국대학교일산불교병원', '국민건강보험공단 일산병원',
				'일산복음병원', '과천시보건소', '광명성애병원', '광명시보건소', '광주시보건소', '참조은병원',
				'구리시보건소', '한양대학교구리병원', '효신의료재단 지샘병원', '원광대학교 산본병원', '군포시보건소',
				'김포우리병원', '뉴고려병원', '김포시보건소', '남양주보건소', '남양주풍양보건소', '남양주한양병원',
				'현대병원', '동두천보건소', '부천시보건소', '부천시 오정보건소', '부천시 소사보건소',
				'순천향대학교 부천병원', '가톨릭대학교부천성모병원', '부천세종병원', '성남시분당구보건소', '중원구보건소',
				'분당차병원 ', '수정구보건소', '성남시의료원', '순천의료재단정병원', '성남중앙병원', '권선구보건소',
				'영통구보건소', '장안구보건소', '팔달구보건소', '아주대학교병원', '경기도의료원 수원병원',
				'성빈센트병원', '동수원병원', '석경의료재단 센트럴병원', '신천연합병원 ', '시흥시화병원',
				'시흥시보건소', '시흥시 정왕보건지소', '단원보건소', '안산시상록수보건소', '고대안산병원', '한도병원',
				'근로복지공단안산병원', '경기도의료원 안성병원', '안성성모병원', '안성시보건소', '동안구보건소',
				'만안구보건소', '한림대학교 성심병원', '안양샘병원', '양주시보건소', '양평군보건소', '양평병원',
				'세종여주병원', '여주시보건소', '연세새로운병원', '연천군 보건의료원', '오산시보건소', '오산한국병원',
				'기흥구보건소', '수지구보건소', '강남병원', '처인구보건소', '영문의료재단 다보스병원', '용인서울병원',
				'의왕시보건소', '아가페의료재단 시티병원', '경기도의료원의정부병원 (응급실)', '의정부시보건소',
				'가톨릭대학교 의정부성모병원', '추병원', '의정부백병원', '경기도의료원 이천병원', '이천시보건소',
				'파주시보건소', '경기도의료원 파주병원', '메디인병원', '의료법인 백송의료재단 굿모닝병원',
				'의료법인 박애의료재단 박애병원', '의료법인 양진의료재단 평택성모병원', '평택보건소',
				'평택시 안중보건지소', '박병원', '송탄보건소', '포천시보건소', '경기도의료원 포천병원',
				'소흘보건지소', '일동보건지소', '하남시보건소', '화성중앙종합병원', '화성시보건소',
				'화성시보건소 동탄보건지소', '동탄성심병원', '원광종합병원', '남양디에스병원', '강릉아산병원',
				'강릉동인병원', '강릉고려병원', '강릉시보건소', '고성군보건소', '동해시보건소', '동해동인병원',
				'근로복지공단 동해병원', '삼척의료원', '삼척시보건소', '속초시보건소', '강원도속초의료원',
				'속초보광병원', '양구군보건소', '의료법인 성심의료재단 양구성심병원', '양양군보건소', '강원도영월의료원',
				'영월군보건소', '연세대학교 원주세브란스기독병원', '원주시보건소', '강원도원주의료원', '인제군보건소',
				'근로복지공단정선병원', '정선군보건소', '철원군보건소', '철원병원', '한림대학교 춘천성심병원',
				'춘천시보건소', '태백시보건소', '근로복지공단 태백병원', '평창군보건의료원', '홍천아산병원',
				'홍천군보건소', '화천군보건의료원', '횡성대성병원', '횡성군보건소', '괴산군보건소', '괴산성모병원',
				'단양군보건소', '단양군립노인요양병원', '(의료법인)정민의료재단 보은한양병원', '영동병원',
				'영동군보건소', '옥천성모병원', '옥천군보건소', '음성군보건소', '금왕태성병원', '제천 서울병원',
				'제천시보건소', '명지병원(제천)', '증평군보건소', '진천성모병원', '진천군보건소', '상당보건소',
				'의료법인 인화재단한국병원', '의료법인정산의료재단효성병원', '서원보건소', '충청북도 청주의료원',
				'청주성모병원', '청원보건소', '흥덕보건소', '한마음의료재단 하나병원', '베스티안병원', '충주시보건소',
				'충청북도 충주의료원', '건국대학교 충주병원', '계룡시보건소', '충청남도공주의료원', '공주시 보건소',
				'새금산병원', '금산군보건소', '백제종합병원', '논산시보건소', '당진종합병원', '당진시보건소',
				'보령시보건소', '보령아산병원', '건양대학교 부여병원', '부여군보건소', '성요셉연합의원',
				'충청남도서산의료원', '서산시보건소', '서해병원', '서천군보건소', '아산충무병원', '아산시보건소',
				'현대병원', '의료법인 예당의료재단 예산종합병원', '예산군보건소', '천안시 동남구보건소',
				'학교법인동은학원 순천향대학교 부속천안병원', '의료법인영서의료재단 천안충무병원',
				'충청남도천안의료원(소아청소년과 없음)', '천안우리병원', '청양군보건의료원', '태안군보건의료원',
				'충청남도 홍성의료원', '홍성군보건소', '고창군보건소', '(의)석천재단고창병원', '군산시보건소',
				'군산의료원', '동군산병원', '김제시보건소', '남원의료원', '남원시보건소', '무주군보건의료원',
				'부안군보건소', '부안성모병원', '순창군보건의료원', '완주군보건소', '익산병원', '익산시보건소',
				'임실군보건의료원', '장수군보건의료원', '예수병원', '대자인병원', '전주병원',
				'전주시보건소(덕진진료실)', '호성전주병원', '정읍아산병원', '정읍시보건소', '진안군보건소',
				'진안군의료원', '강진의료원', '강진군보건소', '고흥종합병원', '고흥군보건소', '녹동현대병원',
				'곡성사랑병원', '곡성군보건의료원', '광양사랑병원', '광양시보건소', '구례병원', '구례군보건의료원',
				'나주종합병원', '나주시보건소', '빛가람동 선별진료소', '산포면 선별진료소', '담양사랑병원',
				'담양군보건소', '목포한국병원', '목포기독병원', '목포중앙병원', '목포시의료원', '세안종합병원',
				'전남중앙병원', '목포시보건소', '대송의료재단 무안병원', '무안군보건소', '보성아산병원',
				'보성군보건소', '벌교삼호병원', '순천시보건소', '순천 성가롤로병원', '순천의료원', '순천 한국병원',
				'순천병원', '신안군보건소', '신안대우병원', '여천전남병원', '여수시보건소', '여수전남병원',
				'여수한국병원', '여수제일병원', '영광종합병원', '영광기독병원', '영광군보건소', '영암병원',
				'영암군보건소', '완도대성병원', '완도군보건의료원', '장성병원', '장성군보건소', '장흥종합병원',
				'장흥군보건소', '진도한국병원', '진도군보건소', '함평성심병원', '함평군보건소', '해남종합병원',
				'해남우리종합병원', '해남군보건소', '화순고려병원', '화순전남대학교병원', '화순성심병원',
				'화순군보건소', '세명병원', '경산중앙병원', '경산시 보건소', '경주시 보건소',
				'경주시 주민건강지원센터', '고령군보건소', '고령영생병원', '구미순천향병원', '구미차병원',
				'구미강동병원', '구미시 구미보건소', '군위군보건소', '김천의료원', '김천제일병원', '김천시 보건소',
				'김천소년교도소 부속의원', '문경제일병원', '문경중앙병원', '문경시 보건소', '봉화군 보건소',
				'봉화해성병원', '상주성모병원', '상주시 보건소', '성주군보건소 ', '안동시보건소', '안동의료원',
				'안동병원', '안동성소병원 ', '영덕아산병원 ', '영덕군보건소', '영양군보건소', '영양병원',
				'영주시보건소', '영남대학교 영천병원 ', '영천시 보건소', '예천군보건소', '예천권병원',
				'울릉군보건의료원', '울진군의료원 ', '의성군보건소', '공생병원', '청송군보건의료원', '칠곡군보건소',
				'왜관병원', '포항시 북구보건소', '포항시 남구보건소', '포항세명 기독병원', '포항 성모병원',
				'포항의료원', '의료법인 거붕백병원', '의료법인 대우병원', '거제시 보건소', '맑은샘병원',
				'거창적십자병원', '거창군 보건소', '고성군 보건소', '김해중앙병원', '조은금강병원', '갑을장유병원',
				'김해시 보건소', '의료법인이도의료 재단 남해병원', '남해군 보건소', '밀양 윤병원', '밀양시 보건소',
				'삼천포서울병원', '사천시 보건소', '의료법인승연의료재단 제일병원', '산청군보건의료원',
				'양산부산대학교병원', '베데스다 병원', '웅상중앙병원', '양산시 보건소', '', '의령병원',
				'의령군 보건소', '진주제일병원', '진주고려병원', '진주반도병원', '진주복음병원', '진주세란병원',
				'진주한일병원', '진주시 보건소', '태황의료재단 한성병원', '창녕군 보건소', '창원시 창원보건소',
				'SMG연세병원', '창원시 마산보건소', '창원시 진해보건소', '연세에스병원', '세광병원',
				'삼성창원병원', '마산의료원', '창원경상대학교병원', '한마음창원병원', '창원병원', '창원파티마병원',
				'통영적십자병원', '영동병원', '함안군 보건소', '함양성심병원', '함양군 보건소', '삼성합천병원',
				'합천군 보건소', '서귀포의료원', '서귀포열린병원', '제주한라병원', '한마음병원', '한국병원',
				'중앙병원']
		var lat = ['37.51631849','37.49034493','37.49280628','37.55294144','37.5295407','37.53615563','37.52818872','37.63247391','37.54964883','37.55726306','37.47846743','37.48540753','37.48409226','37.53817543','37.5402635','37.54045629','37.50010536','37.48253206','37.49220061','37.49964749','37.45690514','37.47365796','37.45566734','37.65427598','37.6364895','37.64858218','37.6580908','37.57439114','37.59377356','37.58889541','37.57535416','37.58437434','37.50444702','37.49150778','37.56631258','37.5786085','37.56157339','37.48350783','37.50239328','37.4557161','37.56708094','37.5596563','37.5484194','37.60270892','37.58786588','37.51447685','37.52636373','37.49638571','37.51758876','37.51202039','37.53649015','37.52848284','37.52640491','37.49324869','37.51781383','37.51205002','37.49385014','37.5324523','37.53411481','37.60279081','37.6042748','37.59416121','37.6336095','37.62089967','37.58183151','37.56832056','37.56737887','37.57694695','37.56508767','37.56458779','37.56105329','37.60656393','37.61284092','35.18023523','35.09056577','35.2430377','35.21443252','35.32185765','35.24452','35.13606933','35.10982062','35.13094712','35.12933073','35.14066477','35.20430713','35.211414','35.14552586','35.14611614','35.15785278','35.16994544','35.1469504','35.23929177','35.21196579','35.20967281','35.15255227','35.15014992','35.09442023','36.31095606','35.11934513','35.08040299','35.11271163','35.15017242','35.16081803','35.16264082','35.17621131','35.0912183','35.09223995','35.09193601','35.10619692','35.10777321','35.16402604','35.16142097','35.17325983','35.84579152','35.84371768','35.85390173','35.85302342','35.83961475','35.82952502','35.85388508','35.83675478','35.85068194','35.83316735','35.85264329','35.83664268','35.69481799','35.88402112','35.88812213','35.95614662','35.89187918','35.93491612','35.87175728','35.84490549','35.87790678','37.77899257','37.73606565','37.53224904','37.53254024','37.53744038','37.44778682','37.48174142','37.48303941','37.46160992','37.4610816','37.46219606','37.48480728','37.50689378','37.47671945','37.4988346','37.54234194','37.48905894','37.50978922','37.59262556','37.60279568','37.54443822','37.40794798','37.41913283','37.41842021','37.44657044','37.96800855','37.47133153','37.477221','37.49363315','35.13964729','35.22110247','35.19793261','35.13670089','35.13290738','35.14567609','35.20286109','35.17334667','35.1325959','35.15202863','36.44717235','36.44731615','36.36831086','36.31203706','36.34817459','36.36709097','36.30773298','36.35530079','36.35811946','36.37578938','36.30802143','36.33611893','36.32308657','35.54622172','35.55282796','35.54535739','35.5057777','35.58281756','35.58355545','35.55992853','35.55836372','35.45524829','35.55375388','35.56945563','36.60567662','36.49518232','37.83350411','37.69113813','37.65783722','37.65598085','37.6742733','37.67643514','37.64547577','37.6819164','37.42955562','37.47316238','37.45580203','37.4165558','37.41093491','37.6047376','37.60152908','37.35867135','37.3594143','37.33316881','37.63299883','37.64095701','37.62338575','37.61007841','37.71067901','37.68231833','37.71543701','37.89661249','37.4942665','37.52834809','37.48004678','37.49837305','37.48749357','37.48140188','37.41107127','37.44215676','37.41045189','37.44432879','37.44498406','37.43986236','37.45280925','37.25874327','37.25688124','37.3030438','37.27149869','37.27826756','37.29214733','37.27790833','37.2786521','37.33666966','37.4443936','37.35291953','37.44558711','37.34672014','37.32106818','37.30156874','37.31832686','37.33405533','37.31710228','37.0173533','37.0057914','37.0001939','37.39298061','37.38584954','37.39165146','37.39348343','37.78556554','37.49703536','37.49363232','37.30148027','37.29460823','37.28987666','38.02308286','37.15937058','37.14133849','37.27260645','37.32222161','37.27359519','37.24115498','37.23154136','37.24043717','37.34378729','37.35028053','37.74078564','37.736157','37.75773163','37.74971803','37.74533182','37.2828226','37.28898172','37.75607446','37.75497395','37.75804466','36.99057623','36.99306222','37.00840797','36.99064523','36.98571168','37.04812532','37.06571389','37.90082625','37.9033028','37.82329839','37.96127484','37.53868804','37.13153793','37.12928023','37.20706908','37.21651383','37.21006237','37.19923251','37.81840395','37.77457864','37.75901365','37.74280944','38.37761481','37.52283044','37.5302454','37.53169443','37.4402621','37.44374177','38.19616476','38.21606335','38.19803704','38.10992254','38.10471841','38.07769115','37.18676884','37.18409006','37.34912031','37.35158425','37.33338107','38.06327941','37.38306191','37.38009485','38.14820402','38.15034094','37.88376639','37.87554765','37.17663258','37.1042575','37.36894476','37.69110576','37.6902098','38.10757087','37.47840805','37.48715651','36.80799943','36.81579543','36.98164082','36.98697294','36.48326713','36.4864566','36.1847077','36.16823743','36.31360495','36.30431997','36.92884066','36.99752654','37.13874511','37.14934061','37.16343053','36.77424637','36.85824541','36.86061229','36.58826409','36.61955762','36.62432545','36.63765368','36.64122455','36.67393614','36.71018315','36.63017161','36.6235268','36.63642987','36.9913957','36.97931427','36.97931651','36.27307633','36.45887779','36.4571175','36.10380245','36.11329022','36.19196805','36.19607779','36.90453081','36.88742895','36.32450945','36.3802355','36.27507282','36.28305348','36.27942894','36.77481134','36.77457731','36.08451509','36.08255534','36.77954817','36.78274227','36.78310142','36.69125336','36.68088042','36.80745148','36.80280675','36.79741817','36.7754886','36.78104568','36.45501472','36.75195079','36.59835723','36.5966417','35.44376306','35.43663849','35.96473448','35.95493092','35.97754318','35.80080656','35.43190543','35.39724725','36.00588008','35.72283482','35.72453588','35.36710631','35.92124677','35.96241345','35.96098588','35.61302801','35.6547966','35.81378153','35.84599082','35.81516453','35.82940233','35.86546113','35.58844398','35.57829139','35.79730664','35.79524591','34.63725058','34.63795792','34.62168935','34.5921441','34.54624084','35.2764048','35.27886634','34.93617307','34.98056625','35.21591978','35.21633383','35.03665564','34.99522632','35.02220477','35.04014131','35.31521955','35.3250042','34.8090709','34.80444877','34.82149527','34.8038531','34.81692541','34.8106735','34.8044298','34.99202177','34.99009218','34.7763901','34.77021774','34.83383886','34.96667701','34.96374629','34.95777871','34.94784639','34.96189258','34.83360226','34.72225101','34.76902739','34.75938305','34.74499687','34.76151254','34.76597282','35.28378369','35.27514146','35.27427814','34.79398767','34.79507001','34.31684453','34.33630065','35.30601218','35.30454179','34.67714209','34.67646907','34.4825552','34.48012514','35.06227316','35.06235841','34.57212664','34.58393319','34.57046092','35.05635829','35.0594965','35.05843957','35.05746735','35.82618697','35.80931709','35.82511131','35.85948199','35.87397713','35.72523619','35.72986046','36.1023472','36.11459837','36.09620449','36.13993542','36.22959376','36.12251914','36.13545289','36.1395339','36.11423404','36.58384356','36.59600315','36.59625463','36.89070309','36.89169726','36.42063293','36.41663072','35.91711719','36.56699733','36.5682349','36.54738762','36.56757611','36.5245979','36.41354497','36.66194695','36.66246604','36.8060211','35.9573529','35.96854114','36.65799188','36.65719262','37.48591285','36.99279961','36.36751831','36.35446297','36.43113374','35.99059824','35.99612269','36.07066299','35.99244107','36.01809831','36.02320007','36.03516531','34.87369768','34.87195478','34.89166098','34.89772683','35.6866939','35.68093608','34.96956944','35.23070004','35.26216344','35.20866529','35.23243234','34.84647016','34.84503834','35.48463461','35.48542872','34.93310922','35.00362094','34.93753859','35.41608129','35.32878661','35.35314173','35.4067413','35.33573792','35.31857632','35.31781999','35.17940046','35.17851143','35.19175695','35.18537451','35.17445443','35.16696464','35.21469811','35.54907206','35.54364673','35.22785367','35.18631498','35.19051246','35.13143212','35.15473353','35.14963671','35.24299589','35.19917174','35.19921361','35.22082938','35.21841194','35.23724271','34.84238403','34.8598077','35.08323204','35.06716382','35.30894854','35.27601321','35.52069572','35.51967545','35.5664688','35.56792833','33.25606919','33.25446623','33.48996291','33.4962867933.50027196','33.49232086']
		var lng = ['127.0423142','127.0895905','127.0463103','127.1572574','127.1255846','127.135336','127.147206','127.0385158','126.8682802','126.8362668','126.9511318','126.9180949','126.9326227','127.0818572','127.0651096','127.0719158','126.8893397','126.8897168','126.8847937','126.8663584','126.8953686','126.9022405','126.9005605','127.0560818','127.0695484','127.0631157','127.0387456','127.0398965','127.0507402','127.0646739','127.0315131','127.0497292','126.9410892','126.9090997','126.9016155','126.9362742','126.9382291','127.0330741','127.0058601','127.0688511','127.0332146','127.0433683','127.0656488','127.0395324','127.0263964','127.1058597','127.1079574','127.1225211','126.8659168','126.8331317','126.8862049','126.8636417','126.8959858','126.9086731','126.9355918','126.9223689','126.8992536','126.9904791','127.0038505','126.9291019','126.9049475','126.9232258','126.9161521','126.9193641','126.9692262','126.9667927','126.9669584','126.9800409','126.9888563','127.0150962','126.9845148','127.0927248','127.0980684','128.9572943','128.853313','129.0921256','129.1040757','129.2431678','129.222277','129.0849527','129.1092834','129.0500989','129.0449088','129.0588418','129.0802019','129.0798549','129.0208656','129.0597197','129.049882','129.0759188','129.0583812','129.0144148','129.011217','129.0045735','128.9914576','129.0078074','128.9594091','127.4308704','129.0180002','129.0159279','129.0111264','129.1106004','129.1131432','129.1134524','129.0797458','129.0679111','129.0405244','129.043863','129.0323513','129.0321161','129.1790264','129.155654','129.1821645','128.5857546','128.5685535','128.5915255','128.5740702','128.5744652','128.5322939','128.480132','128.5416604','128.5413829','128.5542405','128.5449676','128.5516943','128.4403216','128.6243448','128.6512169','128.5652798','128.5888973','128.5492907','128.5591686','128.6121491','128.583336','126.5055503','126.4857303','126.7343354','126.7368535','126.73776','126.7304714','126.6458033','126.6259335','126.6430069','126.6774225','126.6806831','126.7249022','126.720139','126.7537082','126.7242482','126.6835684','126.6797832','126.6698654','126.6707159','126.6543308','126.6739456','126.6704834','126.6711554','126.6895886','126.6367452','124.7210337','126.6324431','126.62911','126.5309952','126.7936441','126.8452952','126.8331574','126.9120408','126.9024487','126.9232534','126.8976064','126.9121416','126.8557328','126.8901122','127.4264857','127.439694','127.4285519','127.4549167','127.4358344','127.3811012','127.3444618','127.3819878','127.3354121','127.3249755','127.3950671','127.4099149','127.4201901','129.323109','129.2689292','129.3363276','129.4171999','129.359018','129.3607112','129.1207447','129.1137363','129.2908982','129.3019745','129.3504146','127.2965149','127.2659986','127.5106021','127.5213756','126.831048','126.7761487','126.7503803','126.8055645','126.7930404','126.7800213','126.9876826','126.8718649','126.8784253','127.2503077','127.2602429','127.1450803','127.1326522','126.9473163','126.9336043','126.9259638','126.7105567','126.6602294','126.7225293','127.1716615','127.1895189','127.2043728','127.1799031','127.0517173','126.7809647','126.796026','126.7999474','126.7621104','126.793031','126.7913912','127.1246778','127.1705808','127.1258278','127.1440617','127.1390574','127.129007','127.1619929','126.9711296','127.0697099','127.0099968','127.0125171','127.0484366','126.9955713','127.0279795','127.0342685','126.728449','126.7893607','126.7245618','126.7852979','126.7401524','126.8152633','126.8450579','126.8248707','126.8076197','126.8745061','127.2603666','127.2707013','127.2698169','126.9520763','126.9329459','126.9619723','126.9244005','127.0466509','127.486681','127.5033202','127.6253194','127.6403936','127.6329352','127.0619752','127.0778337','127.0755032','127.1067681','127.0974472','127.1113805','127.1769667','127.211398','127.2146831','126.9719936','126.9767948','127.0422388','127.0395576','127.0775443','127.045526','127.0621425','127.4332382','127.4523301','126.7743366','126.7802582','126.7748538','127.1204568','127.0890781','127.0743384','127.1118267','126.9320797','127.0571718','127.0664973','127.2012608','127.1982393','127.1383002','127.3172859','127.2141207','126.9108029','126.9045554','127.0786','127.07995','127.0080362','126.8257103','128.8578311','128.9078825','128.8998652','128.8827499','128.4721388','129.1170454','129.1078035','129.1053023','129.1637047','129.1721946','128.5758664','128.5879182','128.5783582','127.9899647','127.9912082','128.6274543','128.4652333','128.4635022','127.9467253','127.9467942','127.9485122','128.1685884','128.6587502','128.6714873','127.3028291','127.3080856','127.7392926','127.7202187','128.9924318','129.0034734','128.390752','127.895432','127.8772881','127.7091114','127.9799426','127.9844383','127.7966885','127.7844689','128.3502768','128.3684483','127.7182079','127.7161841','127.7810242','127.7761216','127.5719433','127.5703364','127.6888784','127.5985471','128.2056668','128.2160857','128.2339493','127.5867262','127.4407308','127.4396611','127.5059388','127.4964513','127.4956207','127.4697464','127.4736673','127.4854666','127.4314487','127.4264912','127.4309411','127.3216409','127.9259405','127.9704035','127.9290733','127.250059','127.1094953','127.1206565','127.4960164','127.492495','127.0938883','127.103564','126.6837884','126.6303477','126.6023715','126.6239802','126.9021219','126.9093371','126.9108551','126.4653869','126.4445143','126.6876019','126.689606','127.0203804','127.0144292','127.0010134','126.8375756','126.8448499','127.1512748','127.1351647','127.1314905','127.1792758','127.155714','126.8049362','126.3236129','126.6744372','126.6630604','126.6832508','126.6934283','126.7205491','126.7119186','126.7369695','126.8833171','127.4072012','127.3645735','127.6716991','126.7355949','126.7347701','127.1436254','127.0926499','126.9674259','126.9664713','127.2875036','127.5201684','127.1327585','127.1533154','127.1247634','127.1343383','127.1478979','126.8244771','126.8546952','127.4347738','127.4317204','126.7574563','126.7749894','127.2942484','127.2690923','127.1457197','127.2884442','127.2969041','127.6969482','127.5837178','127.463944','127.4615362','126.721486','126.7082238','126.7906411','126.805316','126.9828425','126.981059','126.4165107','126.4208613','126.4205475','126.4051551','126.3802241','126.3758652','126.3737322','126.4896865','126.4814693','127.1038173','127.0790386','127.3457661','127.4860723','127.5429331','127.4838456','127.5121695','127.52519','126.351425','125.932507','127.6542287','127.6610585','127.7277735','127.6747652','127.6635403','126.498074','126.5109664','126.504373','126.7013831','126.7036511','126.7355297','126.7312982','126.7833251','126.782454','126.9113739','126.9083332','126.2640783','126.2630946','126.520257','126.5242663','126.6132298','126.6461415','126.6120435','126.9894914','127.0028277','126.9898801','126.9822859','128.7371121','128.7401291','128.7432822','129.2246325','129.1916446','128.2648144','128.272028','128.3827298','128.3407085','128.4227834','128.345954','128.5699533','128.1265921','128.1188234','128.112859','128.1458668','128.1897485','128.1990814','128.1975185','128.7418675','128.7335074','128.1597978','128.1496429','128.2790125','128.7302573','128.7315257','128.7001622','128.7230696','129.4024127','129.3735581','129.118064','129.1170105','128.6219763','128.913317','128.9324649','128.4527933','128.4585932','130.899524','129.4110497','128.6842126','128.694697','129.0518056','128.4186287','128.4015214','129.3804395','129.3962245','129.3615676','129.3462136','129.3545666','128.6256642','128.7221227','128.6365383','128.6436576','127.9088675','127.8987279','128.3154','128.857047','128.8615468','128.8056176','128.8705441','127.8942786','127.8985158','128.7556227','128.7558763','128.0801403','128.064206','128.0795104','127.8842356','129.0064656','129.0436247','129.1645365','129.0249744','128.2587299','128.2547694','128.0899475','128.0919714','128.0881406','128.06939','128.0929798','128.1285473','128.1229024','128.5089764','128.4900535','128.6855335','128.5616009','128.5535505','128.7101584','128.6983349','128.6610876','128.5919659','128.5655594','128.7078072','128.6871908','128.6706321','128.644486','128.4198857','128.4320134','127.7385757','127.752745','128.5156029','128.4105842','127.7293071','127.7317808','128.1633336','128.1567535','126.5638921','126.5654256','126.4850314','126.5462387','126.5170847','126.4704808']
		for (var k = 0; k < 1; k++) {
			// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
			var positions = [ {
				content : hospital[k],
				latlng : new kakao.maps.LatLng(lat[k], lng[k])
			} ]
			for (var i = 0; i < positions.length; i++) {
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					map : map, // 마커를 표시할 지도
					position : positions[i].latlng
				// 마커의 위치
				});
				var markers = []
		};

			// 마커에 표시할 인포윈도우를 생성합니다 
			var infowindow = new kakao.maps.InfoWindow({
				content : hospital[i].content
			// 인포윈도우에 표시할 내용
			});

			markers.push(marker);
			// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			// 이벤트 리스너로는 클로저를 만들어 등록합니다 
			// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
					map, marker, infowindow));
			kakao.maps.event.addListener(marker, 'mouseout',
					makeOutListener(infowindow));
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			}
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			};
		}

		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);

		// 마커 클러스터러에 클릭이벤트를 등록합니다
		// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
		// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
		kakao.maps.event.addListener(clusterer, 'clusterclick', function(
				cluster) {

			// 현재 지도 레벨에서 1레벨 확대한 레벨
			var level = map.getLevel() - 1;

			// 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
			map.setLevel(level, {
				anchor : cluster.getCenter()
			});
		});

		// 지도 타입 변경 컨트롤을 생성한다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// 지도 확대 레벨 변화 이벤트를 등록한다
		kakao.maps.event.addListener(map, 'zoom_changed', function() {
			console.log('지도의 현재 확대레벨은 ' + map.getLevel() + '레벨 입니다.');
		});
	</script>
</body>
</html>