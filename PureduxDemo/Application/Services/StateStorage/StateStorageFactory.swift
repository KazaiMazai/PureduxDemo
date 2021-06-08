//
//  StateStorageFactory.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

struct StateStorageFactory {
    func defaultStorage<State: Codable>() -> StateStorage<State> {
        StateStorage {
            let icloudDirectory = FileManager.default.url(forUbiquityContainerIdentifier: nil)
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: false)
            if let icloudDirectory = icloudDirectory {
                try FileManager.default.startDownloadingUbiquitousItem(at: icloudDirectory)
            }

            return (icloudDirectory ?? documentDirectory).appendingPathComponent("userData")
        }
    }
}
