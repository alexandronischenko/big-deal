import Foundation

enum AppFlow {
    case profile(ProfileScreen)
    case authentication(AuthenticationScreen)
    case feed(FeedScreen)
    case search(SearchScreen)
}

enum ProfileScreen {
    case main
    case detail
    case settings
    case subscriptions
}

enum AuthenticationScreen {
    case greeting
    case login
    case register
}

enum FeedScreen {
    case main
    case detail
}

enum SearchScreen {
    case main
    case detail
    case filter
}
