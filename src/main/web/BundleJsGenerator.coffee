<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr2/n -->
BundleJsGenerator = (cb) ->
  bg = {}

  priv = {}
  
  priv.resolveNodes = (nodes, cb) ->
    session = nodes[0].getSession()

    params = [].concat(nodes)
    
    # on Success
    params.push () ->
      res = []
      for node in arguments
        res.push node.uri()
      
      cb null, res
    
    
    # onFailure
    params.push cb
    
    session.getAll(params)
  
  priv.removeDuplicates = (ar) ->
    if ar.length == 0
      return []
    res = {}
    res[ar[key]] = ar[key] for key in [0..ar.length-1]
    value for key, value of res
  
  priv.createLinksArray = (nodeLinks) ->
    
    uniqueNodeLinks = priv.removeDuplicates nodeLinks
    
    js = "["
    
    for link in uniqueNodeLinks
      js += 'session.link("'+link+'"),'
    
    js += "]"
    
    js
    
 
  bg.generate = (bundle, cb) ->
    
    ops = []
    
    ops.push (cb) -> priv.resolveNodes bundle.nodes, cb
    
    async.parallel ops, (ex, res) ->
      
      if (ex)
        cb(ex)
        return
      
      nodes = res[0]
      
      js = ""
      js += "var Bundle = function(cb) {\n"
      js += "  var b = {};\n"
      js += "  b.preload = function(session, cb) {\n"
      js += "     var params = "+priv.createLinksArray(nodes)+";\n"
      js += "     params.push(function() {\n"
      js += "       cb(null, arguments);\n"
      js += "     });\n"
      js += "     params.push(cb);\n" # onFailure
      js += "     session.getAll(params);\n"
      js += "  };\n"
      js += "  cb(null, b)\n"
      js += "};\n"
      js += "Bundle;\n"
      
      cb null, js

  cb null, bg
  
BundleJsGenerator<!-- one.end -->
