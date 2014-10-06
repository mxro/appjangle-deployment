var Bundle = function(cb) {  
	var b = {};  b.preload = function(session, cb) {     
		var params = [session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2"),session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/compilation"),session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/Unnamed2"),session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/Unnamed15"),session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2/Unnamed15/node_se4"),session.link("http://slicnet.com/mxrogm/mxrogm/data/stream/2014/1/10/n2"),];
		params.push(cb);
		params.push(function() {
			cb(null, arguments);
			};     
			session.getAll(params);  
			}
	cb(null, b);
	};
	Bundle; 