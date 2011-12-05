ApiClient
=========

ApiClient is an experimental builder for HTTP API clients. The goal is to provide a easy to use engine for constructing queries and map the responses to instances of Hashie::Mash subclasses.

Basically you should be able to build a client for any HTTP based API, without the need for handling connections, parsing responses or instantiating objects. All you need to do is choose where the request should go and enhance your client classes. See the examples dir for usage examples.

Current state is alpha - it works, but the query interface is not final and is subject to change at any time. Hell, even the can even change without prior notice. You were warned.

Copyright
---------

Copyright (c) 2011 Marcin Bunsch, See LICENSE for details.
