//
//  AppEnvironment.swift
//  Ass3_ExpensePlanner
//
//  Created by Jaipreet  on 08/05/24.
//

import Foundation
import Combine
import UserNotifications
import UIKit

final class AppEnvironment: ObservableObject{
    
    let rootVM: RootViewModel
//    let pushNotificationsHandler: PushNotificationsHandlerProtocol
    let deepLinksHandler: DeepLinksHandlerProtocol
    //let networkMonitorManager = NetworkMonitorManager()
    private var cancelBag = CancelBag()
    
    init(rootVM: RootViewModel = .init(context: PersistenceController.shared.viewContext)){
        self.rootVM = rootVM
        self.deepLinksHandler = DeepLinksHandler(rootVM: rootVM)
//        self.pushNotificationsHandler = PushNotificationsHandler(deepLinksHandler: deepLinksHandler)
    }
    
        
}
