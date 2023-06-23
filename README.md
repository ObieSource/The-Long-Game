# Contribution Guide

## Setting Up Development Environment

### Create Local and Fork Repositories

Clone this project, naming this url as "upstream" instead of "origin" by using

```
git clone --origin upstream git@github.com:ObieSource/The-Long-Game.git
```

On the GitHub website, make your own fork by clicking [fork](https://github.com/ObieSource/The-Long-Game/fork).

Then on your personal machine, run the following command, with your own username:

```
git remote add origin git@github.com:your-username/The-Long-Game.git
```

The first time you try to push a commit, run

```
git push -u origin main
```

After the firt time, just `git push` will do the trick.

### Installing Godot

You'll also need to [install Godot](https://godotengine.org/download/). As of writing, you should install Godot 4 with C# support (perhaps called the ".NET" or "mono" version).

## Submitting Changes

Regularly commit and push your changes to your fork. To keep track of changes, run `git status`.

Running `git status` will give three categories of changes:

1. Changes that have been added to git and will be included in the next commit
2. Changes that have not been added, but the files changed are already tracked by git
3. Any files git does not yet track

Run `git add` on the specific files that are relevant to the changes you just made.
```
git add file-I-changed.tscn other-changed-file.gd
```

Every time you get something new working, commit and push your changes to your fork:
```
git commit -m "Added flight to bird node"
git push
```

Before making a pull request on GitHub's website, make sure your project is compatible with the most recent changes. Run:
```
git pull upstream
```

If there are no merge conflicts, you can push to your fork, and then make your pull request on github.com as normal.

If there are merge conflicts, fix them or seek help to fix them. You've got this! When you're done, push to your fork and make a pull request on github.com.
