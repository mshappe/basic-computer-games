Original source downloaded [from Vintage Basic](http://www.vintage-basic.net/games.html)

Conversion to [Ruby](https://www.ruby-lang.org/en/)

Status: In progress, not yet playable

This is an attempt at a port of [Super Star Trek](https://github.com/coding-horror/basic-computer-games/tree/main/84_Super_Star_Trek) to idiomatic Ruby.

This means I have not actually been preserving variable names or even structure from the original BASIC version, but instead, because I can never do anything the easy way, I'm attempting to divine the intent of the original code, and render it as closely as possible in "proper" Ruby, complete with specs.

Some things that helped in this endeavour:

The original coders had some idioms they used fairly consistently. For example, a variable ending in 0, if present, is the minimum value, one ending in 9 was a maximum, and one ending in 3 was the value within a specific quadrant.

So, for example, T0 is your starting stardate, T9 is your deadline (T for time, in stardates). K9 is the number of enemies you have to fight (K for Klingon, of course), B9 the number of starbases available, etc. Within a quadrant, K3 is the number of Klingons you'll be facing, B3 the number of starbases, and so on.

It took a whie to figure out a few other things that wer ea bit opaque until seeing them in use. The C array, for example, is a set of offsets for navigation. The first dimension is the direction, where 1 is east, 3 north, 5 west, 7 south, and the second dimension contains the offets, index 1 being y, index 2 being x, a value of -1 meaning west or north, 1 meaning east or south. The D array is the Damage Control Status, which is **really** opaque until you see how the systems map to array numbers in around BASIC line 8780.

These intentions are being translated into (hopefully) readable Ruby, with specs to try to keep my understanding of what was going on honest. The proof, of course, will be in the playing, when it's playable!

Michael Shappe <mshappe@itasca.net>
8 January 2022
