# IAC-Coursework
IAC Coursework

Start Date: 13/11/2021 End Date: 17/12/2021

Github Naming Convention:

Stable - stable - Accepts merges from Working and Hotfixes Working - master - Accepts merges from Features/Issues and Hotfixes

Features/Bug topic-* - Always branch off HEAD of Working Hotfix hotfix-* - Always branch off Stable

If you are working on a new feature i.e. Solving inverse of conductance matrix, start a new branch named feature/solveconductancematrix

Side note:

    Head is a pointer that points to the latest commit of a branch. Always create a new branch of the HEAD of master when trying to add a new feature

    DO NOT use hotfix for non-urgent bugs. Hotfix is only used to fix bugs off the Stable version of program. Use branch (bug)

If unsure of the convention, always refer to the link below! https://gist.github.com/digitaljhelms/4287848 (There are a lot of naming conventions out there. This is the one we are using for this project)

Commit Messages convention:

[optional scope]: etc. fix: solve inverse matrix which means the feature of solve inverse matrix has a bug and is fixed

info - used for info and comments fix - used for bug fixes feat - used for feature hotfix - used for bug fixes off stable

some useful Git Commands:

git fetch --prune (Delete merged branches in vscode, restart vscode after command)

git status (List which files are staged, unstaged, and untracked.)

git log (Shows commits history)

Git commands cheatsheet: https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet