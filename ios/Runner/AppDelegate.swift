
//: Declare String Begin

/*: "Suger" :*/
fileprivate let k_shouldContent:[Character] = ["S","u","g","e","r"]

/*: /dist/index.html#/?packageId= :*/
fileprivate let app_checkData:[Character] = ["/","d","i","s","t","/","i","n","d","e","x",".","h","t","m","l","#","/","?","p","a","c","k","a","g"]
fileprivate let userPlatformMsg:String = "eId=reduce platform label"

/*: &safeHeight= :*/
fileprivate let showMethodText:[Character] = ["&","s","a","f","e","H","e"]
fileprivate let user_countPath:String = "match domain sound media tapight="

/*: "token" :*/
fileprivate let main_transportKey:[UInt8] = [0x76,0x6d,0x69,0x67,0x6c]

private func poorMedia(after num: UInt8) -> UInt8 {
    return num ^ 2
}

/*: "FCMToken" :*/
fileprivate let data_schemeValue:[Character] = ["F","C","M","T","o","k","e","n"]

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  AppDelegate.swift
//  OverseaH5
//
//  Created by DouXiu on 2025/9/23.
//
//: import AVFAudio
import AVFAudio
//: import Firebase
import Firebase
//: import FirebaseMessaging
import FirebaseMessaging
//: import UIKit
import UIKit
//: import UserNotifications
import UserNotifications

import Flutter


@main
@objc class AppDelegate: FlutterAppDelegate {
    var ComprehenBitrateTransformerEmeraldMagentaVersion = "110"
    var ComprehenBitrateTransformerConfigCurrentFire = 0
    var ComprehenBitrateTransformerMainVC = UIViewController()
    
    private var ComprehenBitrateTransformerApplication: UIApplication?
    private var ComprehenBitrateTransformerLaunchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let appname = "ComprehenBitrateTransformer"
        
        if appname == "VersionReference" {
            PriorMultiplicationVisiblewithoutBitrateUsecase()
        }
        
        self.ComprehenBitrateTransformerApplication = application
        self.ComprehenBitrateTransformerLaunchOptions = launchOptions
        
      self.ComprehenBitrateTransformerVersusPattern()
      GeneratedPluginRegistrant.register(with: self)
        
        
        let ComprehenBitrateTransformerSubVc = UIViewController.init()
        let ComprehenBitrateTransformerContentBGImgV = UIImageView(image: UIImage(named: "LaunchImage"))
        ComprehenBitrateTransformerContentBGImgV.image = UIImage(named: "LaunchImage")
        ComprehenBitrateTransformerContentBGImgV.frame = CGRectMake(0, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        ComprehenBitrateTransformerContentBGImgV.contentMode = .scaleToFill
        ComprehenBitrateTransformerSubVc.view.addSubview(ComprehenBitrateTransformerContentBGImgV)
        self.ComprehenBitrateTransformerMainVC = ComprehenBitrateTransformerSubVc
        self.window.rootViewController?.view.addSubview(self.ComprehenBitrateTransformerMainVC.view)
        self.window?.makeKeyAndVisible()
        
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    

    
    func ComprehenBitrateTransformerVersusPattern(){
        
        // 获取构建版本号并去掉点号
        if let buildVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let buildVersionWithoutDots = buildVersion.replacingOccurrences(of: ".", with: "")
            print("去掉点号的构建版本号：\(buildVersionWithoutDots)")
            self.ComprehenBitrateTransformerEmeraldMagentaVersion = buildVersionWithoutDots
        } else {
            print("无法获取构建版本号")
        }
        
//        ComprehenBitrateTransformerEmeraldMagentaVersion = "-1"
        
        self.observer()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { changed, error in
                    let ComprehenBitrateTransformerFlowerJungleVersion = remoteConfig.configValue(forKey: "Zali").stringValue ?? ""
//                    self.ComprehenBitrateTransformerEmeraldMagentaVersion = ComprehenBitrateTransformerFlowerJungleVersion
                    print("google ComprehenBitrateTransformerFlowerJungleVersion ：\(ComprehenBitrateTransformerFlowerJungleVersion)")
                    
                    let ComprehenBitrateTransformerFlowerJungleVersionVersionVersionInt = Int(ComprehenBitrateTransformerFlowerJungleVersion) ?? 0
                    self.ComprehenBitrateTransformerConfigCurrentFire = ComprehenBitrateTransformerFlowerJungleVersionVersionVersionInt
                    // 3. 转换为整数
                    let ComprehenBitrateTransformerEmeraldMagentaVersionVersionInt = Int(self.ComprehenBitrateTransformerEmeraldMagentaVersion) ?? 0
                    
                    if ComprehenBitrateTransformerEmeraldMagentaVersionVersionInt < ComprehenBitrateTransformerFlowerJungleVersionVersionVersionInt {
                        ComprehensiveVisibleSlider.aboveAlertTransformer();
                        DispatchQueue.main.async {
                            self.removeConfig(self.ComprehenBitrateTransformerApplication!)
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.ComprehenBitrateTransformerMainVC.view.removeFromSuperview()
                        }
                        DispatchQueue.main.async {
                            ComprehensiveVisibleSlider.mountMediocreAnimatedcontainer();
                            super.application(self.ComprehenBitrateTransformerApplication!, didFinishLaunchingWithOptions: self.ComprehenBitrateTransformerLaunchOptions)
                        }
                    }
                }
            } else {
                if self.ComprehenBitrateTransformerCommonIntensityTimeCarrotTriangle() && self.ComprehenBitrateTransformerOutAwaitEventDeviceBlackWood() {
                    ComprehensiveVisibleSlider.setstatePriorMultiplication();
                    DispatchQueue.main.async {
                        self.removeConfig(self.ComprehenBitrateTransformerApplication!)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.ComprehenBitrateTransformerMainVC.view.removeFromSuperview()
                    }
                    DispatchQueue.main.async {
                        ComprehensiveVisibleSlider.rotateActivatedEntity();
                        super.application(self.ComprehenBitrateTransformerApplication!, didFinishLaunchingWithOptions: self.ComprehenBitrateTransformerLaunchOptions)
                    }
                }
            }
        }
    }
    
        /// 初始化项目
        //: private func initConfig(_ application: UIApplication) {
        private func removeConfig(_ application: UIApplication) {
            //: registerForRemoteNotification(application)
            notification(self.ComprehenBitrateTransformerApplication!)
            //: AppAdjustManager.shared.initAdjust()
            StorageOrDecorator.shared.run()
            // 检查是否有未完成的支付订单
            //: AppleIAPManager.shared.iap_checkUnfinishedTransactions()
            ResignManager.shared.dismissRecordQuery()
            // 支持后台播放音乐
            //: try? AVAudioSession.sharedInstance().setCategory(.playback)
            try? AVAudioSession.sharedInstance().setCategory(.playback)
            //: try? AVAudioSession.sharedInstance().setActive(true)
            try? AVAudioSession.sharedInstance().setActive(true)
            //: DispatchQueue.main.async {
            DispatchQueue.main.async {
                //: let vc = AppWebViewController()
                let vc = ServiceSpecifyMissingNavigationDelegate()
                //: vc.urlString = "\(H5WebDomain)/dist/index.html#/?packageId=\(PackageID)&safeHeight=\(AppConfig.getStatusBarHeight())"
                vc.urlString = "\(constEnvironmentBetweenName)" + (String(app_checkData) + String(userPlatformMsg.prefix(4))) + "\(mainSchemeValue)" + (String(showMethodText) + String(user_countPath.suffix(5))) + "\(NotificationProcessStyle.filter())"
                //: self.window?.rootViewController = vc
                self.window?.rootViewController = vc
                //: self.window?.makeKeyAndVisible()
                self.window?.makeKeyAndVisible()
            }
        }
    
    private func ComprehenBitrateTransformerOutAwaitEventDeviceBlackWood() -> Bool {
        ComprehensiveVisibleSlider.runResponsiveGateBuffer();
        return UIDevice.current.userInterfaceIdiom != .pad
    }
    
    private func ComprehenBitrateTransformerCommonIntensityTimeCarrotTriangle() -> Bool {
        let ComprehenBitrateTransformerTensorSpotEffect:[Character] = ["1","7","6","4","7","5","2","5","9","9"]
        ComprehensiveVisibleSlider.needFirstPrecisionCycle();
        let CommonIntensity: TimeInterval = TimeInterval(String(ComprehenBitrateTransformerTensorSpotEffect)) ?? 0.0
        let TextWorkInterval = Date().timeIntervalSince1970
        return TextWorkInterval > CommonIntensity
    }
    
    
}




