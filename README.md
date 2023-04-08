# Concept Document for The Long Game

## Basic Concept
* A browser game, hosted on the ObieSource website
* The game is multiplayer, each player controls a character in the game
* Players may move objects around the world and build structures(?)
* The world changes through procedural growth and decay without player intervention.

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

## Mechanics
* Player movement
* Picking up/placing items
* Procedural change
* NPC interaction?

## Content Ideas
* Volcano
	* Also earthquake/plate-related changes
* Forest growth
	* Related plant growth through birds dropping seeds
* NPC(?) who grants a wish of a world event

## Concept Art
