<!-- one.download http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr1/n -->
BundleCompiler_Module = (cb) ->
  cmp = {}
  
  c = {}
 
  c.importedNodes =
    "https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/importedNodes"
  c.importedNode =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/13/n1"
  c.nodeAddress =
    "http://slicnet.com/mxrogm/mxrogm/data/stream/2013/12/13/n3"
  
  cmp.compile = (node, b, bundleCompiler, cb) ->
    for k,v of c
      c[k] = node.getSession().link v
    
    b.nodes.push(node)
    
    b.nodes.push(node.select("./compilation"))
    
    qry = node.select(c.importedNodes)
              .selectAll(c.importedNode)
              .select(c.nodeAddress)
    
    qry.catchExceptions cb
    
    qry.get (nodelist) ->
      
      ops = []
      
      if nodelist.size() == 0
        cb null, b
        return
      
      # The original bundle
      ops.push (cb) -> cb null, b
      # console.log 'found imported '+nodelist.nodes()
      for importedNode in nodelist.nodes()
        do (importedNode) ->
          ops.push (cb) ->
            
            
            bundleCompiler.compile node.session().link(importedNode.value()),
              (ex, b) ->
                if ex
                  cb ex
                  return
                b.nodes.push importedNode
                cb null, b
                
              
      
      async.parallel ops, (ex, res) ->
        # console.log 'found '+res
        cb null, bundleCompiler.utils.mergeBundles res
      
  
  cb null, cmp
  
BundleCompiler_Module<!-- one.end -->
