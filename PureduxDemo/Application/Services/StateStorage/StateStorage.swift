//
//  StatePersistanceService.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonOperators
import PureduxSideEffects

struct StateStorage<State: Codable>: StateStorageProtocol {

    init(savePath: @escaping () throws ->  URL) {
        self.savePath = savePath
    }

    let savePath: () throws ->  URL
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    func write(state: State) throws -> StateSize {
        guard let data = try? encoder.encode(state) else {
            throw Errors.couldNotEncodeState
        }

        let path = try savePath()
        try data.write(to: path)

        return StateSize(kb: fileSizeAt(path))
    }

    func read() throws -> State? {
        let path = try savePath()
        let data = try Data(contentsOf: path)

        let savedState = try decoder.decode(State.self, from: data)
        return savedState
    }
}

extension StateStorage {
    private func fileSizeAt(_ url: URL) -> Int {
        do {
            let resources = try url.resourceValues(forKeys: [.fileSizeKey])
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = .useKB
            formatter.countStyle = .file
            formatter.includesUnit = false
            let sizeString =  formatter.string(fromByteCount: Int64(resources.fileSize ?? 0))
            return Int(sizeString) ?? 0
        } catch {
            return 0
        }
    }
}

extension StateStorage {
    enum Errors: Error {
        case couldNotEncodeState
    }
}
