
// 获取用户信息
UserCenter.shared.requestUserInfo(showHUD: false) {[weak self] user in
    self?.updateProfileItemArray()
}


ReviewBusinessViewModel.shared.saveBusiness(state: state.rawValue, content: "服务端未返回")


// 离职 userCompanyStatus
// 0:离职 member被super移除、主动离职
// 1:member审核通过
// -1:审核中，审核拒绝（在这里才判断isAgree），刚创建的新账号


switch type {
case .memberApproved: net
    You are now Member of Starbucks.
case .memberRejected: net
    Your application to become Member of Starbucks is rejected.
case .memberReviewing: app
    Your Profile is successfully created. We will notify you once your profile is approved by Admin of the business.
case .memberRemoved: net 提供公司名
    You are removed as Member of Starbucks Jakarta. Enter a new business or contact Admin for further questions.
case .memberAdmin: app
    You are an Admin of Starbucks Jakarta. You can access Business Profile Management.
    You are an Admin of Starbucks Jakarta. You can access Business Profile Management.
case .superApproved: net
    Your business documents have been approved. Your business is now verified.
case .superRejected: net
    Your business documents are rejected. Please recheck and resubmit.
case .none:
    return nil
}

BoRouter.shared.open(.checkBusinessStateForMember(callback: { [weak self] data in
    guard let self = self else { return }
    guard let state = data["state"] as? Bool else { return }
    if state {
        self.datas?[index].router?()
    }
}))


public func updateWithNotification(kvPairs: [AnyHashable : Any], userInfo: [AnyHashable : Any]) {
    print("updateReviewBusiness： \(kvPairs)  \n\(userInfo)")
    /*
        pushType // 业务类型 1member审核 2公司审核 3雇主被移除 4admin权限转移 状态3和4由userCenter接口返回
        operateType // 0拒绝1同意 对应审核业务类型
        */
    if let pushType = kvPairs["pushType"] as? String {
        let operateType = kvPairs["operateType"] as? String ?? ""
        guard let state = ReviewBusinessViewModel.shared.netStateToLocalForReviewBusiness(pushType: pushType, operateType: operateType) else {
            return
        }
        ReviewBusinessViewModel.shared.saveBusiness(state: state.rawValue, content: getAlertBody(userInfo: userInfo))
        UserCenter.shared.requestUserInfo()
    }
}


Model -> Json
guard let data = try? JSONEncoder().encode(searchPatameters),
        let dic = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
    return
}

HomePartimeAPI.positionSearch(parameters: dic).request(type: HomeEmployeBodyModel?.self)
    .subscribe {[weak self] res in
        self?.jobListRelay.accept(res.body?.jobResList)
    } onError: {[weak self] err in
        self?.jobListRelay.accept(nil)
        err.show()
    }.disposed(by: rx.disposeBag)


func toDictionary() -> [String: Any]?{
    guard let data = try? self.toJSON() else {
        return nil
    }
    return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
}



// 富文本
let littleAttributes = [NSAttributedString.Key.font: UIFont.customFont(ofSize: 12, weight: .regular),
                            NSAttributedString.Key.foregroundColor: lTheme.black]
let bigAttributes = [NSAttributedString.Key.font: UIFont.customFont(ofSize: 16, weight: .regular),
                        NSAttributedString.Key.foregroundColor: lTheme.black]

let attribute = NSMutableAttributedString(string: "From" + " ", attributes: littleAttributes)
attribute.append(NSAttributedString(string: model.workDateStart ?? "", attributes: bigAttributes))
attribute.append(NSAttributedString(string: " " + "To" + " ", attributes: littleAttributes))
attribute.append(NSAttributedString(string: model.workDateEnd ?? "", attributes: bigAttributes))


// 成功toust
HUD.succeed(localize.submit_success())


