<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr1/n -->BundleCompiler_Module = (cb) ->
  cmp = {}
  
  c = {}
  
  c.label = "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/label"
  c.moduleFactory =
    "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/modulefactory"
  c.creationScript =
    "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/creationscript"
  
  cmp.compile = (node, b, cb) ->
    for k,v of c
      c[k] = node.session().link v
    
    b.nodes.push(node)
    
    b.nodes.push(node.select("./compilation"))
    
    b.nodes.push(node.select(c.label))
  
    moduleFactory = node.select(c.moduleFactory)
    
    b.nodes.push(moduleFactory)
    
    b.nodes.push(moduleFactory.select(c.creationScript))
    
    cb null, b
  
  cb null, cmp
  
BundleCompiler_Module<!-- one.end -->
