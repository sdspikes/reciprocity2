# README
[![Build Status](https://travis-ci.org/sdspikes/reciprocity2.svg)](https://travis-ci.org/sdspikes/reciprocity2)

Used [this article](https://medium.com/@chinnatiptaemkaeo/integrate-omniauth-facebook-to-rails-5-1389d760d92a) to start the project

Note: Remember to restart your rails server (`rails s`) after installing and configuring devise.

Switch sqlite3 to pg: https://devcenter.heroku.com/articles/sqlite3

### Environment Variables

Make sure you have `gem 'dotenv'` in your gemfile and `bundle install`.

Create a file in the base directory of the project called `.env`, with the following:
```
FB_APP_ID=<your_app_id>
FB_APP_SECRET=<your_app_secret>
TEST_FB_APP_ID=<your_test_app_id>
TEST_FB_APP_SECRET=<your_test_app_secret>
```

### Running locally

set up ssl certificate: 
https://www.devmynd.com/blog/rails-local-development-https-using-self-signed-ssl-certificate/

Run locally with
```rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'```

### Set up fb test app:

#### under **Settings** -> **Basic**
Website -> **Site URL**:
`https://www.localhost:3000/`

App Domains:
`https://www.localhost:3000/`

#### under **Facebook Login** -> **Settings** under **Valid OAuth Redirect URIs**:
`https://www.localhost:3000/users/auth/facebook/callback`


### deploy to heroku:

```
heroku create
git push heroku master
heroku config:set FB_APP_ID=<your_app_id>
heroku config:set FB_APP_SECRET=<your_app_secret>
```

### Set up FB app

Same as test app, but use your heroku link (use `heroku open` if you don't have the heroku link copied)
