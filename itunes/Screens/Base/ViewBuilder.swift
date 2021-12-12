
protocol ViewBuilder {
    associatedtype BuildData
    associatedtype ViewController
    static func build(with buildData: BuildData?) -> ViewController
}
