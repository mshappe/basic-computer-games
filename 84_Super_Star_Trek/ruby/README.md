Original source downloaded [from Vintage Basic](http://www.vintage-basic.net/games.html)

Conversion to [Ruby](https://www.ruby-lang.org/en/)

Status: In progress, not yet playable

This is an attempt at a port of [Super Star Trek](https://github.com/coding-horror/basic-computer-games/tree/main/84_Super_Star_Trek) to idiomatic Ruby.

This means I have not actually been preserving variable names or even structure from the original BASIC version, but instead, because I can never do anything the easy way, I'm attempting to divine the intent of the original code, and render it as closely as possible in "proper" Ruby, complete with specs.

Some things that helped in this endeavour:

The original coder(s) had some idioms they used fairly consistently. For example, a variable ending in `0`, if present, is the minimum value, one ending in `9` was a maximum, and one ending in `3` was the value within a specific quadrant.

So, for example, `T0` is your starting stardate, `T9` is your deadline (`T` for time, in stardates). `K9` is the number of enemies you have to fight (`K` for Klingon, of course), `B9` the number of starbases available, etc. Within a quadrant, `K3` is the number of Klingons you'll be facing, `B3` the number of starbases, and so on.

It took a whie to figure out a few other things that were a bit opaque until seeing them in use (although I suspect I had figured these things out back in the 80s, the first time I ported this, at the time to Commodore 64 BASIC).

The `C` array, for example, is a set of offsets for navigation. The first dimension is the direction, where 1 is east, 3 north, 5 west, 7 south, and the second dimension contains the offets, index 1 being y, index 2 being x, a value of -1 meaning west or north, 1 meaning east or south. The `D` array is the Damage Control Status, which is **really** opaque until you see how the systems map to array numbers in around BASIC line 8780.

While BASIC of the 70s and 80s had subroutines (cf `GOSUB` and `RETURN` in the BASIC code), they had no direct way of passing parameters--and indeed, there's no concept of a local variable, or even scope, in BASIC. It's all one big flat namespace. Here, again, convention is important. The original coder(s) used suffixes of `1` and `2` on variables generally to represent Y and X coordinates. `R1` and `R2` are randomly generated coordinates returned by the subroutine starting at line 8590 (which I've called `Quadrant#find_space`), while `Z1` and `Z2` are passed to the subroutine at 8670 (which I've called `Quadrant#place_entity`), as an example.

These intentions are being translated into (hopefully) readable Ruby, with specs to try to keep my understanding of what was going on honest. The goal is not just to port the code, but to provide what might be a useful starting point for someone wanting to learn Ruby.

The proof, of course, will be in the playing, when it's playable!

Michael Shappe <mshappe@itasca.net>
8 January 2022
