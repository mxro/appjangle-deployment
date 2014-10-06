<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr3/n -->c = {}

c.bundleLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr/n/7"

c.coffeeScriptModule =
  "http://slicnet.com/mxrogm/mxrogm/data/stream/"+
                     "2014/1/10/n2"

test "Engine available", ->
  session = Nextweb.createSession()
  ok session != null, "Session is available"
  session.close().get()

test "Can compile", ->
  stop()

  Appjangle.require c.bundleLib,
    (ex, BundleCompiler) ->
      if (ex)
        ok false, "Encountered exception: "+ex.exception
        return
      
      server = AppjangleJs.startServer()
      session = Nextweb.createSession()
      
      bundle = session.seed(server)
      bundle.append(
        session.link(c.coffeeScriptModule))
      
      session.commit().get ->
        BundleCompiler.compiler bundle, (ex, res) ->
          if (ex)
            ok false, ""
            
          console.log res
      
      
      start()<!-- one.end -->
