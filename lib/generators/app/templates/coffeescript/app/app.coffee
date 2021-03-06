BaseApp = require("rendr/shared/app")
handlebarsHelpers = require("./lib/handlebarsHelpers")

###
Extend the `BaseApp` class, adding any custom methods or overrides.
###
module.exports = BaseApp.extend(
  
  ###
  Client and server.
  
  `postInitialize` is called on app initialize, both on the client and server.
  On the server, an app is instantiated once for each request, and in the
  client, it's instantiated once on page load.
  
  This is a good place to initialize any code that needs to be available to
  app on both client and server.
  ###
  postInitialize: ->
    
    ###
    Register our Handlebars helpers.
    
    `this.templateAdapter` is, by default, the `rendr-handlebars` module.
    It has a `registerHelpers` method, which allows us to register helper
    modules that can be used on both client & server.
    ###
    @templateAdapter.registerHelpers handlebarsHelpers

  
  ###
  Client-side only.
  
  `start` is called at the bottom of `__layout.hbs`. Calling this kicks off
  the router and initializes the application.
  
  Override this method (remembering to call the superclass' `start` method!)
  in order to do things like bind events to the router, as shown below.
  ###
  start: ->
    
    # Show a loading indicator when the app is fetching.
    @router.on "action:start", (->
      @set loading: true
    ), this
    @router.on "action:end", (->
      @set loading: false
    ), this
    
    # Call 'super'.
    BaseApp::start.call this
)
