# RedditClientIOSAinsigne
Develop an application that can search and show Reddit and their posts - a simple Reddit client.


# Design and implement an app as a long term project


As a tech lead of an IOS team. I planned ahead and chose to create the app based on a certain architecture. Either mvp or mvvm or viper which I have templates of. The idea is to make use of a boilerplate that is easy to follow and can and would be unit tested as demonstrated within the app as well. I chose mvp in favor of the others as mvvm typically requires doing the reactive way and data binding not always but most view it as that and since the requirements require not to use open source libraries which I prefer as well. It is the best architecture for the specs afaik

The idea with it is simple

4 classes will be generated using the template

Presenter - used as mediator between displaying to the view and making use of services
Injector - injects the basic dependencies automatically
ViewController - displays the view. default for ios
Services - allows access to managers and network

Doing this approach allows easily tested components and removes dependencies on each other which would allow the members to work freely while making use of mocks which will not hinder other member's progress

Some mock responses should be available here

RedditClientApp -> Model -> Responses

Other than that there is also a need to seperate the mock api and the api which is going to be used to handle reddit get and post requests

RedditClientApp -> Manager -> MockAPIManager
RedditClientApp -> Manager -> RedditAPIManager

I made 2 seperate managers for each which follows the same calls using the protocol which then allows switching between the two depending on the environment you are in. In this case there is only two RedditClientApp and the MockRedditClientApp which is handled via scheme. If there is a need to create target it can be used in the future with minor modifications only

I also made a lot of convenience classes for extensions saving locally via user defaults etc

Utils -> Config
Utils -> Extensions

As for the unit test before proceeding

# Make sure to switch to the MockRedditClientApp

I have provided samples of how to test the various functionalities within the app.
RedditClientAppTests -> RedditClientRetrievedTest
                        RedditClientPresenterTest
                        RedditClientManagerTest

If planning to update the client id please check the Config
RedditClientApp -> Utils -> Config

Should there be any questions feel free to ask.

# Minimum Specification
Users can browse through different subreddits/communities or search for a specific subreddit - 
# Done
Once a user clicks on a specific subreddit, expand the table to show the different posts
# Done
Once user clicks on a post, open a web view to show the post
# Displayed in a different view instead (See Optional Specifications)

# Optional Specifications. Other Requirements(Nice to have)
Instead of opening a webview, create a screen for post details
# Done
Make it look like the original Reddit app
# I did what i can do with the time. Can't seem to find any links to the images used for the app so i added some custom placeholder images
Show comments
# Done
Anything else you can come up with
# Added seperate scheme for mock in the unit tests and reddit api used for dev
# Implemented mvp architecture good for long term app developments
# Used decodable for the json responses
# Dependency injection
# Autolayout
# Localized strings
# Rules and about subreddit display in the subreddit details by clicking the subreddit name itself
# Reddit post preview by cliking the image
# Reddit about the user info by clicking the username
# Inbox and overview from the user which serves as notifications
# If not logged would not allow to submit/post


