# BSD-CHALLENGE

Software Developer Challenge

## Challenge 1:
Read through the rest of the assignment, decide which technologies to use and explain why you chose what you chose. As a reminder we may deal with a lot of different data sources.

## Challenge 2:
Create a deployable "Hello World" Server exposing simple REST "Hello World" API. It is going to be a base for your application for this assignment.

## Challenge 3:
Pick one of the available online API's such as Twitch(https://dev.twitch.tv/docs/api/), and TwitchTracker.com (twitchtracker.com) create and implement a flow involving that API and user of your application. 

For example, your application might have following UI:
```
Wich Twitcher are you looking for?

[________________________] [SEARCH]

[ Result 1 ]
[ Result 2 ]
[ Result 3 ]
```

User will insert text and click the button Search and your application will search twitch information that contain submitted string. 
Information that would be good to see in the results provided is the basic twitch profile info and if a certain profile is on the top positions in the top live channels on twitchtracker or not.

*Note*: it is only an example, go wilder than that :)

## Challenge 4:
Make your application secure and personalized by making people to have to sign-up / login. Bonus points, if users will be able to reset their passwords.

## Challenge 5:
Make your application persistent. Whatever functionality your application has, after restart, make it possible to view a history of user activity or anything else you deem necessary.

## Challenge 6:
Test your application.

## Challenge 7:
Let us know how we can use it. You could either provide us with a zipped file containing your solution or a link to your Github repository containing one.

## Bonus (optional):
Add an "I'm feeling lucky button" that does a random search, but make sure that same result is not returned twice or that you don't return a page that the user already viewed. Use the user stored history to do so. Since going through the history can potentially be costly, suggest and optionally implement optimization mechanism to avoid hitting the storage every time.

## Manuel's clarifications
### Prerequisites
- redis
- rbenv

To execute and test:
```
git clone https://github.com/manoloonline/bsd-challenge-manuel.git
cd bsd-challenge
rbenv install 3.1.1
rbenv local 3.1.1
bundle
rails s
rails test
```

### Challenge 5
Persistence in the app has been implemented with paper_trail gem, changes in user model are persistent in versions table and some script or data analist could take the historic needed information.
### Challenge 6
Just only basic testing was added, in my opinion I would use rspec + capybara for integration/acceptance test
### Bonus
Due to lack of time, this part was not implemented. To improved accesses to storage I would choose store the information with a data structure similar than a hash in memory. More specifically, using a secondary DB like redis and store the whole historical of each client with a key/list structure.
