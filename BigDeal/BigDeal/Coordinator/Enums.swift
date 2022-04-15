import Foundation

enum AppFlow {
    case profile(ProfileScreen)
    case authentication(AuthenticationScreen)
    case feed(FeedScreen)
    case search(SearchScreen)
    case detail(DetailScreen)
}

enum ProfileScreen {
    case main
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
}

enum SearchScreen {
    case main
    case filter
    case results
}

enum DetailScreen {
    case main
}
