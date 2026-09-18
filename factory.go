package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Seed is the factory's only input.
type Seed string

// Task is one piece of work in the plan.
type Task struct {
	Name string
	Done bool
}

// Plan is the list of tasks the factory works through, in order.
type Plan struct {
	Seed  Seed
	Tasks []Task
}

const (
	planPath = "plan.json"
	workDir  = "work"
)

// loadPlan reads a plan from disk. The bool is true when a plan existed.
func loadPlan(path string) (Plan, bool, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		if os.IsNotExist(err) {
			return Plan{}, false, nil
		}
		return Plan{}, false, err
	}
	var p Plan
	if err := json.Unmarshal(data, &p); err != nil {
		return Plan{}, false, err
	}
	return p, true, nil
}

// savePlan writes a plan to disk as JSON.
func savePlan(path string, p Plan) error {
	data, err := json.MarshalIndent(p, "", "  ")
	if err != nil {
		return err
	}
	return os.WriteFile(path, data, 0644)
}

// doNextTask marks the first not-done task as done and writes a work
// file for it. It returns the 1-based number of the task done, or 0
// when every task is already done.
func doNextTask(p *Plan) (int, error) {
	for i := range p.Tasks {
		if p.Tasks[i].Done {
			continue
		}
		p.Tasks[i].Done = true
		name := strings.ToLower(strings.ReplaceAll(p.Tasks[i].Name, " ", "-"))
		if err := os.MkdirAll(workDir, 0755); err != nil {
			return 0, err
		}
		path := fmt.Sprintf("%s/%02d-%s.txt", workDir, i+1, name)
		if err := os.WriteFile(path, []byte(p.Tasks[i].Name+"\n"), 0644); err != nil {
			return 0, err
		}
		return i + 1, nil
	}
	return 0, nil
}

// commitWork ensures work/ is a git repo, then stages and commits
// everything in it.
func commitWork(name string) error {
	if _, err := os.Stat(workDir + "/.git"); os.IsNotExist(err) {
		if out, err := exec.Command("git", "-C", workDir, "init").CombinedOutput(); err != nil {
			return fmt.Errorf("git init: %v: %s", err, out)
		}
	}
	if out, err := exec.Command("git", "-C", workDir, "add", "-A").CombinedOutput(); err != nil {
		return fmt.Errorf("git add: %v: %s", err, out)
	}
	if out, err := exec.Command("git", "-C", workDir, "commit", "-m", name).CombinedOutput(); err != nil {
		return fmt.Errorf("git commit: %v: %s", err, out)
	}
	return nil
}

// planFromSeed turns a seed into a plan. Every task names the seed's
// goal, so the whole plan comes from the seed.
func planFromSeed(seed Seed) Plan {
	goal := string(seed)
	return Plan{
		Seed: seed,
		Tasks: []Task{
			{Name: "set up the project for " + goal},
			{Name: "write the main loop for " + goal},
			{Name: "draw the display for " + goal},
			{Name: "handle input for " + goal},
			{Name: "implement the rules for " + goal},
			{Name: "track state for " + goal},
			{Name: "add scoring for " + goal},
			{Name: "handle the end for " + goal},
			{Name: "polish " + goal},
		},
	}
}