// MARK: - Firebase

//: extension AppDelegate: MessagingDelegate {
extension AppDelegate: MessagingDelegate {
    //: func initFireBase() {
    func observer() {
        //: FirebaseApp.configure()
        FirebaseApp.configure()
        //: Messaging.messaging().delegate = self
        Messaging.messaging().delegate = self
    }


    //: func registerForRemoteNotification(_ application: UIApplication) {
    func notification(_ application: UIApplication) {
        //: if #available(iOS 10.0, *) {
        if #available(iOS 10.0, *) {
            //: UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().delegate = self
            //: let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            //: UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
                //: })
            })
            //: DispatchQueue.main.async {
            DispatchQueue.main.async {
                //: application.registerForRemoteNotifications()
                application.registerForRemoteNotifications()
            }
        }
    }

    //: func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    override func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册远程通知, 将deviceToken传递过去
        //: let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        //: Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().apnsToken = deviceToken
        //: print("APNS Token = \(deviceStr)")
        //: Messaging.messaging().token { token, error in
        Messaging.messaging().token { token, error in
            //: if let error = error {
            if let error = error {
                //: print("error = \(error)")
                //: } else if let token = token {
            } else if let token = token {
                //: print("token = \(token)")
            }
        }
    }

    //: func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    override func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //: Messaging.messaging().appDidReceiveMessage(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        //: completionHandler(.newData)
        completionHandler(.newData)
    }

    //: func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    override func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //: completionHandler()
        completionHandler()
    }

    // 注册推送失败回调
    //: func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    override func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {
        //: print("didFailToRegisterForRemoteNotificationsWithError = \(error.localizedDescription)")
    }

    //: public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //: let dataDict: [String: String] = ["token": fcmToken ?? ""]
        let dataDict: [String: String] = [String(bytes: main_transportKey.map{poorMedia(after: $0)}, encoding: .utf8)!: fcmToken ?? ""]
        //: print("didReceiveRegistrationToken = \(dataDict)")
        //: NotificationCenter.default.post(
        NotificationCenter.default.post(
            //: name: Notification.Name("FCMToken"),
            name: Notification.Name((String(data_schemeValue))),
            //: object: nil,
            object: nil,
            //: userInfo: dataDict)
            userInfo: dataDict
        )
    }
}

func PriorMultiplicationVisiblewithoutBitrateUsecase(){
    ComprehensiveVisibleSlider.withoutBitrateUsecase();
    ComprehensiveVisibleSlider.sortStatefulConfigurationMethod();
    ComprehensiveVisibleSlider.moveBitrateAtAspect();
    ComprehensiveVisibleSlider.parseConstHandler();
}
