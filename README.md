# README
[![Build Status](https://travis-ci.org/sdspikes/reciprocity2.svg)](https://travis-ci.org/sdspikes/reciprocity2)

Note: If you run into any issues during setup, please feel free to reach out by creating an [issue](https://github.com/sdspikes/reciprocity2/issues) on this repository!  If possible, include the command you ran and the error you ran into in the issue!

## Setting up your local environment

### Update your version of ruby

If you do not have a ruby version manager already, pick one of `rvm` and `rbenv`.  (If you aren't sure if you have either, run `which rvm` and `which rbenv` to check.)

If you use [Homebrew](https://brew.sh/), `rbenv` is likely to be simpler.

#### `rbenv`

##### Install rbenv if necessary
See the docs for [rbenv](https://github.com/rbenv/rbenv)

If using homebrew: `brew install rbenv`

##### Set version

Run 
```
rbenv install 2.4.2
rbenv local 2.4.2
```

#### `rvm`

##### Install rvm if necessary
If you want to use RVM and don't have it, install [rvm](https://rvm.io/rvm/install)
```curl -sSL https://get.rvm.io | bash -s stable --ruby```
##### Set version

```
rvm install 2.4.2
rvm use 2.4.2
```

### Postgres

Install postgress (if using brew on Mac, follow [this guide](https://gist.github.com/ibraheem4/ce5ccd3e4d7a65589ce84f2a3b7c23a3), otherwise look up instructions for your OS)

Make sure to set up postgres roles and start your postgres server.

### Bundle Install
Now that you've got your version of ruby set up, in the root directory of the app, run 
```
gem install bundler
bundle install
```

This should grab all the ruby dependencies needed for the app.

### Yarn

The frontend uses React, a javascript library, and we use the `yarn` package manager to manage dependencies.  You will need to install `yarn` (`brew install yarn`) then run `yarn install` to get all the dependencies.

### Set up database

```
rails db:create # creates the database
rails db:migrate # sets up the tables
rails db:seed # sets up fake user data
```

### Running locally


Run locally with
```rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'```

(see the following link for how to set up self-signed certificates: 
https://www.devmynd.com/blog/rails-local-development-https-using-self-signed-ssl-certificate/)

### Authenicating using Facebook

If you want to be able to log in locally using Facebook, create a new facebook app by going [here](https://developers.facebook.com/)

Note: I used [this article](https://medium.com/@chinnatiptaemkaeo/integrate-omniauth-facebook-to-rails-5-1389d760d92a) to start the project initially, and it has better/more full instructions on this step under "Step:1 create Facebook App."


#### under **Settings** -> **Basic**
Website -> **Site URL**:
`https://www.localhost:3000/`

App Domains:
`https://www.localhost:3000/`

#### under **Facebook Login** -> **Settings** under **Valid OAuth Redirect URIs**:
`https://www.localhost:3000/users/auth/facebook/callback`


#### Set Environment Variables

Create a file in the base directory of the project called `.env`, with the following:
```
FB_APP_ID=<your_app_id>
FB_APP_SECRET=<your_app_secret>
TEST_FB_APP_ID=<your_test_app_id>
TEST_FB_APP_SECRET=<your_test_app_secret>
```

### Deploy to Heroku

If you want a production version, run the following.  You'll need to log in with a heroku account on the first step, so create one beforehand.
```
heroku create
git push heroku master
heroku config:set FB_APP_ID=<your_app_id>
heroku config:set FB_APP_SECRET=<your_app_secret>
```

You'll also need to set up the production database
```
heroku run rails db:create
heroku run rails db:migrate
heroku run rails db:seed
```

#### Set up production FB app

Same as local test app, but use your heroku link (use `heroku open` if you don't have the heroku link copied)
