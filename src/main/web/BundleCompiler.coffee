<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n -->
BundleCompiler = (cb) ->
  bc = {}
  
  c = {}
  c.aBundle = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/6/sr/n"
  c.aModule = "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/module"
  c.moduleCompiler =
    "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr1/n/7"
  c.jsGenerator = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r"+
    "/2014/10/3/sr/n/r/2014/10/3/sr2/n/7"
  
  c.aScript =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/node_ge7"
  c.aType =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/11/n5"
  
  c.simpleDependencies = [
    c.aScript,
    c.aType
  ]
  
  
  priv = {}
  
  priv.createBundle = ->
    {
      libraries: []
      nodes: []
      stylesheets: []
      scripts: []
    }
  
  priv.compileBundle = (bundleNode, cb) ->
    bundle = priv.createBundle()
    
    ops = []
    
    ops.push (cb) -> priv.compileModules bundleNode, cb
    ops.push (cb) -> priv.compileBundles bundleNode, cb
    ops.push (cb) -> priv.compileSimpleDependencies bundleNode, cb
    
    async.parallel ops, (ex, res) ->
      cb null, priv.mergeBundles res
  
  priv.compileModule = (moduleNode, cb) ->
    Appjangle.require c.moduleCompiler,
      (ex, CMP) ->
        if (ex)
          cb(ex)
          return

        CMP.compile moduleNode, priv.createBundle(), bc, cb
  
  priv.compileModules = (bundleNode, cb) ->
    
    qry = bundleNode.selectAll(bundleNode.getSession().link(c.aModule))
    
    qry.catchExceptions(cb)
    
    qry.get (modules) ->
      ops = []

      for module in modules.nodes()
        do (module) -> ops.push (cb) -> priv.compileModule module, cb
      
      async.parallel ops, (ex, res) ->
        if (ex)
          cb ex
          return
        
        cb null, priv.mergeBundles res
      
  
  priv.compileBundles = (bundleNode, cb) ->
    
    qry = bundleNode.selectAll(c.aBundle)
    
    qry.catchExceptions(cb)
    
    qry.get (bundles) ->
      if (bundles.size() == 0)
        cb null, priv.createBundle()
        return

      ops = []
      for bundle in bundles.nodes()
        do (bundle) -> ops.push (cb) -> priv.compileBundle(bundle, cb)
      
      async.parallel ops, (ex, res) ->
        cb null, priv.mergeBundles res
  
  
  priv.compileSimpleDependencies = (bundleNode, cb) ->
    b = priv.createBundle()
    
    ops = []
    
    for uri in c.simpleDependencies
      do (uri) -> ops.push (cb) ->
        type = bundleNode.getSession().link(uri)
      
        qry = bundleNode.selectAll(type)
        qry.catchUndefined -> cb null, null
        qry.get (nodelist) -> cb null, nodelist.nodes()
    
    
    async.parallel ops, (ex, res) ->
      for nodes in res
        b.nodes = b.nodes.concat nodes
      
      cb null, b
  
  priv.mergeBundles = (bundles) ->
    mergedBundle = priv.createBundle()
    for argument in bundles
      if (argument == null)
        continue
      mergedBundle.libraries = mergedBundle.libraries.concat(argument.libraries)
      mergedBundle.nodes = mergedBundle.nodes.concat(argument.nodes)
      mergedBundle.stylesheets =
        mergedBundle.stylesheets.concat(argument.stylesheets)
 
    mergedBundle
  
  bc.compile = (bundleNode, cb) ->
    # console.log 'compile '+bundleNode
    priv.compileBundle bundleNode, cb
  
  bc.utils = {}
  
  bc.utils.mergeBundles = priv.mergeBundles
  
  cb null, bc
BundleCompiler<!-- one.end -->
