import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            VStack {
                GoogleMapView()
            }
        }
        .ignoresSafeArea( .all)
    }
}

#Preview {
    ContentView()
}
