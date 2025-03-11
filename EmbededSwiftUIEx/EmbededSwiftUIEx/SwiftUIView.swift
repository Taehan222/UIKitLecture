//
//  SwiftUIView.swift
//  EmbededSwiftUIEx
//
//  Created by 윤태한 on 3/11/25.
//

import SwiftUI
import MapKit

struct SwiftUIView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.566535, longitude: 126.999), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    init() {
        self.region = region
    }
    
    var body: some View {
        Map(coordinateRegion: $region).padding()
    }
}

#Preview {
    SwiftUIView()
}
