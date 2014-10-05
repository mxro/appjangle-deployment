S[1653,11,1966616114,28,9,-84,8,27,5,9,24,5,8,7,26,25,24,23,4,1,11,350521803,22,9,-74,8,0,9,21,5,8,7,21,20,0,19,18,17,4,0,1,3,-15,62378071,10,9,-62,8,0,9,16,5,8,7,16,5,4,0,1,3,-15,62378071,10,9,-52,8,0,9,15,5,8,7,15,5,4,0,1,3,-15,62378071,10,9,-42,8,0,9,14,5,8,7,14,5,4,0,1,3,-15,62378071,10,9,-32,8,0,9,13,5,8,7,13,5,4,0,1,3,-15,62378071,10,9,-22,8,0,9,12,5,8,7,12,5,4,0,1,3,0,11,62378071,10,9,-11,8,0,9,6,5,8,7,6,5,4,0,1,3,7,1,3,0,0,0,1,1,0,2,1,1,["java.util.ArrayList/4159755760","nx.remote.messages.v01.ResolveResponseData/3688946373","nx.core.utils.lighttree.ValueNode/79679139","nx.sync.nodes.v01.VersionedNode/3054760367","nx.core.nodes.v01.ReferenceData/4285455160","https://u1.linnk.it/qc8sbw/usr/apps/textsync/upload/java-script-document","nx.versions.nodes.v01.ChainedVersionData/1222517587","nx.persistence.statements.v01.ManagedLeaveUnchangedStatement/2688303772","nx.core.statements.v01.LeaveUnchangedStatement/877799804","undefinedversion","java.lang.Integer/3438268394","https://u1.linnk.it/6wbnoq/Types/aTextValue","https://u1.linnk.it/6wbnoq/Types/aTemplate","http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/7/https__4","http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/Unnamed5","http://slicnet.com/mxrogm/mxrogm/data/stream/2013/10/22/n2","nx.core.decorators.v01.TemporaryAddressableDecorator/2072283157","one.engine.nx.nodes.v01.OneTokenWithoutSecretData/3091762580","nx.auth.v01.Token$Authorization/3469765733","<unidentified>","http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/7/Token_auth6","http://www.linnk.de/s/initialversion","one.engine.nx.nodes.v01.OneValueData/1719875798","http://slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/7","java.lang.String/2004016611","var BundleCompiler;

BundleCompiler = function(cb) {
  var bc, c, priv;
  bc = {};
  c = {};
  c.aBundle = "";
  c.aModule = "";
  c.moduleCompiler = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r" + "/2014/10/3/sr/n/r/2014/10/3/sr1/n/7";
  c.jsGenerator = "http://slicnet.com/mxrogm/mxrogm/apps/stream/r" + "/2014/10/3/sr/n/r/2014/10/3/sr2/n/7";
  c.aScript = "http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/node_ge7";
  c.simpleDependencies = [c.aScript];
  priv = {};
  priv.createBundle = function() {
    return {
      libraries: [],
      nodes: [],
      stylesheets: [],
      scripts: []
    };
  };
  priv.compileBundle = function(bundleNode, cb) {
    var bundle, ops;
    bundle = priv.createBundle();
    ops = [];
    ops.push(function(cb) {
      return priv.compileModules(bundleNode, cb);
    });
    ops.push(function(cb) {
      return priv.compileBundles(bundleNode, cb);
    });
    ops.push(function(cb) {
      return priv.compileSimpleDependencies(bundleNode, cb);
    });
    return async.parallel(ops, function(ex, res) {
      return cb(null, priv.mergeBundles(res));
    });
  };
  priv.compileModule = function(moduleNode, cb) {
    return Appjangle.require(c.moduleCompiler, function(ex, CMP) {
      if (ex) {
        cb(ex);
        return;
      }
      return CMP.compile(moduleNode, priv.createBundle(), cb);
    });
  };
  priv.compileModules = function(bundleNode, cb) {
    var qry;
    qry = bundleNode.selectAll(c.aModule);
    qry.catchExceptions(cb);
    return qry.get(function(modules) {
      var module, ops, _i, _len;
      ops = [];
      for (_i = 0, _len = modules.length; _i < _len; _i++) {
        module = modules[_i];
        ops.push(function(cb) {
          return priv.compileModule(module, cb);
        });
      }
      return async.parallel(ops, function(ex, res) {
        return cb(null, priv.mergeModules(res));
      });
    });
  };
  priv.compileBundles = function(bundleNode, cb) {
    var qry;
    qry = bundleNode.selectAll(c.aBundle);
    qry.catchExceptions(cb);
    return qry.get(function(bundles) {
      var bundle, ops, _i, _len;
      ops = [];
      for (_i = 0, _len = bundles.length; _i < _len; _i++) {
        bundle = bundles[_i];
        ops.push(function(cb) {
          return priv.compileBundle(bundle, cb);
        });
      }
      return async.parallel(ops, function(ex, res) {
        return cb(null, priv.mergeBundles(res));
      });
    });
  };
  priv.compileSimpleDependencies = function(bundleNode, cb) {
    var b, type, uri, _i, _len;
    b = priv.createBundle();
    for (_i = 0, _len = simpleDependencies.length; _i < _len; _i++) {
      uri = simpleDependencies[_i];
      type = bundleNode.session().link(uri);
      b.nodes.push(bundleNode.select(type));
    }
    return cb(null, b);
  };
  priv.mergeBundles = function(bundles) {
    var argument, mergedBundle, _i, _len;
    mergedBundle = createBundle();
    for (_i = 0, _len = bundles.length; _i < _len; _i++) {
      argument = bundles[_i];
      mergedBundle.libraries = mergedBundle.libraries.concat(argument.libraries);
      mergedBundle.nodes = mergedBundle.nodes.concat(argument.nodes);
      mergedBundle.stylesheets = mergedBundle.stylesheets.contact(argument.stylesheets);
    }
    return mergedBundle;
  };
  bc.compile = function(bundleNode, cb) {
    return priv.compileBundle(bundleNode, cb);
  };
  bc.generateJs = function(bundle, cb) {
    return Appjangle.require(c.jsGenerator, function(ex, JSGEN) {
      return JSGEN.generateJs(bundle, function(ex, js) {
        return cb(ex, js);
      });
    });
  };
  return cb(null, bc);
};

BundleCompiler;
","http://v.slicnet.com/http_/slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/_7/1652","http://v.slicnet.com/http_/slicnet.com/mxrogm/mxrogm/apps/stream/r/2014/10/3/sr/n/r/2014/10/3/sr/n/_7/1653"],0,7]"