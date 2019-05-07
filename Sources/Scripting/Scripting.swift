import Foundation

public func system(command: String, args: [String]) throws {
    let path: String
    
    if (command as NSString).isAbsolutePath {
        path = command
    } else {
        guard let path_ = which(command: command) else {
            throw GenericError("command not found: \(command)")
        }
        path = path_
    }
    
    let proc = Process()
    proc.launchPath = path
    proc.arguments = args
    proc.launch()
    proc.waitUntilExit()
}

public func which(command: String) -> String? {
    let proc = Process()
    proc.launchPath = "/usr/bin/which"
    proc.arguments = [command]
    
    let outPipe = Pipe()
    var outData = Data()
    outPipe.fileHandleForReading.readabilityHandler = { (h) in
        outData.append(h.availableData)
    }
    proc.standardOutput = outPipe
    
    let errPipe = Pipe()
    var errData = Data()
    errPipe.fileHandleForReading.readabilityHandler = { (h) in
        errData.append(h.availableData)
    }
    
    proc.launch()
    proc.waitUntilExit()
    
    guard errData.isEmpty else {
        return nil
    }
    
    guard var outStr = String(data: outData, encoding: .utf8) else {
        return nil
    }
    
    outStr = outStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    if outStr.isEmpty {
        return nil
    }
    
    return outStr
}
