import Foundation
class NotificationToken:NSObject{
    let notificationCenter:NotificationCenter
    let token:Any
    init(notificationCenter:NotificationCenter = .default,token:Any){
        self.notificationCenter = notificationCenter
        self.token = token
    }
    deinit {
        notificationCenter.removeObserver(token)
        print("刪除了Token")
    }
}

extension NotificationCenter{
    static func observer(forName:String,object:Any?,queue:OperationQueue?,using block:@escaping (Notification) -> Void)->NotificationToken{
        let token = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: forName), object: object, queue: queue, using: block)
        return NotificationToken(token: token)
    }
}




//class Child: NSObject {
//    let name: String
//    // KVO-enabled properties must be @objc dynamic
//    @objc dynamic var age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//        super.init()
//    }
//
//    func celebrateBirthday() {
//        age += 1
//    }
//}
//
//// Set up KVO
//let mia = Child(name: "Mia", age: 5)
////let observation = mia.observe(\.age, options: [.initial, .old]) { (child, change) in
////    if let oldValue = change.oldValue {
////        print("\(child.name)’s age changed from \(oldValue) to \(child.age)")
////    } else {
////        print("\(child.name)’s age is now \(child.age)")
////    }
////}
//
//let observation =  mia.observe(\.age, options: [ .new, .prior]) { (child, change) in
//    // 由此可觀察到各個 option 所做的事
//    print("now \(child.age)")
//    print("old \(change.oldValue)")
//    print("new \(change.newValue)")
//    print("is p \(change.isPrior)")
//}
//
//// Trigger KVO (see output in the console)
//print("---------------------------")
//mia.celebrateBirthday()
//print("---------------------------")
//mia.celebrateBirthday()
//// Deiniting or invalidating the observation token ends the observation
//observation.invalidate()
//
//// This doesn't trigger the KVO handler anymore
//mia.celebrateBirthday()
class PostObject:NSObject{
    func postNoti(name:String){
        let notiName = NSNotification.Name(name)
        let center = NotificationCenter.default
        center.post(name: notiName, object: nil, userInfo: ["name":name])
    }
}
class ObserverObject{
    var notificationPool:[String:NotificationToken] = [:]
    func addObserver(name:String) {
        let name = name
        notificationPool[name] = NotificationCenter.observer(forName: name, object: nil, queue: nil, using: { (notification) in
            print(notification.name)
            print(notification.userInfo)
        })
    }
}
var observerObj:ObserverObject? = ObserverObject()
let postObj = PostObject()
observerObj?.addObserver(name: "postObject")
observerObj?.addObserver(name: "postObject2")
postObj.postNoti(name: "postObject")
postObj.postNoti(name: "postObject2")
postObj.postNoti(name: "postObject")
postObj.postNoti(name: "postObject2")
observerObj = nil

