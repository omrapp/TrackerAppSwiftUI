# TrackerAppSwiftUI
Lightweight Swift SDK to measure execution time of operations in iOS apps

---

## Usage

### Enable Tracking

```swift
#if DEBUG
    TimerTrackerSDK.shared.isEnabled = true
#else
    TimerTrackerSDK.shared.isEnabled = false
#endif

TimerTrackerSDK.shared.logger = { (tag, msg) in print("\(tag), \(msg)") }
```

### start/stop

```swift
TimerTrackerSDK.shared.start(tag: "fetch_users")
// ... some logic
TimerTrackerSDK.shared.stop(tag: "fetch_users")

let duration = TimerTrackerSDK.shared.duration("fetch_users")
print("Time", "fetch_users took $duration ms")
```

### Automatic block timing

```swift
TimerTrackerSDK.shared.measure(tag: "fetch_posts") {
    fetchPosts()
}
```

### Reset all tracking

```swift
TimerTrackerSDK.shared.resetAll()
```
