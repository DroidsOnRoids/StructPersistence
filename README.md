This is a finished project described in blogpost [here](https://www.thedroidsonroids.com/blog/ios/persisting-struct-with-sourcery-magic/). For more details, context, motivation and more please check it out!

Used pods: 
- [Realm](https://github.com/realm/realm-cocoa) 
- [HanekeSwift](https://github.com/Haneke/HanekeSwift)

Used library: 
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) by [Krzysztof Zablocki](http://merowing.info/).

# Usage 

You declare what template you want to apply on a struct with //sourcery: templateOne, templateTwo, etc:

```
//sourcery: NSCodingWrapper, RealmStruct, CoreDataStruct
struct Shot {
    let id: Int
    let url: String
    let likes: Int
    let comments: Int
    let buckets: Int
    let views: Int
}
```

To launch codegen you need to run Sourcery via:
```
$ ./sourcery --sources <sources path> --templates <templates path> --output <output path> [--args arg1=value,arg2]
```

For more info please check out the [Sourcery repo.](https://github.com/krzysztofzablocki/Sourcery)

# Sidenotes

The purpose of this project is:
- how to supercharge your work by using code generation with Sourcery
- increase abstration and separate dependency from persistence type
- give a sense how you could use Sourcery for other useful cases where boilerplate code are necessary

I'm **NOT** showing here:

- how to effeciently store JSONs with CoreData/Realm 😅
- how to use CoreData/Realm as cache(since it's ridiculous idea)
- utilizing caching method from external libary(like Haneke, just used for images for ease of use. We could surely store images as Data, but that's not the goal here.)
