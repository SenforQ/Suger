
//: Declare String Begin

/*: "frostry" :*/
fileprivate let main_cameraUrl:String = "froscapturey"

/*: "986" :*/
fileprivate let k_shouldName:String = "show6"

/*: "yaudgzijbw1s" :*/
fileprivate let noti_remotePath:[Character] = ["y","a","u","d","g"]
fileprivate let data_savePath:String = "ZIJBW1S"

/*: "9ximnp" :*/
fileprivate let mainEmptyMessage:String = "9ximnmodel service error to user"
fileprivate let userFilterValue:String = "P"

/*: "1.9.1" :*/
fileprivate let app_thatName:[Character] = ["1",".","9",".","1"]

/*: "https://m. :*/
fileprivate let show_modelName:[Character] = ["h","t","t","p"]
fileprivate let const_presentName:String = "quantity allow load behavior carriers://m."

/*: .com" :*/
fileprivate let const_managerValue:String = "component disappear currency need local.com"

/*: "CFBundleShortVersionString" :*/
fileprivate let main_objectMessage:String = "for topCFBun"
fileprivate let notiCorePath:String = "request zonertVer"
fileprivate let showTrustOverUrl:String = "tagainng"

/*: "CFBundleDisplayName" :*/
fileprivate let show_countValue:String = "CFBunfloat s"
fileprivate let k_albumStr:String = "layNamewhere date prompt go key"

/*: "CFBundleVersion" :*/
fileprivate let app_infoWaitActiveData:String = "allow empty fileCFBund"
fileprivate let kDeviceInputId:String = "iobegin"

/*: "weixin" :*/
fileprivate let notiServerKey:String = "weiratingin"

/*: "wxwork" :*/
fileprivate let data_usId:[Character] = ["w","x","w","o","r","k"]

/*: "dingtalk" :*/
fileprivate let mainDistantUrl:[Character] = ["d","i","n","g","t","a"]
fileprivate let kTabFormat:[Character] = ["l","k"]

/*: "lark" :*/
fileprivate let user_genId:[Character] = ["l","a","r","k"]

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  NotificationProcessStyle.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

//: import KeychainSwift
import KeychainSwift
//: import UIKit
import UIKit

/// 域名
//: let ReplaceUrlDomain = "frostry"
let k_statusLogShouldTitle = (main_cameraUrl.replacingOccurrences(of: "capture", with: "tr"))
/// 包ID
//: let PackageID = "986"
let mainSchemeValue = (k_shouldName.replacingOccurrences(of: "show", with: "98"))
/// Adjust
//: let AdjustKey = "yaudgzijbw1s"
let main_duePackageKey = (String(noti_remotePath) + data_savePath.lowercased())
//: let AdInstallToken = "9ximnp"
let app_matchFormat = (String(mainEmptyMessage.prefix(5)) + userFilterValue.lowercased())

/// 网络版本号
//: let AppNetVersion = "1.9.1"
let noti_numberMessage = (String(app_thatName))
//: let H5WebDomain = "https://m.\(ReplaceUrlDomain).com"
let constEnvironmentBetweenName = (String(show_modelName) + String(const_presentName.suffix(6))) + "\(k_statusLogShouldTitle)" + (String(const_managerValue.suffix(4)))
//: let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let noti_domainMsg = Bundle.main.infoDictionary![(String(main_objectMessage.suffix(5)) + "dleSho" + String(notiCorePath.suffix(5)) + "sionS" + showTrustOverUrl.replacingOccurrences(of: "again", with: "ri"))] as! String
//: let AppBundle = Bundle.main.bundleIdentifier!
let userSavePath = Bundle.main.bundleIdentifier!
//: let AppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? ""
let notiAutomaticUrl = Bundle.main.infoDictionary![(String(show_countValue.prefix(5)) + "dleDisp" + String(k_albumStr.prefix(7)))] ?? ""
//: let AppBuildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let notiMagnituderyKey = Bundle.main.infoDictionary![(String(app_infoWaitActiveData.suffix(6)) + "leVers" + kDeviceInputId.replacingOccurrences(of: "begin", with: "n"))] as! String

