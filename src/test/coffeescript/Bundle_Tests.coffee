<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr3/n -->c = {}

c.bundleLib = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr/n/7"


test "Engine available", ->
  session = Nextweb.createSession()
  ok session != null, "session should be available"
  session.close().get()

test "Can compile", ->
  stop()

  Appjangle.require c.bundleLib,
    (ex, BundleCompiler) ->
      if (ex)
        ok false, ""
      ok true
      start()<!-- one.end -->
