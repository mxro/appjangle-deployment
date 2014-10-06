<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr3/n -->if window.localStorage
  window.localStorage.clear()

c = {}

c.bundleLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr/n/7"

c.genLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr1/n/7"
  
c.coffeeScriptModule =
  "http://slicnet.com/mxrogm/mxrogm/data/stream/"+
                     "2014/1/10/n2"

    
    
c.aModule = "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/module"
    
test "Engine available", ->
  session = Nextweb.createSession()
  ok session != null, "Session is available"
  session.close().get()

test "Can compile", ->
  stop()

  Appjangle.require c.bundleLib,
    c.genLib
    (ex, BundleCompiler, JsGen) ->
      if (ex)
        ok false, "Encountered exception when loading bundle: "+ex.exception
        return
      
      server = AppjangleJs.startServer()
      session = Nextweb.createSession()
      
      bundle = session.seed(server)
      bundle.append(
        session.link(c.coffeeScriptModule))
      
      session.commit().get ->
        
        bundle.selectAll(session.link(c.aModule)).get (nodes) ->
          console.log nodes.uris()
        
        BundleCompiler.compile bundle, (ex, res) ->
          if (ex)
            ok false, "Exception while compiling: "+ex.exception
            return

          ok true, "Compilation successful."
          
          ok nodes.nodes.length > 2, "Found sufficient nodes: "+
            node.nodes.lenghth
          
          JsGen.generate res, (ex, js) ->
            if (ex)
              ok false, "Exception durin"
            
          
          start()
      
      
      <!-- one.end -->
