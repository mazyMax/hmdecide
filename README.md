# Final Project Launch Readme

### 1. Team Member Names

Project Team 28 <br />
Sixuan Wang: sw3513 <br />
Yanhao Li: yl4735 <br />
Yaning Ling: yl4741 <br />

### 2. Instructions to Run the Program

We mainly developed locally on Windows machine and test under Linux, first, create a new ruby on rails project, then in the terminal and run: <br />
$ git clone -b iter3_lyh https://github.com/mazyMax/hmdecide.git <br />
Please be aware that when testing locally using rails server, deleting a vote will result in an error of "database is locked" because sqlite does not support concurrency. This is not an issue in the production environment since psql is used such that our app on Heroku is not affected by this. <br />
Also, the users stories testing through Cucumber requires Firefox since JavaScript is used in our app. <br />

#### NOTE: invite @DelphianCalamity, @chini5ko, @wyjw for access the github

Then enter our project by running: <br />

`$ cd hmdecide/ `
And then run: <br />

```
$ bundle install --without production
$ yarn install --check-files
$ bundle exec rake db:migrate
$ bundle exec rake db:test:prepare
$ rake cucumber
$ rake spec
```

Now the installation is done, then run: <br />
`$ rails server -b 0.0.0.0` <br />

Then you need to stop the server, restart it, click the BOX URL, And you will see the website's home page saying: "Help me Decide! Vote Anytime, Anywhere" <br />
Now you may see some posts on the home page, you have to sign up for our website before creating a new vote. After logging in, you could create a new vote, navigate to profile and update your account or log out. <br />
To see cucumber test results, run: <br />
`$ rake cucumber` <br />
To see spec test coverage results, run: <br />
`$ rake spec` <br />

Our cucumber and spec testing results are as in the attached files.

### 3. User stories and RSpec

For User stories,  we tested user sign up, login and logout, view profile, edit profile, update account, create new posts and choices with or without existing time limit (while allow or not allow location access), close votes, search by tag, search function on the home page, vote function, follow/unfollow function, change visibility of existing posts function, sort posts by popularity or location function, view posts by followings function. Also, based on the feedback of the TA from last iteration, we implemented the function that validates the uploading file. For another comment from the last iteration, the posts we can see from the home page are all currently running by default with different order. Note that some of them are filtered out due to accessibility and visibility constrains. 
We achieved 100% coverage for users stories with all scenarios passed on Cucumber. 

For RSpec, we tested all functions and models defined in our project, as you can see in our /spec folder, we defined controller_spec, factoryBot, mailers and model_spec. We achieved 100% coverage for unit testing on RSpec. 

### 4. Heroku Link:

https://still-river-97683.herokuapp.com/

### 5. Link to Github Repo:

https://github.com/mazyMax/hmdecide/tree/iter3_lyh

### 6. Features we've  implemented

a. Fully Implemented: <br />
    User sign up, log in, log out, update user account like username and password, edit user's detailed information like bio and phone, forget password procedure. Home page show all the posts. 
    Search function by keywords or tags, upload a picture for post cover, upload image for a voting choice, dynamic choice adding button, initialize a post and voting choice or
    choices in one view page with/without location access as well as existing time limit, delete post, close vote, and change visibility function. Follow/unfollow other users, view posts by following users' posts, popularity, and nearby location function. Better UI design and interaction experience. Fix all bugs. 100% spec and 100% Cucumber coverage.<br />
