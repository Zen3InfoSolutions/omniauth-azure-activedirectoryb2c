# Rails Application built on OmniAuth with Azure AD B2C and REST API Service for Node.js using MongoDB and Restify

This sample shows how to build a rails MVC web application that demonstrates user authentication with omniauth for Azure Active Directory B2C . It assumes you have some familiarity with Azure AD B2C. If you'd like to learn all that B2C has to offer, start with our documentation at aka.ms/aadb2c.

The app performs sign-in and sign-out functions with sign-in policy. Once the user signed in sample GET/POST requests can be made to **Node.js** task service secured by Azure AD B2C. It is intended to help get you started with Azure AD B2C in a simple web application built on omniauth, giving you the necessary tools to execute Azure AD B2C policies & securely identify users in your application.  

##### Please note that this functionality is still in "preview"


## Release Notes

- Silent renewing of access tokens is not supported by omniauth. However custom code can be added to verify token expiry and get refresh token.


## How To Run This Sample
Getting started is simple! To run this sample you will need:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Bundler](http://bundler.io)
- An Internet connection
- An Azure subscription (a free trial is sufficient)
- Node.js and MongoDB (instructions in Step 6 and 7)

### Step 1:  Clone or download this repository

From your shell or command line:

`git clone https://github.com/Azure-Samples/active-directory-b2c-javascript-singlepageapp-nodejs-webapi.git` 

### Step 2: Get your own Azure AD B2C tenant

You can also modify the sample to use your own Azure AD B2C tenant.  First, you'll need to create an Azure AD B2C tenant by following [these instructions](https://azure.microsoft.com/documentation/articles/active-directory-b2c-get-started).

### Step 3: Create your own policies

This sample uses three types of policies: a sign-in policy, a sign-up policy & profile editing policy.  Create one policy of each type by following [the instructions here](https://azure.microsoft.com/documentation/articles/active-directory-b2c-reference-policies).  You may choose to include as many or as few identity providers as you wish.

If you already have existing policies in your Azure AD B2C tenant, feel free to re-use those.  No need to create new ones just for this sample.

### Step 4: Create your own applications

Now you need to create your own appliations in your B2C tenant, so that each of your app has its own Application ID.  You can do so following [the generic instructions here](https://azure.microsoft.com/documentation/articles/active-directory-b2c-app-registration).  Be sure to include the following information in your app registration:

##### Create application for the Rails App

- Enable the **Web App/Web API** setting for your application.
- Add **two** rediect_uris for your app.  Their values should take the form 
    - `http://localhost:3000/auth/azureactivedirectoryb2c/callback`
- Copy the Application ID generated for your application, so you can use it in the next step.

##### Create one more application for the REST API

- Enable the **Web App/Web API** setting for your application.
- Enter `http://localhost/TodoListService` as a Reply URL. It is the default URL for this code sample.
- Copy the Application ID that is assigned to your app. You need this data later.

### Step 5 - Install OmniAuth Azure AD B2C from source
Note: This can and should be removed once ADAL B2C is available on RubyGems. After that point ADAL will be installed along with the other dependencies in step 3.

```
cd omniauth-azure-activedirectoryb2c
gem build omniauth-azure-activedirectoryb2c.gemspec
gem install omniauth-azure-activedirectory
```

### Step 6 - Install the sample dependencies

```
cd \rails-todolist-app-nodeapi\rails-todolist-app
bundle
```

### Step 7 - Set up the database

```
rake db:schema:load
```

### Step 8 - Configure the app

Open `config/initializers/omniauth.rb` and replace with applicationid created for rails app, tenantname and sign-in policy.

### Step 9: Configure the sample to use your Azure AD B2C tenant

Now you can replace the app's default configuration with your own.  


### Step 10: Download node.js for your platform
To successfully use this sample, you need a working installation of Node.js.

Install Node.js from [http://nodejs.org](http://nodejs.org).

### Step 11: Install MongoDB on to your platform

To successfully use this sample, you must have a working installation of MongoDB. We will use MongoDB to make our REST API persistent across server instances.

Install MongoDB from [http://mongodb.org](http://www.mongodb.org).

**NOTE:** This walkthrough assumes that you use the default installation and server endpoints for MongoDB, which at the time of this writing is: mongodb://localhost. This should work locally without any configuration changes if you run this sample on the same machine as you've installed and ran mongodb.


### Step 12: Download the modules needed by REST API

Navigate to the node-server folder and run `npm install` command to download node modules.

From your shell or command line:

* `$ cd rails-todolist-app-nodeapi\B2C-WebApi-Nodejs\node-server`
* `$ npm install`

### Step 13: Configure your server using config.js

You will need to update config.js in the node-server folder. make sure you copy the SPA app applicationID as the audience (calling application) and REST API aplicationId as applicationID.
update the tenant names and policyName with appropriate values.

```javascript
 exports.creds = {
     mongoose_auth_local: 'mongodb://localhost/tasklist', // Your mongo auth uri goes here
     applicationID: '2ad0ce46-7ee7-4705-a134-d86106a7f569', // your applicationID for this REST API created in the portal
     audience: '2ea10cce-58f2-4b26-8b5a-65d75553aac1', //the applicationID of the rails application created in the portal
     identityMetadata: 'https://login.microsoftonline.com/tenantazureb2c.onmicrosoft.com/v2.0/.well-known/openid-configuration', //replace the tenant name
     tenantName:'tenantazureb2c.onmicrosoft.com', //Azure AD B2C tenant name
     policyName:'B2C_1_sign_in', //This is the policy you'll want to validate against in B2C. Usually this is your Sign-in policy (as users sign in to this API)
     validateIssuer: true,
	 issuer: null, // Optional, we use the issuer from metadata by default
     passReqToCallback: false //This is a node.js construct that lets you pass the req all the way back to any upstream caller. We turn this off as there is no upstream caller.
 };
```


### Step 14: Run the application


* `$ cd node-server	`
* `$ node app.js`

**Is the server output hard to understand?:** We use `bunyan` for logging in this sample. The console won't make much sense to you unless you also install bunyan and run the server like above but pipe it through the bunyan binary:

* `$ node server.js | bunyan`

You will have a server successfully running on `http://localhost:8124`. Your REST / JSON API Endpoint will be `http://localhost:8124/api/tasks`

### Step 15:  Run the sample

* `$ cd rails-todolist-app-nodeapi\rails-todolist-app	` 
* `$ rails server	`

You may now proceed to https://localhost:3000 to view the application.

- after a user is signed in using **SignIn policy**, user can POST a task to the Node.js Task service (which is already running) and GET the tasks already created.