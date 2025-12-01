
//: Declare String Begin

/*: "Net Error, Try again later" :*/
fileprivate let kAppearStr:String = "Net Einput app date"
fileprivate let userCameraPath:[Character] = ["r","r"]
fileprivate let const_styleText:[Character] = ["o","r",","," ","T","r","y"," ","a","g","a","i","n"," ","l","a","t","e","r"]

/*: "data" :*/
fileprivate let showFailData:String = "drevenuetrevenue"

/*: ":null" :*/
fileprivate let data_againLevelStr:[Character] = [":","n","u","l","l"]

/*: "json error" :*/
fileprivate let noti_titleFormat:String = "json eblack stock select"

/*: "platform=iphone&version= :*/
fileprivate let mainFlexibleTitle:[Character] = ["p","l","a","t","f","o","r","m","=","i","p","h","o","n","e","&","v","e","r","s","i","o"]
fileprivate let data_ratingGenTitle:String = "n=previous automatic"

/*: &packageId= :*/
fileprivate let data_statusMessage:[Character] = ["&","p","a","c","k","a"]
fileprivate let show_receiveValue:[Character] = ["g","e","I","d","="]

/*: &bundleId= :*/
fileprivate let const_modelMsg:String = "bridge for layer&bun"

/*: &lang= :*/
fileprivate let userObserverData:String = "gen dismiss indicator core theoretical&lang="

/*: ; build: :*/
fileprivate let mainTrustData:[Character] = [";"," ","b","u","i","l","d",":"]

/*: ; iOS  :*/
fileprivate let data_stopTitle:[Character] = [";"," ","i","O","S"," "]

//: Declare String End

//: import Alamofire
import Alamofire
//: import CoreMedia
import CoreMedia
//: import HandyJSON
import HandyJSON
// __DEBUG__
// __CLOSE_PRINT__
//: import UIKit
import UIKit

//: typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AppErrorResponse?) -> Void
typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: FirErrorResponse?) -> Void

//: @objc class AppRequestTool: NSObject {
@objc class WindowRequestTool: NSObject {
    /// 发起Post请求
    /// - Parameters:
    ///   - model: 请求参数
    ///   - completion: 回调
    //: class func startPostRequest(model: AppRequestModel, completion: @escaping FinishBlock) {
    class func post(model: ActivePromptRequestModel, completion: @escaping FinishBlock) {
        //: let serverUrl = self.buildServerUrl(model: model)
        let serverUrl = self.pic(model: model)
        //: let headers = self.getRequestHeader(model: model)
        let headers = self.zone(model: model)
        //: AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
        AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
            //: switch responseData.result {
            switch responseData.result {
            //: case .success:
            case .success:
                //: func__requestSucess(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)
                onTheoreticalAccount(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)

            //: case .failure:
            case .failure:
                //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "Net Error, Try again later"))
                completion(false, nil, FirErrorResponse(errorCode: AfterSum.NetError.rawValue, errorMsg: (String(kAppearStr.prefix(5)) + String(userCameraPath) + String(const_styleText))))
            }
        }
    }

    //: class func func__requestSucess(model: AppRequestModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
    class func onTheoreticalAccount(model _: ActivePromptRequestModel, response _: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
        //: var responseJson = String(data: responseData, encoding: .utf8)
        var responseJson = String(data: responseData, encoding: .utf8)
        //: responseJson = responseJson?.replacingOccurrences(of: "\"data\":null", with: "\"data\":{}")
        responseJson = responseJson?.replacingOccurrences(of: "\"" + (showFailData.replacingOccurrences(of: "revenue", with: "a")) + "\"" + (String(data_againLevelStr)), with: "" + "\"" + (showFailData.replacingOccurrences(of: "revenue", with: "a")) + "\"" + ":{}")
        //: if let responseModel = JSONDeserializer<AppBaseResponse>.deserializeFrom(json: responseJson) {
        if let responseModel = JSONDeserializer<ConditionBaseResponse>.deserializeFrom(json: responseJson) {
            //: if responseModel.errno == RequestResultCode.Normal.rawValue {
            if responseModel.errno == AfterSum.Normal.rawValue {
                //: completion(true, responseModel.data, nil)
                completion(true, responseModel.data, nil)
                //: } else {
            } else {
                //: completion(false, responseModel.data, AppErrorResponse.init(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                completion(false, responseModel.data, FirErrorResponse(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                //: switch responseModel.errno {
                switch responseModel.errno {
//                case AfterSum.NeedReLogin.rawValue:
//                    NotificationCenter.default.post(name: DID_LOGIN_OUT_SUCCESS_NOTIFICATION, object: nil, userInfo: nil)
                //: default:
                default:
                    //: break
                    break
                }
            }
            //: } else {
        } else {
            //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "json error"))
            completion(false, nil, FirErrorResponse(errorCode: AfterSum.NetError.rawValue, errorMsg: (String(noti_titleFormat.prefix(6)) + "rror")))
        }
    }

    //: class func buildServerUrl(model: AppRequestModel) -> String {
    class func pic(model: ActivePromptRequestModel) -> String {
        //: var serverUrl: String = model.requestServer
        var serverUrl: String = model.requestServer
        //: let otherParams = "platform=iphone&version=\(AppNetVersion)&packageId=\(PackageID)&bundleId=\(AppBundle)&lang=\(UIDevice.interfaceLang)"
        let otherParams = (String(mainFlexibleTitle) + String(data_ratingGenTitle.prefix(2))) + "\(noti_numberMessage)" + (String(data_statusMessage) + String(show_receiveValue)) + "\(mainSchemeValue)" + (String(const_modelMsg.suffix(4)) + "dleId=") + "\(userSavePath)" + (String(userObserverData.suffix(6))) + "\(UIDevice.interfaceLang)"
        //: if !model.requestPath.isEmpty {
        if !model.requestPath.isEmpty {
            //: serverUrl.append("/\(model.requestPath)")
            serverUrl.append("/\(model.requestPath)")
        }
        //: serverUrl.append("?\(otherParams)")
        serverUrl.append("?\(otherParams)")

        //: return serverUrl
        return serverUrl
    }

    /// 获取请求头参数
    /// - Parameter model: 请求模型
    /// - Returns: 请求头参数
    //: class func getRequestHeader(model: AppRequestModel) -> HTTPHeaders {
    class func zone(model _: ActivePromptRequestModel) -> HTTPHeaders {
        //: let userAgent = "\(AppName)/\(AppVersion) (\(AppBundle); build:\(AppBuildNumber); iOS \(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        let userAgent = "\(notiAutomaticUrl)/\(noti_domainMsg) (\(userSavePath)" + (String(mainTrustData)) + "\(notiMagnituderyKey)" + (String(data_stopTitle)) + "\(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        //: let headers = [HTTPHeader.userAgent(userAgent)]
        let headers = [HTTPHeader.userAgent(userAgent)]
        //: return HTTPHeaders(headers)
        return HTTPHeaders(headers)
    }
}
