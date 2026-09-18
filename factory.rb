#!/usr/bin/env ruby

workspace = File.join(__dir__, "workspace")
spec_path = File.join(workspace, "spec.md")
plan_path = File.join(workspace, "plan.md")

if !File.exist?(plan_path)
  prompt = <<~PROMPT
    Read the spec at #{spec_path}.
    Break it into a small number of tasks needed to build it.
    Write #{plan_path} as a markdown checklist, one task per line, e.g.:
    - [ ] set up the project
    - [ ] ...
  PROMPT

  system("pi", "-p", prompt, "--no-context-files", chdir: workspace)

  tasks = File.readlines(plan_path).count { |l| l.strip.start_with?("- [") }
  puts "created plan.md (#{tasks} tasks) from spec.md"
else
  def run_pass(workspace, spec_path, plan_path)
    lines = File.readlines(plan_path)
    index = lines.find_index { |l| l.strip.start_with?("- [ ]") }
    return false unless index

    task = lines[index].strip.sub("- [ ] ", "")

    prompt = <<~PROMPT
      Read the spec at #{spec_path} and the plan at #{plan_path}.
      Implement this task in the project: #{task}
    PROMPT

    system("pi", "-p", prompt, "--no-context-files", chdir: workspace)

    lines[index] = lines[index].sub("- [ ]", "- [x]")
    File.write(plan_path, lines.join)

    system("git", "add", "-A", chdir: workspace)
    system("git", "commit", "-q", "-m", "task #{index + 1} done: #{task}", chdir: workspace)

    puts "task #{index + 1} done: #{task}"
    true
  end

  if ARGV.include?("--all")
    while run_pass(workspace, spec_path, plan_path)
    end
    puts "factory stopped — plan complete"
  else
    run_pass(workspace, spec_path, plan_path)
  end
end
