import SwiftUI
import SwiftData
import FirebaseCore

//connect to the firebase from(https://console.firebase.google.com/project/cinema-booking-2dd16/overview?hl=zh-cn)
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct cinema_bookingApp: App {
    
    //connect to the firebase from(https://console.firebase.google.com/project/cinema-booking-2dd16/overview?hl=zh-cn)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var userVM = UserViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if userVM.isLogin {
                ContentView().environmentObject(userVM)
            } else {
                LoginView().environmentObject(userVM)
            }
        }
    }
    
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
