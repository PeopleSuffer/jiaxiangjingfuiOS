//
//  MyService.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/15.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import Foundation
import Moya

enum MyService {
    case getAllFirstClassService
    case getSubClassServices(type: String)
    case getSubClassServiceDetail(id: String)
    case repeatedOrder
    case singletimeOrder
}

extension MyService: TargetType {
    var baseURL: URL { return URL(string: "http://www.yehaikeji.com:8080/")! }
    var path: String {
        switch self {
        case .getAllFirstClassService:
            return "comet/getService/app/getAllService"
        case .getSubClassServices(_):
            return "comet/getService/app/getServiceList"
        case .getSubClassServiceDetail(_):
            return "comet/getService/app/getServiceDetail"
        case .repeatedOrder:
            return "comet/frontOrder/more"
        case .singletimeOrder:
            return "comet/frontOrder/once"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getSubClassServiceDetail, .getSubClassServices:
            return .post
        case .getAllFirstClassService, .repeatedOrder, .singletimeOrder:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getAllFirstClassService, .repeatedOrder, .singletimeOrder:
            return .requestPlain
        case let .getSubClassServices(type):
            return .requestParameters(parameters: ["type": type], encoding: JSONEncoding.default)
        case let .getSubClassServiceDetail(id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .getAllFirstClassService:
            return SampleData.getAllFirstClassService.rawValue.utf8Encoded
        case .getSubClassServices:
            return SampleData.getSubClassServices.rawValue.utf8Encoded
        case .getSubClassServiceDetail:
            return SampleData.getSubClassServiceDetail.rawValue.utf8Encoded
        case .singletimeOrder, .repeatedOrder:
            print("fd")
            return SampleData.Order.rawValue.utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

enum SampleData: String {
    case getAllFirstClassService = "[{\"adImgName\":\"fu01.png\",\"adImgPath\":\"images/fuwu/ad\",\"detImgName\":\"fu01.png\",\"detImgPath\":\"images/fuwu/det\",\"id\":\"FW_CCCM\",\"ig\":0,\"name\":\"除尘除螨\",\"price\":0,\"regionRc\":\"421100000000000\",\"stt\":\"SS_ZS\",\"tp\":\"FW_TOP\"}]"
    case getSubClassServices = "[{\"adImgName\":\"fu01.png\",\"adImgPath\":\"images/fuwu/ad\",\"detImgName\":\"fu01.png\",\"detImgPath\":\"images/fuwu/det\",\"id\":\"FW_CCCM\",\"ig\":0,\"name\":\"除尘除螨\",\"price\":0,\"regionRc\":\"421100000000000\",\"stt\":\"SS_ZS\",\"tp\":\"FW_TOP\"},{\"adImgName\":\"fu01.png\",\"adImgPath\":\"images/fuwu/ad\",\"detImgName\":\"fu01.png\",\"detImgPath\":\"images/fuwu/det\",\"id\":\"FW_FXHL\",\"ig\":0,\"name\":\"翻新护理\",\"price\":0,\"regionRc\":\"421102000000000\",\"stt\":\"SS_ZS\",\"tp\":\"FW_TOP\"}]"
    case getSubClassServiceDetail = "{\"adImgName\":\"fu01.png\",\"adImgPath\":\"images/fuwu/ad\",\"detImgName\":\"fu01.png\",\"detImgPath\":\"images/fuwu/det\",\"id\":\"FW_FXHL\",\"ig\":0,\"name\":\"翻新护理\",\"price\":0,\"regionRc\":\"421102000000000\",\"stt\":\"SS_ZS\",\"tp\":\"FW_TOP\"}]"
    case Order = "[{\"serviceId\": \"SO00002\",\"serviceName\": \"西侧\",\"serviceTime\": \"2017-12-15 21:15:48.0\",\"serviceState\": \"完成\"},{\"serviceId\": \"SO00002\",\"serviceName\": \"西侧\",\"serviceTime\": \"2017-12-15 21:15:48.0\",\"serviceState\": \"完成\"}]"
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

let failureEndpointClosure = { (target: MyService) -> Endpoint<MyService> in
    
    return Endpoint<MyService>(url: URL(target: target).description, sampleResponseClosure: {.networkResponse(2000, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: ["Content-type": "application/json"])
}
var provider = MoyaProvider<MyService>(endpointClosure: failureEndpointClosure ,stubClosure: MoyaProvider.immediatelyStub)

