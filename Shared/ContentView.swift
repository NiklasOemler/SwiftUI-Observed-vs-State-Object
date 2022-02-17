//
//  ContentView.swift
//  Shared
//
//  Created by Niklas Oemler on 17.02.22.
//

import SwiftUI

class StateObjectClass: ObservableObject {
    enum ObserverType: String {
        case stateObject
        case observedObject
    }
    
    @Published
    var count = 0
    
    let type: ObserverType
    let id = UUID()
    
    init(type: ObserverType) {
        self.type = type
    }
    
    deinit {
        print(#function, "type: \(type.rawValue) id: \(id)")
    }
}

struct StateObjectCounter: View {
    @StateObject
    var state = StateObjectClass(type: .stateObject)
    
    var body: some View {
        VStack {
            Text("@StateObject's count: \(state.count)")
            Button("Add 1"){
                state.count += 1
            }
        }
    }
}

struct ObservedObjectCounter: View {
    @ObservedObject
    var state = StateObjectClass(type: .observedObject)
    
    var body: some View {
        VStack {
            Text("@ObservedObject's count: \(state.count)")
            Button("Add 1") {
                state.count += 1
            }
        }
    }
}

struct ContentView: View {
    @State
    private var count = 0
    
    var body: some View {
        VStack {
            Text("Refresh CounterView's count: \(count)")
            Button("Refresh") {
                count += 1
            }
            StateObjectCounter()
                .padding()
            ObservedObjectCounter()
                .padding()
        }
    }
}
