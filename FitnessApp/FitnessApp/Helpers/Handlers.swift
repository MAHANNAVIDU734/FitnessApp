import Foundation

public typealias ActionHandler = (_ status: Bool, _ message: String?) -> ()
public typealias AlertActionHandler = (_ action: String) -> ()
public typealias CompletionHandlerWithData = (_ status: Bool, _ message: String?, _ data: Any?) -> ()
