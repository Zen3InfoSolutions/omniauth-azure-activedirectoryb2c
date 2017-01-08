# OmniAuth Azure Active Directory B2C


OmniAuth strategy to authenticate to Azure Active Directory B2C via OpenId Connect.

### Get your own Azure AD B2C tenant

You can also modify the sample to use your own Azure AD B2C tenant.  First, you'll need to create an Azure AD B2C tenant by following [these instructions](https://azure.microsoft.com/documentation/articles/active-directory-b2c-get-started).

###  Create your own policies

This sample uses three types of policies: a sign-in policy, a sign-up policy & profile editing policy.  Create one policy of each type by following [the instructions here](https://azure.microsoft.com/documentation/articles/active-directory-b2c-reference-policies).  You may choose to include as many or as few identity providers as you wish.

If you already have existing policies in your Azure AD B2C tenant, feel free to re-use those.  No need to create new ones just for this sample.

### Create your own application

Now you need to create your own appliation in your B2C tenant, so that your app has its own Application ID.  You can do so following [the generic instructions here](https://azure.microsoft.com/documentation/articles/active-directory-b2c-app-registration).  Be sure to include the following information in your app registration:

## Samples and Documentation

[We provide a full suite of sample applications and documentation on GitHub](https://github.com/AzureADSamples) to help you get started with learning the Azure Identity system. This includes tutorials for native clients such as Windows, Windows Phone, iOS, OSX, Android, and Linux. We also provide full walkthroughs for authentication flows such as OAuth2, OpenID Connect, Graph API, and other awesome features. 

## Community Help and Support

We leverage [Stack Overflow](http://stackoverflow.com/) to work with the community on supporting Azure Active Directory and its SDKs, including this one! We highly recommend you ask your questions on Stack Overflow (we're all on there!) Also browser existing issues to see if someone has had your question before. 

We recommend you use the "adal" tag so we can see it! Here is the latest Q&A on Stack Overflow for ADAL: [http://stackoverflow.com/questions/tagged/adal](http://stackoverflow.com/questions/tagged/adal)


## How to use this SDK

#### Installation

Add to your Gemfile:

```ruby
gem 'omniauth-azure-activedirectoryb2c'
```

### Usage

If you are already using OmniAuth, adding Azure AD B2C is as simple as adding a new provider to your `OmniAuth::Builder`. The provider requires your Azure AD B2C client id, tenant name and policy name.

For example, in Rails you would add this in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :azure_activedirectoryb2c, ENV['AAD_CLIENT_ID'], ENV['AAD_TENANT'], ENV['SIGNIN_POLICY']
  # other providers here
end
```

If you are using Sinatra or something else that requires you to configure Rack yourself, you should add this to your `config.ru`:

```ruby
use OmniAuth::Builder do
  provider :azure_activedirectoryb2c, ENV['AAD_CLIENT_ID'], ENV['AAD_TENANT'], ENV['SIGNIN_POLICY']
end
```

When you want to authenticate the user, simply redirect them to `/auth/azureactivedirectory`. From there, OmniAuth will takeover. Once the user authenticates (or fails to authenticate), they will be redirected to `/auth/azureactivedirectory/callback` or `/auth/azureactivedirectory/failure`. The authentication result is available in `request.env['omniauth.auth']`.

If you are supporting multiple OmniAuth providers, you will likely have something like this in your code:

```ruby
%w(get post).each do |method|
  send(method, '/auth/:provider/callback') do
    auth = request.env['omniauth.auth']

    # Do what you see fit with your newly authenticated user.

  end
end
```

### Auth Hash

OmniAuth AzureAD tries to be consistent with the auth hash schema recommended by OmniAuth. [https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema](https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema).

Here's an example of an authentication hash available in the callback. You can access this hash as `request.env['omniauth.auth']`.

```
  :provider => "azureactivedirectoryb2c",
  :uid => "123456abcdef",
  :info => {
    :name => "John Smith",
    :email => "jsmith@contoso.net",
    :first_name => "John",
    :last_name => "Smith"
  },
  :credentials => {
    :token => "ffdsjap9fdjw893-rt2wj8r9r32jnkdsflaofdsa9"
  },
  :extra => {
    :raw_info => {
      :code => "fjeri9wqrfe98r23.fdsaf121435rt.f42qfdsaf",
      :id_token_claims => {
        "aud" => "fdsafdsa-fdsafd-fdsa-sfdasfds",
        "iss" => "https://sts.windows.net/fdsafdsa-fdsafdsa/",
        "iat" => 53315113,
        "nbf" => 53143215,
        "exp" => 53425123,
        "ver" => "1.0",
        "tid" => "5ffdsa2f-dsafds-sda-sds",
        "oid" => "fdsafdsaafdsa",
        "upn" => "jsmith@contoso.com",
        "sub" => "123456abcdef",
        "nonce" => "fdsaf342rfdsafdsafsads"
      },
      :id_token_header => {
        "typ" => "JWT",
        "alg" => "RS256",
        "x5t" => "fdsafdsafdsafdsa4t4er32",
        "kid" => "tjiofpjd8ap9fgdsa44"
      }
    }
  }
```

## License

Copyright (c) Microsoft Corporation. Licensed under the MIT License.