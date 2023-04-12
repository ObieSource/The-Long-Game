# Contribution Guide

## Setting Up Development Environment

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

You'll also need to [install Godot](https://godotengine.org/download/). As of writing, you should install Godot 4 with C# support (perhaps called the ".NET" or "mono" version).

Before making a pull request on GitHub's website, make sure your project is compatible with the most recent changes. Run:

```
git pull upstream
```

If there are no merge conflicts, you can push to your fork, and then make your pull request on the website as normal.