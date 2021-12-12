enum API: String {
    
    static let baseURL = "https://itunes.apple.com"
    
    case search =  "/search"
    
    case lookup =  "/lookup"
    
    func path() -> String {
        self.rawValue
    }
}
