package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    if len(os.Args) != 4 {
        fmt.Println("Usage: <number1> <operation> <number2>")
        fmt.Println("Example: 5 + 3")
        return
    }

    num1, _ := strconv.ParseFloat(os.Args[1], 64)
    op := os.Args[2]
    num2, _ := strconv.ParseFloat(os.Args[3], 64)

    switch op {
    case "+":
        fmt.Printf("%.2f\n", num1+num2)
    case "-":
        fmt.Printf("%.2f\n", num1-num2)
    case "*":
        fmt.Printf("%.2f\n", num1*num2)
    case "/":
        if num2 != 0 {
            fmt.Printf("%.2f\n", num1/num2)
        } else {
            fmt.Println("Division by zero error")
        }
    default:
        fmt.Println("Unsupported operation. Use +, -, *, or /.")
    }
}

