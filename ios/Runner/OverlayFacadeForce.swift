
//: Declare String Begin

/*: "getDeviceID" :*/
fileprivate let notiSizeData:String = "view windowgetDe"
fileprivate let dataPromptFormat:[Character] = ["I","D"]

/*: "getFirebaseID" :*/
fileprivate let user_labStr:[Character] = ["g","e","t","F","i","r","e","b"]
fileprivate let dataGenerateDiskMsg:String = "object accountaseID"

/*: "getAreaISO" :*/
fileprivate let noti_pointMessage:String = "getArdecision finish hurry"
fileprivate let user_mapHireMsg:String = "eaISOoption can"

/*: "getProxyStatus" :*/
fileprivate let app_receiveData:String = "poor clear element kit homegetP"
fileprivate let notiBlackValue:String = "areasonus"

/*: "getMicStatus" :*/
fileprivate let mainExecuteMessage:[Character] = ["g","e","t","M","i","c","S","t"]
fileprivate let k_allowData:String = "ATUS"

/*: "getPhotoStatus" :*/
fileprivate let mainValuePath:String = "frame countgetPho"
fileprivate let noti_timeWindowTitle:[Character] = ["t","o","S","t","a","t","u","s"]

/*: "getCameraStatus" :*/
fileprivate let mainPanelData:String = "getCaprint vertical transaction register"
fileprivate let main_yourPath:String = "succeedasucceedu"
fileprivate let notiProcessFormat:String = "us"

/*: "reportAdjust" :*/
fileprivate let userContactMessage:String = "REPORT"

/*: "requestLocalPush" :*/
fileprivate let noti_createMessage:String = "rdistantuest"
fileprivate let constLabValue:[Character] = ["L","o","c"]
fileprivate let data_captureFormat:String = "alPushrevenue block between item"

/*: "getLangCode" :*/
fileprivate let userOkTitleId:[Character] = ["g","e","t","L","a","n"]
fileprivate let constPrivacyLabTitle:[Character] = ["g","C","o","d","e"]

/*: "getTimeZone" :*/
fileprivate let constNeedName:String = "end selected systemgetTim"

/*: "getInstalledApps" :*/
fileprivate let noti_mediaPath:String = "finish first us subgetIn"
fileprivate let data_sessionTitle:String = "edAppswill inner your no"

/*: "getSystemUUID" :*/
fileprivate let user_globalMsg:String = "getSystload notice presentation package allow"
fileprivate let kUpStr:String = "emUUIDdecide body tool"

/*: "getCountryCode" :*/
fileprivate let main_numberId:String = "net"
fileprivate let mainHomeData:String = "return safe behavior challenge decideetCo"
fileprivate let constAgainPath:String = "failure should event rating scaleyCode"

/*: "inAppRating" :*/
fileprivate let data_showRangeFormat:[Character] = ["i","n","A","p","p","R","a","t","i","n","g"]

/*: "apPay" :*/
fileprivate let app_recordValue:String = "apPaycolor manager bridge"

/*: "subscribe" :*/
fileprivate let main_padSumFormat:String = "centerubcenter"
fileprivate let notiTrustId:[Character] = ["e"]

/*: "openSystemBrowser" :*/
fileprivate let constStyleMessage:[Character] = ["o","p","e","n","S","y","s","t"]
fileprivate let userCoreName:[Character] = ["e","m","B","r","o","w","s","e","r"]

/*: "closeWebview" :*/
fileprivate let appSchemePath:[Character] = ["c","l","o","s","e","W","e","b","v","i","e","w"]

/*: "openNewWebview" :*/
fileprivate let dataHomeUrl:[Character] = ["o","p","e","n","N","e","w"]
fileprivate let const_serverUrl:String = "pic minimumWe"
fileprivate let noti_byName:[Character] = ["b","v","i","e","w"]

/*: "reloadWebview" :*/
fileprivate let main_sinceStr:[Character] = ["r","e","l","o","a","d","W","e","b"]
fileprivate let constServerFormat:String = "veventw"

/*: "typeName" :*/
fileprivate let showLogTitle:[UInt8] = [0x43,0x4e,0x47,0x52,0x79,0x56,0x5a,0x52]

private func languageI(status num: UInt8) -> UInt8 {
    return num ^ 55
}

