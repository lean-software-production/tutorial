package main

import (
	"flag"
	"fmt"
	"os"
)

const tetrisSeed Seed = "a game of Tetris that runs in the terminal"

var (
	runAll   = flag.Bool("all", false, "run to completion instead of one pass")
	seedFlag = flag.String("seed", string(tetrisSeed), "the seed to build from")
)

func main() {
	flag.Parse()

	plan, exists, err := loadPlan(planPath)
	if err != nil {
		fmt.Println("error:", err)
		os.Exit(1)
	}
	if !exists {
		plan = planFromSeed(Seed(*seedFlag))
		if err := savePlan(planPath, plan); err != nil {
			fmt.Println("error:", err)
			os.Exit(1)
		}
		fmt.Println("created a new plan")
	}

	// A one-pass run whose only job was to create the plan is done.
	if !exists && !*runAll {
		printPlan(plan)
		return
	}

	for {
		n, err := doNextTask(&plan)
		if err != nil {
			fmt.Println("error:", err)
			os.Exit(1)
		}
		if err := savePlan(planPath, plan); err != nil {
			fmt.Println("error:", err)
			os.Exit(1)
		}
		if n == 0 {
			fmt.Println("nothing to do — the plan is complete")
			break
		}
		fmt.Printf("did task %d\n", n)
		if err := commitWork(plan.Tasks[n-1].Name); err != nil {
			fmt.Println("error:", err)
			os.Exit(1)
		}
		if !*runAll {
			break
		}
	}

	printPlan(plan)
}

func printPlan(plan Plan) {
	for i, t := range plan.Tasks {
		done := " "
		if t.Done {
			done = "x"
		}
		fmt.Printf("[%s] %d. %s\n", done, i+1, t.Name)
	}
}
