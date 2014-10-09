<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr1/n -->
BundleCompiler_Module = (cb) ->
  cmp = {}
  
  c = {}
 
  c.importedNodes =
    "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/importedNodes"
  c.importedNode =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/13/n1"
  
  cmp.compile = (node, b, cb) ->
    for k,v of c
      c[k] = node.getSession().link v
    
    b.nodes.push(node)
    
    b.nodes.push(node.select("./compilation"))
    
    qry = node.select(c.importedNodes).selectAll(c.importedNode)
    
    qry.catchExceptions cb
    
    qry.get (nodelist) ->
      
      for importedNode in nodelist
        b.nodes.push importedNode
    
      cb null, b
  
  cb null, cmp
  
BundleCompiler_Module<!-- one.end -->