/*: "deviceID" :*/
fileprivate let app_matchData:[UInt8] = [0x6d,0x6c,0x7f,0x60,0x6a,0x6c,0x40,0x4d]

private func reasonAdjust(scheme num: UInt8) -> UInt8 {
    return num ^ 9
}

/*: "fireBaseID" :*/
fileprivate let constWithValue:[UInt8] = [0xd,0x2,0x19,0xe,0x29,0xa,0x18,0xe,0x22,0x2f]

private func spaceAllow(protection num: UInt8) -> UInt8 {
    return num ^ 107
}

/*: "areaISO" :*/
fileprivate let dataToAgentTitle:[UInt8] = [0x71,0x82,0x75,0x71,0x59,0x63,0x5f]

fileprivate func subS(filter num: UInt8) -> UInt8 {
    let value = Int(num) + 240
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "isProxy" :*/
fileprivate let notiInputTitle:[UInt8] = [0x77,0x81,0x5e,0x80,0x7d,0x86,0x87]

fileprivate func beggarMyNeighbourPolicy(re num: UInt8) -> UInt8 {
    let value = Int(num) - 14
    if value < 0 {
        return UInt8(value + 256)
    } else {
        return UInt8(value)
    }
}

/*: "langCode" :*/
fileprivate let showAutomaticMakeValue:[UInt8] = [0xe8,0xe5,0xea,0xe3,0xc7,0xeb,0xe0,0xe1]

/*: "timeZone" :*/
fileprivate let constDiskUrl:[UInt8] = [0x3c,0x21,0x25,0x2d,0x12,0x27,0x26,0x2d]

/*: "installedApps" :*/
fileprivate let const_sessionPath:[UInt8] = [0x3c,0x41,0x46,0x47,0x34,0x3f,0x3f,0x38,0x37,0x14,0x43,0x43,0x46]

fileprivate func progressNever(bar num: UInt8) -> UInt8 {
    let value = Int(num) + 45
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "systemUUID" :*/
fileprivate let dataManagerFormat:[UInt8] = [0x88,0x8e,0x88,0x89,0x7a,0x82,0x6a,0x6a,0x5e,0x59]

fileprivate func sawLog(stock num: UInt8) -> UInt8 {
    let value = Int(num) + 235
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "countryCode" :*/
fileprivate let user_actionPostToPath:[UInt8] = [0xf2,0xfe,0xe4,0xff,0xe5,0xe3,0xe8,0xd2,0xfe,0xf5,0xf4]

private func reduceDistant(load num: UInt8) -> UInt8 {
    return num ^ 145
}

/*: "status" :*/
fileprivate let user_searchValue:[UInt8] = [0x73,0x75,0x74,0x61,0x74,0x73]

/*: "isAuth" :*/
fileprivate let showCenterProtectionFormat:[UInt8] = [0x31,0x3b,0x9,0x3d,0x3c,0x30]

fileprivate func selectAccessibleStatus(info num: UInt8) -> UInt8 {
    let value = Int(num) + 56
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "isFirst" :*/
fileprivate let main_launchUrl:[UInt8] = [0xc9,0xd3,0xe6,0xc9,0xd2,0xd3,0xd4]

private func currentNativeApp(show num: UInt8) -> UInt8 {
    return num ^ 160
}

/*: __LocalPush" :*/
fileprivate let notiFilterTitle:[Character] = ["_","_","L","o","c"]
fileprivate let dataAlwaysPath:[Character] = ["a","l","P","u","s","h"]

/*: "identifier" :*/
fileprivate let noti_sceneMsg:[UInt8] = [0xae,0xa3,0xa2,0xa9,0xb3,0xae,0xa1,0xae,0xa2,0xb5]

/*: "HTTPProxy" :*/
fileprivate let dataPromptName:[Character] = ["H","T","T","P","P"]
fileprivate let k_bridgeExecuteData:String = "rcountryy"

/*: "HTTPSProxy" :*/
fileprivate let dataCurrentScriptKey:String = "HtoPS"
fileprivate let k_linkActivePath:String = "path number styleProxy"

/*: "SOCKSProxy" :*/
fileprivate let kTheoreticalTitle:String = "fieldOCK"

/*: "__SCOPED__" :*/
fileprivate let constSaveValue:String = "__SCOrating sound self"

/*: "tap" :*/
fileprivate let showAtTitleText:String = "tatun"

/*: "tun" :*/
fileprivate let user_betweenUrl:String = "normaln"

/*: "ipsec" :*/
fileprivate let k_deadlinePath:String = "IPSEC"

/*: "ppp" :*/
fileprivate let appPlatformWithUrl:String = "allp"

/*: "Retry After or Go to " :*/
fileprivate let notiSystemStr:String = "Retry Alaunch empty"
fileprivate let constPreviousStr:String = "timeer"
fileprivate let data_headName:[Character] = ["G","o"," ","t","o"," "]

/*: "Feedback" :*/
fileprivate let k_bounceKey:String = "warn that caseFeedback"

/*: " to contact us" :*/
fileprivate let noti_padContent:[Character] = [" ","t","o"," ","c","o","n","t","a","c"]
fileprivate let notiSpaceValue:[Character] = ["t"," ","u","s"]

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  OverlayFacadeForce.swift
//  OverseaH5
//
//  Created by young on 2025/9/23.
//

//: import CoreTelephony
import CoreTelephony
//: import FirebaseMessaging
import FirebaseMessaging
//: import HandyJSON
import HandyJSON
//: import StoreKit
import StoreKit
//: import UIKit
import UIKit

/// H5事件
//: private let getDeviceID     = "getDeviceID"        // 获取设备号
private let const_logFollowPath = (String(notiSizeData.suffix(5)) + "vice" + String(dataPromptFormat)) // 获取设备号
//: private let getFirebaseID   = "getFirebaseID"      // 获取FireBaseToken
private let dataRequestPath = (String(user_labStr) + String(dataGenerateDiskMsg.suffix(5))) // 获取FireBaseToken
//: private let getAreaISO      = "getAreaISO"         // 获取 SIM/运营商 地区ISO
private let kHandleCameraName = (String(noti_pointMessage.prefix(5)) + String(user_mapHireMsg.prefix(5))) // 获取 SIM/运营商 地区ISO
//: private let getProxyStatus  = "getProxyStatus"     // 获取是否使用了代理
private let k_cornerPath = (String(app_receiveData.suffix(4)) + "roxySt" + notiBlackValue.replacingOccurrences(of: "reason", with: "t")) // 获取是否使用了代理
//: private let getMicStatus    = "getMicStatus"       // 获取麦克风权限
private let noti_innerMessage = (String(mainExecuteMessage) + k_allowData.lowercased()) // 获取麦克风权限
//: private let getPhotoStatus  = "getPhotoStatus"     // 获取相册权限
private let app_checkFormat = (String(mainValuePath.suffix(6)) + String(noti_timeWindowTitle)) // 获取相册权限
//: private let getCameraStatus = "getCameraStatus"    // 获取相机权限
private let showDataText = (String(mainPanelData.prefix(5)) + "meraS" + main_yourPath.replacingOccurrences(of: "succeed", with: "t") + notiProcessFormat.replacingOccurrences(of: "us", with: "s")) // 获取相机权限
//: private let reportAdjust    = "reportAdjust"       // 上报Adjust
private let notiCreateValue = (userContactMessage.lowercased() + "Adjust") // 上报Adjust
//: private let requestLocalPush = "requestLocalPush"  // APP在后台收到音视频通话推送
private let constQuantityTitle = (noti_createMessage.replacingOccurrences(of: "distant", with: "eq") + String(constLabValue) + String(data_captureFormat.prefix(6))) // APP在后台收到音视频通话推送
//: private let getLangCode      = "getLangCode"        // 获取系统语言
private let notiTransportId = (String(userOkTitleId) + String(constPrivacyLabTitle)) // 获取系统语言
//: private let getTimeZone      = "getTimeZone"        // 获取当前系统时区
private let user_dataUpAccessibleStr = (String(constNeedName.suffix(6)) + "eZone") // 获取当前系统时区
//: private let getInstalledApps = "getInstalledApps"   // 获取已安装应用列表
private let k_replaceData = (String(noti_mediaPath.suffix(5)) + "stall" + String(data_sessionTitle.prefix(6))) // 获取已安装应用列表
//: private let getSystemUUID    = "getSystemUUID"      // 获取系统UUID
private let show_systemData = (String(user_globalMsg.prefix(7)) + String(kUpStr.prefix(6))) // 获取系统UUID
//: private let getCountryCode   = "getCountryCode"     // 获取当前系统地区
private let k_environmentTitle = (main_numberId.replacingOccurrences(of: "net", with: "g") + String(mainHomeData.suffix(4)) + "untr" + String(constAgainPath.suffix(5))) // 获取当前系统地区
//: private let inAppRating      = "inAppRating"        // 应用内评分
private let show_localId = (String(data_showRangeFormat)) // 应用内评分
//: private let apPay            = "apPay"              // 苹果支付
private let main_adjustData = (String(app_recordValue.prefix(5))) // 苹果支付
//: private let subscribe        = "subscribe"          // 苹果支付-订阅
private let notiKeyPath = (main_padSumFormat.replacingOccurrences(of: "center", with: "s") + "crib" + String(notiTrustId)) // 苹果支付-订阅
//: private let openSystemBrowser = "openSystemBrowser" // 调用系统浏览器打开url
private let kToolStr = (String(constStyleMessage) + String(userCoreName)) // 调用系统浏览器打开url
//: private let closeWebview     = "closeWebview"       // 关闭当前webview
private let show_noticeMethodKey = (String(appSchemePath)) // 关闭当前webview
//: private let openNewWebview   = "openNewWebview"     // 使用新webview打开url
private let const_systemMsg = (String(dataHomeUrl) + String(const_serverUrl.suffix(2)) + String(noti_byName)) // 使用新webview打开url
//: private let reloadWebview    = "reloadWebview"      // 重载webView
private let kVersionData = (String(main_sinceStr) + constServerFormat.replacingOccurrences(of: "event", with: "ie")) // 重载webView

//: struct JSMessageModel: HandyJSON {
struct StateMessageModel: HandyJSON {
    //: var typeName = ""
    var typeName = ""
    //: var token: String?
    var token: String?
    //: var totalCount: Double?
    var totalCount: Double?

    //: var showText: String?
    var showText: String?
    //: var data: UserInfoModel?
    var data: CountHandyJSON?
    // 内购/订阅 H5参数
    //: var goodsId: String?
    var goodsId: String? // 商品Id
    //: var source: Int?
    var source: Int? // 充值来源
    //: var type: Int?
    var type: Int? // 订阅入口；1：首页banner，2：全屏充值页，3：半屏充值页，4：领取金币弹窗
    //: var url: String?
    var url: String? // url
    //: var fullscreen: Int?
    var fullscreen: Int? // fullscreen：0:页面从状态栏以下渲染 1:全屏
    //: var transparency: Int?
    var transparency: Int? // transparency：0-webview白色背景 1-webview透明背景
}

//: struct UserInfoModel: HandyJSON {
struct CountHandyJSON: HandyJSON {
    //: var headPic: String?
    var headPic: String? // 头像
    //: var nickname: String?
    var nickname: String? // 昵称
    //: var uid: String?
    var uid: String? // 用户Id
}

//: extension AppWebViewController {
extension ServiceSpecifyMissingNavigationDelegate {
    //: func handleH5Message(schemeDic: [String: Any], callBack: @escaping (_ backDic: [String: Any]) -> Void) {
    func productPage(schemeDic: [String: Any], callBack: @escaping (_ backDic: [String: Any]) -> Void) {
        //: if let model = JSMessageModel.deserialize(from: schemeDic) {
        if let model = StateMessageModel.deserialize(from: schemeDic) {
            //: switch model.typeName {
            switch model.typeName {
            //: case getDeviceID:
            case const_logFollowPath:
                //: let adidStr = AppAdjustManager.getAdjustAdid()
                let adidStr = StorageOrDecorator.beginColor()
                //: callBack(["typeName": model.typeName, "deviceID": adidStr])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: app_matchData.map{reasonAdjust(scheme: $0)}, encoding: .utf8)!: adidStr])

            //: case getFirebaseID:
            case dataRequestPath:
                //: AppWebViewController.getFireBaseToken { str in
                ServiceSpecifyMissingNavigationDelegate.atomicQuantity85Device { str in
                    //: callBack(["typeName": model.typeName, "fireBaseID": str])
                    callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: constWithValue.map{spaceAllow(protection: $0)}, encoding: .utf8)!: str])
                }

            //: case getAreaISO:
            case kHandleCameraName:
                //: let arr = AppWebViewController.getCountryISOCode()
                let arr = ServiceSpecifyMissingNavigationDelegate.frame()
                //: callBack(["typeName": model.typeName, "areaISO": arr.joined(separator: ",")])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: dataToAgentTitle.map{subS(filter: $0)}, encoding: .utf8)!: arr.joined(separator: ",")])

            //: case getProxyStatus:
            case k_cornerPath:
                //: let status = AppWebViewController.getUsedProxyStatus()
                let status = ServiceSpecifyMissingNavigationDelegate.push()
                //: callBack(["typeName": model.typeName, "isProxy": status])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: notiInputTitle.map{beggarMyNeighbourPolicy(re: $0)}, encoding: .utf8)!: status])

            //: case getLangCode:
            case notiTransportId:
                //: let langCode = UIDevice.langCode
                let langCode = UIDevice.langCode
                //: callBack(["typeName": model.typeName, "langCode": langCode])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: showAutomaticMakeValue.map{$0^132}, encoding: .utf8)!: langCode])

            //: case getTimeZone:
            case user_dataUpAccessibleStr:
                //: let timeZone = UIDevice.timeZone
                let timeZone = UIDevice.timeZone
                //: callBack(["typeName": model.typeName, "timeZone": timeZone])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: constDiskUrl.map{$0^72}, encoding: .utf8)!: timeZone])

            //: case getInstalledApps:
            case k_replaceData:
                //: let apps = UIDevice.getInstalledApps
                let apps = UIDevice.getInstalledApps
                //: callBack(["typeName": model.typeName, "installedApps": apps])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: const_sessionPath.map{progressNever(bar: $0)}, encoding: .utf8)!: apps])

            //: case getSystemUUID:
            case show_systemData:
                //: let uuid = UIDevice.systemUUID
                let uuid = UIDevice.systemUUID
                //: callBack(["typeName": model.typeName, "systemUUID": uuid])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: dataManagerFormat.map{sawLog(stock: $0)}, encoding: .utf8)!: uuid])

            //: case getCountryCode:
            case k_environmentTitle:
                //: let countryCode = UIDevice.countryCode
                let countryCode = UIDevice.countryCode
                //: callBack(["typeName": model.typeName, "countryCode": countryCode])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: user_actionPostToPath.map{reduceDistant(load: $0)}, encoding: .utf8)!: countryCode])

            //: case inAppRating:
            case show_localId:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: AppWebViewController.requestInAppRating()
                ServiceSpecifyMissingNavigationDelegate.home()

            //: case apPay:
            case main_adjustData:
                //: if let goodsId = model.goodsId, let source = model.source {
                if let goodsId = model.goodsId, let source = model.source {
                    //: self.applePay(productId: goodsId, source: source, payType: .Pay) { success in
                    self.head(productId: goodsId, source: source, payType: .Pay) { success in
                        //: callBack(["typeName": model.typeName, "status": success])
                        callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: user_searchValue.reversed(), encoding: .utf8)!: success])
                    }
                }

            //: case subscribe:
            case notiKeyPath:
                //: if let goodsId = model.goodsId {
                if let goodsId = model.goodsId {
                    //: self.applePay(productId: goodsId, payType: .Subscribe) { success in
                    self.head(productId: goodsId, payType: .Subscribe) { success in
                        //: callBack(["typeName": model.typeName, "status": success])
                        callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: user_searchValue.reversed(), encoding: .utf8)!: success])
                    }
                }

            //: case openSystemBrowser:
            case kToolStr:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: if let urlStr = model.url, let openURL = URL(string: urlStr) {
                if let urlStr = model.url, let openURL = URL(string: urlStr) {
                    //: UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
                    UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
                }

            //: case closeWebview:
            case show_noticeMethodKey:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: self.closeWeb()
                self.event()

            //: case openNewWebview:
            case const_systemMsg:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: if let urlStr = model.url,
                if let urlStr = model.url,
                   //: let transparency = model.transparency,
                   let transparency = model.transparency,
                   //: let fullscreen = model.fullscreen {
                   let fullscreen = model.fullscreen
                {
                    //: AppWebViewController.openNewWebView(urlStr, transparency, fullscreen)
                    ServiceSpecifyMissingNavigationDelegate.to(urlStr, transparency, fullscreen)
                }

            //: case reloadWebview:
            case kVersionData:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: self.reloadWebView()
                self.third()

            //: case getMicStatus:
            case noti_innerMessage:
                //: AppPermissionTool.shared.requestMicPermission { auth, isFirst in
                DirectMethodTag.shared.key { auth, isFirst in
                    //: callBack(["typeName": model.typeName, "isAuth": auth, "isFirst": isFirst])
                    callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: showCenterProtectionFormat.map{selectAccessibleStatus(info: $0)}, encoding: .utf8)!: auth, String(bytes: main_launchUrl.map{currentNativeApp(show: $0)}, encoding: .utf8)!: isFirst])
                }

            //: case getPhotoStatus:
            case app_checkFormat:
                //: AppPermissionTool.shared.requestPhotoPermission { auth, isFirst in
                DirectMethodTag.shared.atScript { auth, isFirst in
                    //: callBack(["typeName": model.typeName, "isAuth": auth, "isFirst": isFirst])
                    callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: showCenterProtectionFormat.map{selectAccessibleStatus(info: $0)}, encoding: .utf8)!: auth, String(bytes: main_launchUrl.map{currentNativeApp(show: $0)}, encoding: .utf8)!: isFirst])
                }

            //: case getCameraStatus:
            case showDataText:
                //: AppPermissionTool.shared.requestCameraPermission { auth, isFirst in
                DirectMethodTag.shared.launch { auth, isFirst in
                    //: callBack(["typeName": model.typeName, "isAuth": auth, "isFirst": isFirst])
                    callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName, String(bytes: showCenterProtectionFormat.map{selectAccessibleStatus(info: $0)}, encoding: .utf8)!: auth, String(bytes: main_launchUrl.map{currentNativeApp(show: $0)}, encoding: .utf8)!: isFirst])
                }

            //: case reportAdjust:
            case notiCreateValue:
                //: if let token = model.token {
                if let token = model.token {
                    //: if let count = model.totalCount {
                    if let count = model.totalCount {
                        //: AppAdjustManager.addPurchasedEvent(token: token, count: count)
                        StorageOrDecorator.media(token: token, count: count)
                        //: } else {
                    } else {
                        //: AppAdjustManager.addEvent(token: token)
                        StorageOrDecorator.revenue(token: token)
                    }
                }
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])

            //: case requestLocalPush:
            case constQuantityTitle:
                //: callBack(["typeName": model.typeName])
                callBack([String(bytes: showLogTitle.map{languageI(status: $0)}, encoding: .utf8)!: model.typeName])
                //: AppWebViewController.pushLocalNotification(model)
                ServiceSpecifyMissingNavigationDelegate.publicTransport(model)

            //: default: break
            default: break
            }
        }
    }
}

