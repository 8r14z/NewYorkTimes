//
//  Promise.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class Promise<Value> {
    
    enum State<T> {
        case pending
        case resolved(T)
    }
    
    private var state: State<Value> = .pending
    private var callbacks: [(Value) -> Void] = []
    
    init(executor: (_ resolve: @escaping (Value) -> Void) -> Void) {
        executor(resolve)
    }
    
    // observe
    public func then(_ onResolved: @escaping (Value) -> Void) {
        callbacks.append(onResolved)
        triggerCallbacksIfResolved()
    }
    
    public func then<NewValue>(_ onResolved: @escaping (Value) -> Promise<NewValue>) -> Promise<NewValue> {
        return Promise<NewValue> { resolve in
            then { value in
                onResolved(value).then(resolve)
            }
        }
    }
    
    // map
    public func then<NewValue>(_ onResolved: @escaping (Value) -> NewValue) -> Promise<NewValue> {
        return then { value in
            return Promise<NewValue> { resolve in
                resolve(onResolved(value))
            }
        }
    }
    
    private func resolve(value: Value) {
        updateState(to: .resolved(value))
    }
    
    private func updateState(to newState: State<Value>) {
        guard case .pending = state else { return }
        state = newState
        triggerCallbacksIfResolved()
    }
    
    private func triggerCallbacksIfResolved() {
        guard case let .resolved(value) = state else { return }
        callbacks.forEach { callback in
            callback(value)
        }
        callbacks.removeAll()
    }
}