///将 PositionModel  转换成 Item.allCases
static func transformJobModel(model: PositionModel?) {
    guard let model = model else {
        return
    }
    Item.allCases.forEach { item in
        switch item {
        case .position:
            _content[.position] = ItemContent(showName: model.jobClassificationName?.addObliqueLineTrim(), content: model.jobClassification)
        case .title:
            _content[.title] = ItemContent(showName: model.jobTitle, content: model.jobTitle)
        case .staffNumber:
            _content[.staffNumber] = ItemContent(showName: model.jobVacancy?.toString(), content: model.jobVacancy)
        case .settlement:
            _content[.settlement] = ItemContent(showName: model.settlementMethodName, content: model.settlementMethod)
        case .period:
            var totaldays: String = ""
            if let days = model.workTotalDay {
                totaldays = localize.peroid_totaldays(days.toString())
            }
            let period = JobPeriod(workDateStart: model.workDateStart, workDateEnd: model.workDateEnd, workTimeStart: model.workTimeStart, workTimeEnd: model.workTimeEnd, workDayOff: model.workDayOff)
            _content[.period] = ItemContent(attributedString: period.showName, content: period, bottomRightTip: totaldays)
        case .salary:
            var totalMoney = ""
            if let money = model.workTotalSalary?.float()?.int.toString().moneyString() {
                totalMoney = localize.salary_total(money)
            }
            _content[.salary] = ItemContent(showName: model.salary?.toString(), content: model.salary?.toString(), bottomRightTip: totalMoney)
        case .isHome:
            _content[.isHome] = ItemContent(showName: model.workFromHome?.toString(), content: model.workFromHome)
        case .location:
            debugPrint("location")
        case .gender:
            _content[.gender] = ItemContent(genderName: model.genderReq.genderString, code: model.genderReq.toString())
        case .age:
            let ageRanged = RequirementsItemModel.ageRange(minName: model.ageMinReqShow, maxName: model.ageMaxReqShow)
            let content = (model.ageMinReq.toString(), model.ageMaxReq.toString())
            _content[.age] = ItemContent(showName: ageRanged, content: content)
        case .jobDescription:
            _content[.jobDescription] = ItemContent(showName: model.jobDescription, content: model.jobDescription)
        }
    }
}

// 判断求职者
if UserCenter.shared.userModel.value?.roleType == .employe {



// keywindow 显示弹窗
UIApplication.shared.keyWindow?.rootViewController?.showAlert(type: .warn, title: localize.warning_tip(), message: model.content, okTitle: localize.my_employView_customerService(), cancelTitle:localize.cancel() , okHandler: {
                    guard let code = model.deleteMessageBox else { return }
                    ReviewBusinessViewModel.shared.deleteMessageBox(type: code)
                    BoRouter.shared.pushToWeb(BoRouterCase.WebUrls.customerservice)
                }, cancelHandler: {
                    guard let code = model.deleteMessageBox else { return }
                    ReviewBusinessViewModel.shared.deleteMessageBox(type: code)
                })


// 按钮背景颜色
nextButton.setBackgroundImage(lTheme.brandTeal.toImage(size: CGSize(width: 1, height: 1)), for: .normal)
nextButton.setBackgroundImage(lTheme.separator.toImage(size: CGSize(width: 1, height: 1)), for: .disabled)


// 检查表单
func checkData(data: [Any?]) -> Bool {
        for item in data {
            if item == nil {
                return false
            }
            if let item = item as? Double {
                if item <= 0 {
                    return false
                }
            } else if let item = item as? String {
                if item == "" {
                    return false
                }
            }
        }
        return true
    }


export LANG="zh_CN.UTF-8" && sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/sarkrui/Eudic-for-Mac@master/Eudic_cn.sh)"


Included in the DTrace command options is a nice little option, -l, which will list all the probes you’ve matched against in your probe description. When you have the -l option, DTrace will only list the probes and not execute any actions, regardless of whether you supply them or not.
This makes the -l option a nice tool to learn what will and will not work.
You will look at a probe description one more time while building up a DTrace script and systematically limiting its scope. Consider the following, Do NOT execute this:


// 全屏 present
BoRouter.shared.qyPresentWithNavigation(.edithomeAddress(callBack: { [weak self] data in
    guard let self = self else { return }
    
    
    guard let provinceId = data["provinceId"], let cityId = data["cityId"], let areaId = data["areaId"] , let postalCode = data["postalCode"] , let areaStr = data["areaStr"] else {
        return
    }
    
    self.updateSelectedCell(text: areaStr, code: "", provinceId: provinceId, cityId: cityId, areaId: areaId, postalCode:postalCode)
                
}), height: kMianHeight, cornerRadius:0,isTouchEnable:false)