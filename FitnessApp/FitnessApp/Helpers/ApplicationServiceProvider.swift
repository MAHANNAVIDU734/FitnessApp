import UIKit

class ApplicationServiceProvider {
    
    static let shared: ApplicationServiceProvider = {
        let _shared = ApplicationServiceProvider()
        _shared.manageUIAppearance(hasCustomBackButton: true, hideNavBarShadow: true, hideTabBarShadow: true)
        return _shared
    }()
    
    func manageUserDirection(isUserAuthenticated:Bool) {
//        if UserDefaultManager.getBool(forKey: .isNotInitialLaunch) == false {
//            KeychainManager.delete(forKey: .accessToken)
//        }
//        UserDefaultManager.set(true, forKey: .isNotInitialLaunch)
        
//        var vc = viewController(in: .Auth, identifier: "AuthNVC")
        var vc = viewController(in: .Main, identifier: "MainTabBarController")
        if isUserAuthenticated {
            vc = viewController(in: .Main, identifier: "MainTabBarController")
        }
        AppDelegate.standard.window?.rootViewController = vc
    }
    
    func viewController(in sb: Storyboard, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: identifier)
        return targetVC
    }
    
    private func manageUIAppearance(hasCustomBackButton: Bool = false, hideNavBarShadow: Bool = false, hideTabBarShadow: Bool = false) {
        // Set navigation bar tint / background color
        UINavigationBar.appearance().isTranslucent = false
        
        // Set navigation bar item tint color
        UIBarButtonItem.appearance().tintColor = .darkGray
        
        // Set navigation bar back button tint color
        UINavigationBar.appearance().tintColor = .darkGray
        
        // Set cutom back image if needed
        if hasCustomBackButton == true {
            // Set back button image
            let backImage = UIImage(named: "back")
            UINavigationBar.appearance().backIndicatorImage = backImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        }
        
        // Hide navigation bar shadow if needed
        if hideNavBarShadow == true {
            // To remove the 1px seperator at the bottom of navigation bar
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        }
        
        // Hide tab bar shadow if needed
        if hideTabBarShadow == true {
            // To remove the 1px seperator at the bottom of tab bar
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().shadowImage = UIImage()
        }
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}