//: class AppConfig: NSObject {
class NotificationProcessStyle: NSObject {
    /// 获取状态栏高度
    //: class func getStatusBarHeight() -> CGFloat {
    class func filter() -> CGFloat {
        //: if #available(iOS 13.0, *) {
        if #available(iOS 13.0, *) {
            //: if let statusBarManager = UIApplication.shared.windows.first?
            if let statusBarManager = UIApplication.shared.windows.first?
                //: .windowScene?.statusBarManager
                .windowScene?.statusBarManager
            {
                //: return statusBarManager.statusBarFrame.size.height
                return statusBarManager.statusBarFrame.size.height
            }
            //: } else {
        } else {
            //: return UIApplication.shared.statusBarFrame.size.height
            return UIApplication.shared.statusBarFrame.size.height
        }
        //: return 20.0
        return 20.0
    }

    /// 获取window
    //: class func getWindow() -> UIWindow {
    class func get() -> UIWindow {
        //: var window = UIApplication.shared.windows.first(where: {
        var window = UIApplication.shared.windows.first(where: {
            //: $0.isKeyWindow
            $0.isKeyWindow
            //: })
        })
        // 是否为当前显示的window
        //: if window?.windowLevel != UIWindow.Level.normal {
        if window?.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: return window!
        return window!
    }

    /// 获取当前控制器
    //: class func currentViewController() -> (UIViewController?) {
    class func picList() -> (UIViewController?) {
        //: var window = AppConfig.getWindow()
        var window = NotificationProcessStyle.get()
        //: if window.windowLevel != UIWindow.Level.normal {
        if window.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: let vc = window.rootViewController
        let vc = window.rootViewController
        //: return currentViewController(vc)
        return execute(vc)
    }

    //: class func currentViewController(_ vc: UIViewController?)
    class func execute(_ vc: UIViewController?)
        //: -> UIViewController?
        -> UIViewController?
    {
        //: if vc == nil {
        if vc == nil {
            //: return nil
            return nil
        }
        //: if let presentVC = vc?.presentedViewController {
        if let presentVC = vc?.presentedViewController {
            //: return currentViewController(presentVC)
            return execute(presentVC)
            //: } else if let tabVC = vc as? UITabBarController {
        } else if let tabVC = vc as? UITabBarController {
            //: if let selectVC = tabVC.selectedViewController {
            if let selectVC = tabVC.selectedViewController {
                //: return currentViewController(selectVC)
                return execute(selectVC)
            }
            //: return nil
            return nil
            //: } else if let naiVC = vc as? UINavigationController {
        } else if let naiVC = vc as? UINavigationController {
            //: return currentViewController(naiVC.visibleViewController)
            return execute(naiVC.visibleViewController)
            //: } else {
        } else {
            //: return vc
            return vc
        }
    }
}

// MARK: - Device

