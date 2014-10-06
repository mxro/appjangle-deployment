<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr2/n -->
BundleJsGenerator = (cb) ->
  bg = {}
  
  priv = {}
  
  priv.resolveNodes (nodes, cb) ->
    console.log 'try'
    session = nodes[0].getSession()

    params = [].concat(nodes)

    # onFailure
    params.push cb
    
    # on Success
    params.push () ->
      console.log 'resolved'
      res = []
      for node in arguments
        res.push node.uri()
      
      cb null, res
      
    session.getAll(params)
  
  priv.createLinksArray = (nodeLinks) ->
    
    js = "["
    
    for link in nodeLinks
      js += 'session.link("'+link+'"),'
    
    js += "]"
    
    js
    
  
  bg.generate = (bundle, cb) ->
    
    ops = []
    
    ops.push (cb) -> priv.resolveNodes bundle.nodes, cb
    
    aysnc.parallel ops, (ex, res) ->
      if (ex)
        cb(ex)
        return
      
      nodes = res[0]
      
      js = ""
      js += "var Bundle = function(cb) {"
      js += "  var b = {};"
      js += "  b.preload = function(session, cb) {"
      js += "     var params = "+priv.createLinksArray(nodes)+";"
      js += "     params.push(cb);" # onFailure
      js += "     params.push(function() {"
      js += "       cb(null, arguments);"
      js += "     };"
      js += "     session.getAll(params);"
      js += "  }"
      js += "  cb(null, b);"
      js += "};"
      js += "Bundle;"
    
      cb null, js

  cb null, bg
  
BundleJsGenerator<!-- one.end -->
