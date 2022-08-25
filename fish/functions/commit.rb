require "tty-prompt"

def commit
  prompt = TTY::Prompt.new
  type = prompt.select("Which type of change?", cycle: true) do |menu|
      menu.choice name: 'feature: A new feature.', value: 'feature'
      menu.choice name: 'refactor: A code change that restructuring an existing body of code without changing its external behavior.', value: 'refactor'
      menu.choice name: 'bug fix: A bug fix.', value: 'fix'
      menu.choice name: 'test: Adding missing or correcting existing tests', value: 'test'
      menu.choice name: 'style: formatting.', value: 'style'
      menu.choice name: 'docs: Documentation only changes', value: 'docs'
      menu.choice name: 'perf: A code change that improves performance', value: 'perf'
      menu.choice name: 'build: Changes that affect the build system or external dependencies', value: 'build'
      menu.choice name: 'ci: Changes to our CI configuration files and scripts', value: 'ci'
      menu.choice name: 'chore: updating grunt tasks.', value: 'chore'
  end

  title = ""
  message = ""

  if type != 'refactor'
    scope = prompt.ask("What is the scope of this change?:")

    title = prompt.ask("Write a short and imperative summary of the code changes (lower case and no period):")
    body = prompt.ask("Provide additional contextual information about the code changes:")

    if scope != ""
      message = "#{type}[#{scope}]: #{title}\n\n#{body}"
    else
      message = "#{type}: #{title}\n\n#{body}"
    end
  else
    title = prompt.select("Which Code Smells are you remove?", cycle: true) do |menu|
        menu.choice 'Large Class'
        menu.choice 'Long Function'
        menu.choice 'Long parametor list'
        menu.choice 'Data Clumps'
        menu.choice 'Data Class'
        menu.choice 'Alternatives Classes with Different Interfaces'
        menu.choice 'Refused Bequest'
        menu.choice 'Primitive Object Obsession'
        menu.choice 'Repeated Switches'
        menu.choice 'Global Variable'
        menu.choice 'Mutable Variable'
        menu.choice 'Divergent Change'
        menu.choice 'Shotgun Surgery'
        menu.choice 'Duplicated Code'
        menu.choice 'Lazy Element'
        menu.choice 'Speculative Generality'
        menu.choice 'Message Chains'
        menu.choice 'Middle Man'
        menu.choice 'Insider Trading'
        menu.choice 'Feature Envy'
        menu.choice 'Mysterious Name'
        menu.choice 'Loops'
        menu.choice 'Temporary Field'
        menu.choice 'Dead Code'
        menu.choice 'Comments'
    end
    message = "#{type}: #{title}"
  end

  confirm = prompt.yes?("Are you sure you want to proceed with the commit above?")

  if confirm
    exec "git commit -m \"#{message}\""
  end

end

commit
