ApiClient [![Build Status](https://travis-ci.org/futuresimple/api_client.svg?branch=master)](https://travis-ci.org/futuresimple/api_client)
=========

ApiClient is an experimental builder for HTTP API clients. The goal is to provide a easy to use engine for constructing queries and map the responses to instances of Hashie::Mash subclasses.

Basically you should be able to build a client for any HTTP based API, without the need for handling connections, parsing responses or instantiating objects. All you need to do is choose where the request should go and enhance your client classes. See the examples dir for usage examples.

Current state is alpha - it works, but the query interface is not final and is subject to change at any time. Hell, even the can even change without prior notice. You were warned.

## How API Client works

ApiClient gives you two classes that you can inherit from:

* ApiClient::Base

  This class gives you the most basic access. It is a Hashie::Mash
  subclass. On the class level, it exposes a variety of request
  methods (like get, post, put, delete)

* ApiClient::Resource::Base

  This class extends ApiClient::Base giving it ActiveRecord-like class methods
  (find, find_all, create, update, destroy) as well as instance methods
  (save, destroy).

## Making requests

By design, all request methods are singleton methods. They either return Ruby
objects or objects of the class they are called on.

### `ApiClient::Base.get(path, params = {})`

Make a GET request to a specified path. You can pass params as the second
argument. It will parse the representation and return a Ruby object.

#### Example

```ruby
ApiClient::Base.get('/apples/1.json')
# => returns a parsed Hash
```

### `ApiClient::Base.post(path, params = {})`

Make a POST request to a specified path. You can pass params as the second
argument. It will parse the representation and return a Ruby object.

#### Example

```ruby
ApiClient::Base.post('/apples/1.json', :name => 'Lobo')
# => returns a parsed Hash
```

### `ApiClient::Base.put(path, params = {})`

Make a PUT request to a specified path. You can pass params as the second
argument. It will parse the representation and return a Ruby object.

#### Example

```ruby
ApiClient::Base.put('/apples/1.json', :name => 'Lobo')
# => returns a parsed Hash
```

### `ApiClient::Base.delete(path, params = {})`

Make a DELETE request to a specified path. You can pass params as the second
argument. It will parse the representation and return a Ruby object.

#### Example

```ruby
ApiClient::Base.delete('/apples/1.json')
# => returns a parsed Hash
```

### `ApiClient::Base.fetch(path, params = {})`

Make a GET request to a specified path. You can pass params as the second
argument. It will parse the representation, pass it to the build method and
return and object of the class it was called on.

#### Example

```ruby
ApiClient::Base.fetch('/apples/1.json')
# => returns a ApiClient::Base object

class Apple < ApiClient::Base
end

Apple.fetch('/apples/1.json')
# => returns an Apple object
```

## Scoping and Chaining

ApiClient allows you to apply scoping to your request using 3 methods:

* ApiClient::Base.params(pars = {})

  This method allows you to add parameters to a request. If the request is a
  GET request, it will be added in the query. Otherwise, it will be sent in
  the request body.

  It returns a ApiClient::Scope object attached to a class you started with.

* ApiClient::Base.options(opts = {})

  Allows passing options to the connection object behind the ApiClient. Useful
  when working with OAuth for passing the token.

  It returns a ApiClient::Scope object attached to a class you started with.

* ApiClient::Base.headers(heads = {})

  Allows setting headers in the request. Useful when you need to add a token
  as the header

  It returns a ApiClient::Scope object attached to a class you started with.

* ApiClient::Base.raw_body(body = nil)

  Allows setting non-hash body in the request. Useful for binary payloads.
  Notice: it overrides all parameters set via params method!

  It returns a ApiClient::Scope object attached to a class you started with.

All of these methods return a ApiClient::Scope object. When you call any request
methods on this object (get, post, put, delete), the request will apply the
options, params and headers.

### Examples

#### Params, headers and a GET request

```ruby
ApiClient::Base.
  params({ :page => 1 }).
  headers('Auth-Token', 'mytoken').
  get('/stuff.json') # => returns a parsed Array object
```

## Logging

To log requests set the `ApiClient.logger`. To log request payloads and headers set level to `Logger::DEBUG`

```ruby
require 'logger'
ApiClient.logger = Logger.new('api_client.log')
ApiClient.logger.level = Logger::INFO

```

Copyright
---------

Copyright (c) 2011 Marcin Bunsch, See LICENSE for details.
