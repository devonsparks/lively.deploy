livelyModules = {}
dots = []

/* collect module dependencies */ 
lively.Module.topologicalSortLoadedModules().forEach(function(e) { 
  if(e.uri) { 
    const uri = e.uri().replace(window.location.origin, '');
    
     livelyModules[uri] = e.privateRequirements ? e.privateRequirements.map(function(req) { 
       return req.uri().replace(window.location.origin, '')}) : [];
    
  }

});


/* populate dot nodes */
$.each(livelyModules, function(k, v) {
  dots.push(`"${k}";`);
  
  v && v.forEach(function(e) {
    dots.push(`"${k}" -> "${e}";`);
  })
});

dots.forEach(function(e) { console.log(e) });
