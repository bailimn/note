``` swift

//
//  HomePartimAPI.swift
//  QBoss
//
//  Created by 董家祎 on 2020/11/28.
//  Copyright © 2020 com.qiyee.qboss. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import iOS_Com_Network
import iOS_Com_AES

enum HomePartimeAPI {
    //获取所有的二级列表
    case getIndustryChildList
    case getAreaList(level:Int, parentId:Int?)
    case positionSearch(parameters: [String: Any])
    case calculateAndVerifyData(data: [[String: Any]])
}

extension HomePartimeAPI: TargetType {
    var path: String {
        switch self {
        case .getIndustryChildList:
            return "system/system/industry/queryIndustryChildInfos"
        case .industryGetIndustryByParentId(let id):
            return "system/system/industry/getIndustryByParentId/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getIndustryChildList:
            return .post
        default:
            return .get
        }
    }

    var parameters: [String: Any]? {
        var dic:[String: Any] = [:]
        switch self {
        case .getIndustryChildList:
            return dic
        case let .getAreaList(level, parentId):
            dic["level"] = level
            if let parentId = parentId {
                dic["parentId"] = parentId
            }
        default:
            break
        }
        return dic
    }

    var parameterArray: [Any]? {
        var array: [Any] = []
        switch self {
        case let .calculateAndVerifyData(data):
            array = data
        case let .create(data):
            array = data
        default:
            break
        }
        return array
    }

    var encoding: URLEncoding{
        switch self {
        case .resumeLike, .applyRejectedOrOfferExpired:
            return .queryString//url中的特殊字符不会被重新编码
        default:
            return .default
        }
    }

    var task: Task {
        switch self {
        case .getIndustryChildList:// post 请求
            let data = try! JSONSerialization.data(withJSONObject: self.parameters!, options: [])
            return .requestCompositeData(bodyData: data, urlParameters: [:])
        case let .uploadFile(file): // 上传数据
            let fileData = MultipartFormData(provider: .data(file), name: "file", fileName: "fileName" + ".pdf", mimeType: "file")
            let multipartData = [fileData]
            let urlParameters: [String: String] = [:]
            return .uploadCompositeMultipart(multipartData, urlParameters: urlParameters)//.uploadMultipart(multipartData)
        case .loginOther: // 加密数据请求
            let json = try! JSONSerialization.data(withJSONObject: self.parameters!, options: .fragmentsAllowed)
            let jsonTxt = String(data: json, encoding: .utf8)
            
            let aesData = AESEncryptor.shared.AESEncrypt(oriTxt: jsonTxt!)
            let aesKey = AESEncryptor.shared.encryptedAESkey
            let params = ["data": aesData, "aesKey": aesKey]
            
            let data = try! JSONSerialization.data(withJSONObject: params, options: [])
            return .requestCompositeData(bodyData: data, urlParameters: [:])
        case .calculateAndVerifyData: // 请求参数是数组
            let data = try! JSONSerialization.data(withJSONObject: self.parameterArray!, options: [])
            return .requestCompositeData(bodyData: data, urlParameters: [:])
        case .confirmClock, .declineClock: // Query (参数放在表单里)
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.queryString)
        default: // get 请求
            return .requestParameters(parameters: self.parameters!, encoding: encoding)
        }
    }
}
```

- 灵感：以类型安全的方式封装网络请求（通常使用枚举）


- Provider: MoyaProvider 与网络进行交互时创建和使用的对象
- Endpoint: 请求正文、标头等

