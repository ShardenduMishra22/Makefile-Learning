# Worker Pool in Go

## Option 1: Current Code (Already Parallel)

```go
package main

import (
    "fmt"
    "sync"
    "time"
)

func main() {
    fmt.Println("Hello, Makefile Module!")

    var wg sync.WaitGroup

    for i := range 500 {
        wg.Go(func() {
            time.Sleep(100 * time.Millisecond)
            fmt.Printf("Hello from WaitGroup!, Goroutine %d\n", i)
        })
    }

    wg.Wait()
}
```

## Option 2: Controlled Concurrency with Worker Pool

```go
package main

import (
    "fmt"
    "sync"
    "time"
)

func main() {
    fmt.Println("Hello, Makefile Module!")

    var wg sync.WaitGroup
    workers := 10
    jobs := make(chan int, 500)

    // Start workers
    for range workers {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for i := range jobs {
                time.Sleep(100 * time.Millisecond)
                fmt.Printf("Hello from WaitGroup!, Goroutine %d\n", i)
            }
        }()
    }

    // Send jobs
    for i := range 500 {
        jobs <- i
    }
    close(jobs)

    wg.Wait()
}
```