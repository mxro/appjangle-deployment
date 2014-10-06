<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr3/n -->if window.localStorage
  window.localStorage.clear()

notest = 

test "Engine available", ->
  session = AppjangleJs.createSession()
  ok session != null, "Session is available"
  session.close().get()

testTemplate = (uris) ->
  stop()
  
  c = {}

  c.bundleLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr/n/7"

  c.genLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr2/n/7"
    
  c.aModule = "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/module"
  
  Appjangle.require c.bundleLib,
    (ex, BundleCompiler) ->
      if (ex)
        ok false, "Encountered exception when loading bundle: "+ex.exception
        return
      
      server = AppjangleJs.startServer()
      session = Nextweb.createSession()
      
      bundle = session.seed(server)
      for uri in uris
        bundle.append session.link uri
      
      session.commit().get ->
        
        BundleCompiler.compile bundle, (ex, res) ->
          if (ex)
            ok false, "Exception while compiling: "+ex.exception
            return

          ok true, "Compilation of nodes "+ uris+"successful."
          
          ok res.nodes.length > 2, "Found sufficient nodes: "+
            res.nodes.length
          
          Appjangle.require c.genLib, (ex, JsGen) ->
            ok true, "Generator loaded"
            JsGen.generate res, (ex, js) ->
              
              if (ex)
                ok false, "Exception during JS generation. "+ex+
                  " "+ex.exception
                return
            
              ok true, "Generation successful."
              Bundle = eval(js)
              
              ok true, "Evaluated sucessfully."
              
              Bundle((ex, b) ->

                b.preload session, (ex, nodes) ->
                  ok true, "Preload successful. Loaded: "+nodes.length
            
                  session.close().get()
                  start())
  
test "Compile Bundle for CoffeeScript editor module", ->
  coffeeScriptModule =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/"+
                     "2014/1/10/n2"
  testTemplate [coffeeScriptModule]
      
test "Compile Bundle for Stream editor, Factory and Tools", ->
  streamEditor = "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/9/n5"
  factory = "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/9/n6"
  tools = "http://slicnet.com/mxrogm/mxrogm/data/stream/2014/3/21/n1"
  
  testTemplate [streamEditor,
               factory,
               tools]
      <!-- one.end -->
