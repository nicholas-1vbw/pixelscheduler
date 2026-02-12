//
//  CalendarManager.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import Foundation
import EventKit
import Combine

// Protocol for mocking EKEventStore
protocol EventStoreProtocol {
    func requestAccess() async throws -> Bool
}

// Extension to make EKEventStore conform to the protocol
extension EKEventStore: EventStoreProtocol {
    func requestAccess() async throws -> Bool {
        if #available(macOS 14.0, *) {
            return try await requestFullAccessToEvents()
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                requestAccess(to: .event) { granted, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: granted)
                    }
                }
            }
        }
    }
}

class CalendarManager: ObservableObject {
    private let store: EventStoreProtocol
    @Published var authorizationStatus: EKAuthorizationStatus = .notDetermined
    
    init(store: EventStoreProtocol = EKEventStore()) {
        self.store = store
        self.authorizationStatus = EKEventStore.authorizationStatus(for: .event)
    }
    
    @MainActor
    func requestAccess() async throws -> Bool {
        let granted = try await store.requestAccess()
        // Refresh status
        self.authorizationStatus = EKEventStore.authorizationStatus(for: .event)
        return granted
    }
}
