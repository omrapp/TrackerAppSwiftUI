//
//  TrackerSDK.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 13/07/2025.
//


protocol TrackerSDKApi {
    
    func start(tag: String)
    func stop(tag: String, completion: ((Double) -> ())?)
    func duration(tag: String) -> Double?
    func measure<T>(tag: String, block: () -> T) -> T
    func resetAll()
    
    
    var isEnabled: Bool { get set }
    
}

public final class TimerTrackerSDK: TrackerSDKApi {
    

    public static let shared: TimerTrackerSDK = TimerTrackerSDK()
    
    private var startTimes = [String: Double]()
    private var durations = [String: Double]()
    
    private init() {
        
    }
    
    public var isEnabled: Bool = true
    
    public var logger: ((String, String) -> ()) = { tag, message in
        
        DispatchQueue.global(qos: .background).async {
            NSLog("Tag: %@, Message: %@", tag, message)
        }
    }
    
    public func start(tag: String) {
        if(isEnabled) {
            startTimes[tag] = Date.currentTimeStamp
            logger(tag, "Start timer for \(tag)")
        }
    }
    
    public func stop(tag: String, completion: ((Double) -> ())? = nil) {
        
        if (isEnabled) {
            
            let startTime = startTimes[tag]
            
            guard let startTime = startTime else {
                return
            }
            
            let duration: Double = Date.currentTimeStamp - startTime
            durations[tag] = duration
            logger(tag, "Stoped timer for \(tag) with duration: \(duration)")
            completion?(duration)
        }
    }
    
    public func duration(tag: String) -> Double? {
        
        if(isEnabled) {
            return durations[tag]
        }
        
        return nil
    }
    
    public func measure<T>(tag: String, block: () -> T) -> T {
        start(tag: tag)
        let result = block()
        stop(tag: tag)
        return result
    }
    
    public func resetAll() {
        startTimes.removeAll()
        durations.removeAll()
    }
    
    
}


extension Date {
    static var currentTimeStamp: Double {
        return Date().timeIntervalSince1970 * 1000
    }
}
