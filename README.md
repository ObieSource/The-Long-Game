# Contribution Guide

Inspired by <https://xkcd.com/2061/>:

![xkcd 2061](https://imgs.xkcd.com/comics/tectonics_game_2x.png)

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

## Contributing your own art

Partly so that individual contributors can retain the rights to their art, and partly to expose ObieSource members to another Git strategy, we track assets (pictures and sounds) in external repositories.

The `git subtree` command allows us to copy in changes from another repository as the sprites are updated, and nest those changes in a folder called "assets".

The general workflow will be to use external repositories of open source sprites, and each one has its own subdirectory inside of "The Long Game/assets".

If you want to set up your own art repository, start by making a new folder at the same level as your local clone of The Long Game:
```
cd /arbitrarily-long-path/The-Long-Game
cd ..
mkdir [my-name]s-sprites
cd [my-name]s-sprites
git init
```

In this new local repository, draw any sprite in the root directory or a subdirectory (like "projectiles/snowball.png") and commit the changes.
```
git add projectiles/snowball.png
git commit -m "Drew new snowball sprite"
```

To submit your new assets to The Long Game repository, you first have to make a GitHub repository just for your art.

Make a new github repository called `[my-name]s-sprites` (or whatever name, just be consistent), then in your art repository, run
```
git remote add origin [your asset repo address]
git push -u origin main
```

Now `cd` to the Long Game directory so that we can bring in your work for the first time.

We'll add your asset directory as a remote here also, so that it's easier to pull your future changes.
```
cd ../The-Long-Game

git remote add [my-name]s-sprites [your asset repo address]
git subtree add --prefix assets/[my-name]s-sprites [my-name]s-sprites main --squash
git push
```
At this point, you can submit a pull request from your fork.

Now that you've run `git subtree add` once, you shouldn't have to run it again. If you ever make new changes to your assets folder, you should commit and push those changes to your asset repository. Then in The Long Game, run
```
git subtree pull --prefix assets/[my-name]s-sprites [my-name]s-sprites main --squash
```
