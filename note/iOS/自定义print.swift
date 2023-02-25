func print<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    Swift.print("======= \(fileName):\(line) \(function) | \(message)")
    #endif
}