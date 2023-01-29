import Cocoa


//Externe DLS

let input: [String: Any] = [
    "values": [1,2,3,4,5],
    "operation": "+",
    "name": "input"
]

let inputB: [String: Any] = [
    "values": [1,2,3,4,5],
    "operation": "-",
    "name": "inputB"
]

let inputC: [String: Any] = [
    "values": [1,2,3,4,5],
    "operation": "*",
    "name": "inputC"
]


struct OperationResult {
    let name: String
    let result: Int
}

struct ErrorResult {
    let errorCode: Int
    let errorMsg: String
}

func read(instructions: [[String: Any]])-> (result: [OperationResult]?, error: ErrorResult?) {
    
    var finalResult: [OperationResult] = []
    var error: ErrorResult?
    
    instructions.forEach({
        instruction in
        guard let safeValues = instruction["values"] as? [Int] else {
            error = ErrorResult(errorCode: 0, errorMsg: "bad values")
            return
        }
        
        guard let safeoperation = instruction["operation"] as? String else {
            error = ErrorResult(errorCode: 1, errorMsg: "Unknown operation")
            return
        }
        
        guard let safeoperationName = instruction["name"] as? String else {
            error = ErrorResult(errorCode: 2, errorMsg: "Name is mission")
            return
        }
        
        
        var totalResult = 0
        safeValues.forEach({
            value in
            
            switch safeoperation {
            case "+":
                totalResult = totalResult + value
            case "-":
                totalResult = totalResult - value
            case "/":
                if totalResult == 0 {totalResult = value; return}
                totalResult = totalResult / value
            case "*":
                totalResult = totalResult * value
            default:
                error = ErrorResult(errorCode: 3, errorMsg: "Unknown operation")
                return
            }
        })
        finalResult.append(OperationResult(name: safeoperationName, result: totalResult))
    })
    
    return (result: finalResult, error: error)
    
}

let result = read(instructions: [input, inputB, inputC])



result.result?.forEach({
    res in
    print(res)
})

//Interne DLS
