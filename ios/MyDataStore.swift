import SwiftUI
class MyDataStore: ObservableObject {
  @Published var title: NSString = ""
  @Published var onPressed: RCTBubblingEventBlock = {_ in }
}
