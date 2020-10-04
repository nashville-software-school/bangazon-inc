# Enhancing Gifter

Let's make Gifter a bit more interesting.

> **NOTE:** For the exercises below, _hard-code_ the current user profile id into your Web API. For example if you hard code a user profile id of `1`, when adding a comment, set the UserProfileId to `1`.  

> **NOTE:** For testing purposes, it's a good idea to make this hard-coded UserProfileId easy to change. You may wish to add aa static property to the `UserProfile` class.

```cs
public class UserProfile
{
    public static int CURRENT_USER_PROFILE_ID
    {
        get { return 1; }
    }

    // ... other code omitted for brevity...
}
```

You can then access this property when you need a UserProfileId

```cs
[HttpPost]
public IActionResult Post(Comment comment)
{
    comment.UserProfileId = UserProfile.CURRENT_USER_PROFILE_ID;

    // ... other code omitted for brevity...
}
```


> **NOTE:** We'll be adding real auth to Gifter soon. When we do that yous should remove the hard-coded UserProfileId code.

## Exercises

1. Allow users to edit _their own_ posts.
1. Allow users to delete _their own_ posts
1. Allow users to comment on any post.
1. Add a "like" button to a Post's details.       
    * Clicking this button should increment the number of "likes" associated with a Post.
    * A user should be able to "like" a post as many times as possible.
    * Do not record the user who "liked" ths Post.
    * A like cannot be removed.
1. When displaying Posts sort the Post by number of likes. The most liked Posts should be on top.
1. Allow users to "subscribe" to other users' posts.
    1. Create a view that lists all users in the system.
    1. Add a button beside each user in the list to allow the "current" user to subscribe to that user's posts.
    1. In the even that the current user is subscribed to a particular user, the button should perform an un-subscribe action.
    1. Add a new route to the app that will show a user the Posts created by users to whom they are subscribed.