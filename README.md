# Structs for models

This is a finished project described in blogpost _here_. For more details, context, motivation and more please check it out!

Used pods: Realm, Haneke.
Used library: [Sourcery](https://github.com/krzysztofzablocki/Sourcery) by [Krzysztof Zablocki](http://merowing.info/).


# Sidenotes

The purpose of this project is:
- how to supercharge your work by using code generation with Sourcery
- increase abstration and separate dependency from persistence type
- give a sense how you could use Sourcery for other useful cases where boilerplate code are necessary

I'm **NOT** showing here:

- how to effeciently store JSONs with CoreData/Realm 😅
- how to use CoreData/Realm as cache(since it's ridiculous idea)
- utilizing caching method from external libary(like Haneke, just used for images for ease of use. We could surely store images as Data, but that's not the goal here.)