// MARK: - Event

//: extension AppWebViewController {
extension ServiceSpecifyMissingNavigationDelegate {
    /// 打开新的webview
    /// - Parameters:
    ///   - urlStr: web地址
    ///   - transparency: 0：白色背景 1：透明背景
    ///   - fullscreen: 0:页面从状态栏以下渲染  1：全屏
    //: class func openNewWebView(_ urlStr: String, _ transparency: Int = 0, _ fullscreen: Int = 1) {
    class func to(_ urlStr: String, _ transparency: Int = 0, _ fullscreen: Int = 1) {
        //: let vc = AppWebViewController()
        let vc = ServiceSpecifyMissingNavigationDelegate()
        //: vc.urlString = urlStr
        vc.urlString = urlStr
        //: vc.clearBgColor = (transparency == 1)
        vc.clearBgColor = (transparency == 1)
        //: vc.fullscreen = (fullscreen == 1)
        vc.fullscreen = (fullscreen == 1)
        //: vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .fullScreen
        //: AppConfig.currentViewController()?.present(vc, animated: true)
        NotificationProcessStyle.picList()?.present(vc, animated: true)
    }

    /// 本地推送
    //: class func pushLocalNotification(_ model: JSMessageModel) {
    class func publicTransport(_ model: StateMessageModel) {
        //: guard UIApplication.shared.applicationState != .active else { return }
        guard UIApplication.shared.applicationState != .active else { return }
        //: UNUserNotificationCenter.current().getNotificationSettings { setting in
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            //: switch setting.authorizationStatus {
            switch setting.authorizationStatus {
            //: case .notDetermined, .denied, .ephemeral:
            case .notDetermined, .denied, .ephemeral:
                //: print("本地推送通知 -- 用户未授权\(setting.authorizationStatus)")
                //: print()
                print()

            //: case .provisional, .authorized:
            case .provisional, .authorized:
                //: if let dataModel = model.data {
                if let dataModel = model.data {
                    //: let content = UNMutableNotificationContent()
                    let content = UNMutableNotificationContent()
                    //: content.title = dataModel.nickname ?? ""
                    content.title = dataModel.nickname ?? ""
                    //: content.body = model.showText ?? ""
                    content.body = model.showText ?? ""
                    //: let identifier = dataModel.uid ?? "\(AppName)__LocalPush"
                    let identifier = dataModel.uid ?? "\(notiAutomaticUrl)" + (String(notiFilterTitle) + String(dataAlwaysPath))
                    //: content.userInfo = ["identifier": identifier]
                    content.userInfo = [String(bytes: noti_sceneMsg.map{$0^199}, encoding: .utf8)!: identifier]
                    //: content.sound = UNNotificationSound.default
                    content.sound = UNNotificationSound.default

                    //: let time = Date(timeIntervalSinceNow: 1).timeIntervalSinceNow
                    let time = Date(timeIntervalSinceNow: 1).timeIntervalSinceNow
                    //: let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                    //: let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    //: UNUserNotificationCenter.current().add(request) { _ in
                    UNUserNotificationCenter.current().add(request) { _ in
                    }
                }

            //: @unknown default:
            @unknown default:
                //: print("本地推送通知 -- 用户未授权\(setting.authorizationStatus)")
                //: break
                break
            }
        }
    }

    /// 获取firebase token
    //: class func getFireBaseToken(tokenBlock: @escaping (_ str: String) -> Void) {
    class func atomicQuantity85Device(tokenBlock: @escaping (_ str: String) -> Void) {
        //: Messaging.messaging().token { token, _ in
        Messaging.messaging().token { token, _ in
            //: if let token = token {
            if let token = token {
                //: tokenBlock(token)
                tokenBlock(token)
                //: } else {
            } else {
                //: tokenBlock("")
                tokenBlock("")
            }
        }
    }

    /// 获取ISO国家代码
    //: class func getCountryISOCode() -> [String] {
    class func frame() -> [String] {
        //: var tempArr: [String] = []
        var tempArr: [String] = []
        //: let info = CTTelephonyNetworkInfo()
        let info = CTTelephonyNetworkInfo()
        //: if let carrierDic = info.serviceSubscriberCellularProviders {
        if let carrierDic = info.serviceSubscriberCellularProviders {
            //: if !carrierDic.isEmpty {
            if !carrierDic.isEmpty {
                //: for carrier in carrierDic.values {
                for carrier in carrierDic.values {
                    //: if let iso = carrier.isoCountryCode, !iso.isEmpty {
                    if let iso = carrier.isoCountryCode, !iso.isEmpty {
                        //: tempArr.append(iso)
                        tempArr.append(iso)
                    }
                }
            }
        }
        //: return tempArr
        return tempArr
    }

    /// 获取用户代理状态
    //: class func getUsedProxyStatus() -> Bool {
    class func push() -> Bool {
        //: if AppWebViewController.isUsedProxy() || AppWebViewController.isUsedVPN() {
        if ServiceSpecifyMissingNavigationDelegate.proxyCan() || ServiceSpecifyMissingNavigationDelegate.cameraVpn() {
            //: return true
            return true
        }
        //: return false
        return false
    }

    /// 判断用户设备是否开启代理
    /// - Returns: false: 未开启  true: 开启
    //: class func isUsedProxy() -> Bool {
    class func proxyCan() -> Bool {
        //: guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        //: guard let dict = proxy as? [String: Any] else { return false }
        guard let dict = proxy as? [String: Any] else { return false }

        //: if let httpProxy = dict["HTTPProxy"] as? String, !httpProxy.isEmpty { return true }
        if let httpProxy = dict[(String(dataPromptName) + k_bridgeExecuteData.replacingOccurrences(of: "country", with: "ox"))] as? String, !httpProxy.isEmpty { return true }
        //: if let httpsProxy = dict["HTTPSProxy"] as? String, !httpsProxy.isEmpty { return true }
        if let httpsProxy = dict[(dataCurrentScriptKey.replacingOccurrences(of: "to", with: "TT") + String(k_linkActivePath.suffix(5)))] as? String, !httpsProxy.isEmpty { return true }
        //: if let socksProxy = dict["SOCKSProxy"] as? String, !socksProxy.isEmpty { return true }
        if let socksProxy = dict[(kTheoreticalTitle.replacingOccurrences(of: "field", with: "S") + "SProxy")] as? String, !socksProxy.isEmpty { return true }

        //: return false
        return false
    }

    /// 判断用户设备是否开启代理VPN
    /// - Returns: false: 未开启  true: 开启
    //: class func isUsedVPN() -> Bool {
    class func cameraVpn() -> Bool {
        //: guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        //: guard let dict = proxy as? [String: Any] else { return false }
        guard let dict = proxy as? [String: Any] else { return false }
        //: guard let scopedDic = dict["__SCOPED__"] as? [String: Any] else { return false }
        guard let scopedDic = dict[(String(constSaveValue.prefix(5)) + "PED__")] as? [String: Any] else { return false }
        //: for keyStr in scopedDic.keys {
        for keyStr in scopedDic.keys {
            //: if keyStr.contains("tap") || keyStr.contains("tun") || keyStr.contains("ipsec") || keyStr.contains("ppp"){
            if keyStr.contains((showAtTitleText.replacingOccurrences(of: "tun", with: "p"))) || keyStr.contains((user_betweenUrl.replacingOccurrences(of: "normal", with: "tu"))) || keyStr.contains((k_deadlinePath.lowercased())) || keyStr.contains((appPlatformWithUrl.replacingOccurrences(of: "all", with: "pp"))) {
                //: return true
                return true
            }
        }
        //: return false
        return false
    }

    /// 请求应用内评分 - iOS 13+ 优化版本
    //: class func requestInAppRating() {
    class func home() {
        //: if #available(iOS 14.0, *) {
        if #available(iOS 14.0, *) {
            // iOS 14+ 使用新的 WindowScene API（推荐）
            //: if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                //: SKStoreReviewController.requestReview(in: windowScene)
                SKStoreReviewController.requestReview(in: windowScene)
            }
            //: } else {
        } else {
            // iOS 13.x 使用传统 API
            //: SKStoreReviewController.requestReview()
            SKStoreReviewController.requestReview()
        }
    }

    // MARK: - Event

    /// 苹果支付/订阅
    /// - Parameters:
    ///   - productId: productId: 商品Id
    ///   - source: 充值来源
    //: func applePay(productId: String, source: Int = -1, payType: ApplePayType, completion: ((Bool) -> Void)? = nil) {
    func head(productId: String, source: Int = -1, payType: InciteType, completion: ((Bool) -> Void)? = nil) {
        //: ProgressHUD.show()
        RunningView.model()
        //: var index = 0
        var index = 0
        //: if source != -1 {
        if source != -1 {
            //: index = source
            index = source
        }
        //: AppleIAPManager.shared.iap_startPurchase(productId: productId, payType: payType, source: index) { status, _, _ in
        ResignManager.shared.dataConverterHandle(productId: productId, payType: payType, source: index) { status, _, _ in
            //: ProgressHUD.dismiss()
            RunningView.of()
            //: DispatchQueue.main.async {
            DispatchQueue.main.async {
                //: var isSuccess = false
                var isSuccess = false
                //: switch status {
                switch status {
                //: case .verityFail:
                case .verityFail:
                    //: ProgressHUD.toast( "Retry After or Go to \"Feedback\" to contact us")
                    RunningView.after((String(notiSystemStr.prefix(7)) + constPreviousStr.replacingOccurrences(of: "time", with: "ft") + " or " + String(data_headName)) + "\"" + (String(k_bounceKey.suffix(8))) + "\"" + (String(noti_padContent) + String(notiSpaceValue)))

                //: case .veritySucceed, .renewSucceed:
                case .veritySucceed, .renewSucceed:
                    //: isSuccess = true
                    isSuccess = true
                    //: self.third_jsEvent_refreshCoin()
                    self.thirdBy()

                //: default:
                default:
                    //: print(" apple支付充值失败：\(status.rawValue)")
                    //: break
                    break
                }
                //: completion?(isSuccess)
                completion?(isSuccess)
            }
        }
    }
}
