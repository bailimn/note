public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.statusBarStyle = .default
    navigationController?.navigationBar.style = .whiteWithLine
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    // 隐藏线
    navigationController?.navigationBar.style = .white
}

enum BONavigationBarStyle {
        ///颜色： brandTeal
        case primary
        ///白色
        case white
        ///白色底部带线
        case whiteWithLine
    }

@objc func myBackAction() {
        if  navigationController?.popViewController(animated: true) == nil {
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    func initSubViews() {
        title = localize.job_detail()
        
        navigationItem.leftBarButtonItem = NavigationBackItem(style: .grayArrow, target: self, action: #selector(myBackAction))
        
    }


[{
			"jobId": 1425276489166905373,
			"employeeId": 1412759769290555480,
			"salary": 88,
			"salaryUnit": 1,
			"expireType": 24,
			"workDateStart": "11 Sep 2021 0:00",
			"workDateEnd": "12 Oct 2021 0:00",
			"workTimeStart": "09:30",
			"workTimeEnd": "11:00",
			"workDayOff": "0,1",
			"workTotalDate": 27,
			"workTotalSalary": "3564.0",
			"paymentMethod": 0,
			"location": "DKI JAKARTA, KOTA JAKARTA SELATAN, KEC. MAMPANG PRPT.,8 Jalan Kuningan Barat Raya,  Pasar Manggis,  Kecamatan Setiabudi,  Daerah Khusus Ibukota Jakarta",
			"longitude": "106.8240784",
			"latitude": "-6.2386491",
			"cityId": 3171,
			"provinceId": 31,
			"countyId": 3171070,
			"workFromHome": 0
		}]
[{
	"cityId": 3171,
	"provinceId": 31,
	"countyId": 3171070,
	"longitude": "106.8240784",
	"employeeId": 1412759769290555480,
	"salary": 88,
	"expireType": 24,
	"workDateEnd": "12 Oct 2021 0:00",
	"location": "DKI JAKARTA, KOTA JAKARTA SELATAN, KEC. MAMPANG PRPT.,8 Jalan Kuningan Barat Raya,  Pasar Manggis,  Kecamatan Setiabudi,  Daerah Khusus Ibukota Jakarta",
	"salaryUnit": 1,
	"workFromHome": 0,
	"workDateStart": "11 Sep 2021 0:00",
	"workTimeStart": "09:30",
	"paymentMethod": 0,
	"workTotalDate": 27,
	"latitude": "-6.2386491",
	"workTotalSalary": "3564.0",
	"workDayOff": "0,1",
	"jobId": 1425276489166905373,
	"workTimeEnd": "11:00"
}]