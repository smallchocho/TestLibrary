//: Playground - noun: a place where people can play

import UIKit
enum InterViewError:Error{
    case ageProblem
    case payProblem
    case educationProblem
    case otherProblem
}
enum Education{
    case university
    case highSchool
    case joniorHighSchool
}

func errorHandler(age:Int,pay:Int,education:Education) throws -> String {
    guard 18 <= age && age < 40 else{
        throw InterViewError.ageProblem
    }
    guard pay <= 65000 else{
        throw InterViewError.payProblem
    }
    guard education == .university else{
        throw InterViewError.educationProblem
    }
    return "恭喜錄取"
}
func goInterView(){
    do {
        print(try errorHandler(age: 29, pay: 70000, education: .joniorHighSchool))
    }catch InterViewError.payProblem {
        print("你的期望薪資太高了")
    }
    catch InterViewError.ageProblem {
        print("你的年齡太高了")
    }
    catch InterViewError.educationProblem {
        print("你的學歷太低了")
    }
    catch{
        print("無聲卡")
    }
}
goInterView()


