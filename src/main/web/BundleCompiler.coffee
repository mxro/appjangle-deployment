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
  
  c.simpleDependencies = [
    c.aScript
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
          
        CMP.compile moduleNode, priv.createBundle(), cb
  
  priv.compileModules = (bundleNode, cb) ->
    
    qry = bundleNode.selectAll(c.aModule)
    
    qry.catchExceptions(cb)
    
    qry.get (modules) ->
      ops = []
      for module in modules
        ops.push (cb) -> priv.compileModule module, cb
      
      async.parallel ops, (ex, res) ->
        if (ex)
          cb ex
          return
        console.log 'found modules bundles '
        console.log res
        cb null, priv.mergeBundles res
      
  
  priv.compileBundles = (bundleNode, cb) ->
    
    qry = bundleNode.selectAll(c.aBundle)
    
    qry.catchExceptions(cb)
    
    qry.get (bundles) ->
      ops = []
      for bundle in bundles
        ops.push (cb) -> priv.compileBundle(bundle, cb)
      
      async.parallel ops, (ex, res) ->
        cb null, priv.mergeBundles res
  
  
  priv.compileSimpleDependencies = (bundleNode, cb) ->
    b = priv.createBundle()
    
    for uri in c.simpleDependencies
      type = bundleNode.getSession().link(uri)
      b.nodes.push bundleNode.select(type)
      
    cb null, b
  
  priv.mergeBundles = (bundles) ->
    mergedBundle = priv.createBundle()
    for argument in bundles
      mergedBundle.libraries = mergedBundle.libraries.concat(argument.libraries)
      mergedBundle.nodes = mergedBundle.nodes.concat(argument.nodes)
      mergedBundle.stylesheets =
        mergedBundle.stylesheets.concat(argument.stylesheets)
 
    mergedBundle
  
  bc.compile = (bundleNode, cb) ->
    
    priv.compileBundle bundleNode, cb
  
  bc.generateJs = (bundle, cb) ->
    Appjangle.require c.jsGenerator, (ex, JSGEN) ->
      JSGEN.generateJs bundle, (ex, js) ->
        cb(ex, js)
    
  
  cb null, bc
BundleCompiler<!-- one.end -->