//: extension UIDevice {
extension UIDevice {
    //: static var modelName: String {
    static var modelName: String {
        //: var systemInfo = utsname()
        var systemInfo = utsname()
        //: uname(&systemInfo)
        uname(&systemInfo)
        //: let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        //: let identifier = machineMirror.children.reduce("") {
        let identifier = machineMirror.children.reduce("") {
            //: identifier, element in
            identifier, element in
            //: guard let value = element.value as? Int8, value != 0 else {
            guard let value = element.value as? Int8, value != 0 else {
                //: return identifier
                return identifier
            }
            //: return identifier + String(UnicodeScalar(UInt8(value)))
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        //: return identifier
        return identifier
    }

    /// 获取当前系统时区
    //: static var timeZone: String {
    static var timeZone: String {
        //: let currentTimeZone = NSTimeZone.system
        let currentTimeZone = NSTimeZone.system
        //: return currentTimeZone.identifier
        return currentTimeZone.identifier
    }

    /// 获取当前系统语言
    //: static var langCode: String {
    static var langCode: String {
        //: let language = Locale.preferredLanguages.first
        let language = Locale.preferredLanguages.first
        //: return language ?? ""
        return language ?? ""
    }

    /// 获取接口语言
    //: static var interfaceLang: String {
    static var interfaceLang: String {
        //: let lang = UIDevice.getSystemLangCode()
        let lang = UIDevice.pending()
        //: if ["en", "ar", "es", "pt"].contains(lang) {
        if ["en", "ar", "es", "pt"].contains(lang) {
            //: return lang
            return lang
        }
        //: return "en"
        return "en"
    }

    /// 获取当前系统地区
    //: static var countryCode: String {
    static var countryCode: String {
        //: let locale = Locale.current
        let locale = Locale.current
        //: let countryCode = locale.regionCode
        let countryCode = locale.regionCode
        //: return countryCode ?? ""
        return countryCode ?? ""
    }

    /// 获取系统UUID（每次调用都会产生新值，所以需要keychain）
    //: static var systemUUID: String {
    static var systemUUID: String {
        //: let key = KeychainSwift()
        let key = KeychainSwift()
        //: if let value = key.get(AdjustKey) {
        if let value = key.get(main_duePackageKey) {
            //: return value
            return value
            //: } else {
        } else {
            //: let value = NSUUID().uuidString
            let value = NSUUID().uuidString
            //: key.set(value, forKey: AdjustKey)
            key.set(value, forKey: main_duePackageKey)
            //: return value
            return value
        }
    }

    /// 获取已安装应用信息
    //: static var getInstalledApps: String {
    static var getInstalledApps: String {
        //: var appsArr: [String] = []
        var appsArr: [String] = []
        //: if UIDevice.canOpenApp("weixin") {
        if UIDevice.user((notiServerKey.replacingOccurrences(of: "rating", with: "x"))) {
            //: appsArr.append("weixin")
            appsArr.append((notiServerKey.replacingOccurrences(of: "rating", with: "x")))
        }
        //: if UIDevice.canOpenApp("wxwork") {
        if UIDevice.user((String(data_usId))) {
            //: appsArr.append("wxwork")
            appsArr.append((String(data_usId)))
        }
        //: if UIDevice.canOpenApp("dingtalk") {
        if UIDevice.user((String(mainDistantUrl) + String(kTabFormat))) {
            //: appsArr.append("dingtalk")
            appsArr.append((String(mainDistantUrl) + String(kTabFormat)))
        }
        //: if UIDevice.canOpenApp("lark") {
        if UIDevice.user((String(user_genId))) {
            //: appsArr.append("lark")
            appsArr.append((String(user_genId)))
        }
        //: if appsArr.count > 0 {
        if appsArr.count > 0 {
            //: return appsArr.joined(separator: ",")
            return appsArr.joined(separator: ",")
        }
        //: return ""
        return ""
    }

    /// 判断是否安装app
    //: static func canOpenApp(_ scheme: String) -> Bool {
    static func user(_ scheme: String) -> Bool {
        //: let url = URL(string: "\(scheme)://")!
        let url = URL(string: "\(scheme)://")!
        //: if UIApplication.shared.canOpenURL(url) {
        if UIApplication.shared.canOpenURL(url) {
            //: return true
            return true
        }
        //: return false
        return false
    }

    /// 获取系统语言
    /// - Returns: 国际通用语言Code
    //: @objc public class func getSystemLangCode() -> String {
    @objc public class func pending() -> String {
        //: let language = NSLocale.preferredLanguages.first
        let language = NSLocale.preferredLanguages.first
        //: let array = language?.components(separatedBy: "-")
        let array = language?.components(separatedBy: "-")
        //: return array?.first ?? "en"
        return array?.first ?? "en"
    }
}
