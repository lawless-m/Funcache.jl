module Cache



if isfile(raw"c:\users\matt\ntuser.ini")
	cachedir = raw"C:\Users\matt\_cache"
else
	cachedir = raw"C:\Users\heathm\Documents\_HOME\_cache"
end

force = isfile("$cachedir\\force.txt")

export cache

function validate_by_mtime!(srcfn, cachefn)
	isfile(cachefn) && isfile(srcfn) && mtime(srcfn) > mtime(cachefn) && rm(cachefn)
	!isfile(cachefn)
end

function cache(fname, fun)
	fn = "$cachedir\\$fname.jls"
	if (!force) && isfile(fn) && filesize(fn) > 0
		println(STDERR, "Cached: ", fn)
		open(deserialize, fn, "r")
	else
		v = fun()
		if !force
			fid = open(fn, "w+")
			serialize(fid, v)
		end
		v
	end
end

end