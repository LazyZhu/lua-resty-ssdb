local say = ngx.say
local cjson = require "cjson"
local ssdb = require "resty.ssdb"
local db = ssdb:new()

local ok, err = db:set_timeout(5000)

local ok, err = db:connect("127.0.0.1", 8888)
if not ok then
    say("failed to connect: ", err)
    return
end





local ok, err = db:hexists("public")
if not ok then
    say("failed to hexists: ", err)
    return
end
say("hexists requests: key=public, result: ", ok, "<br>")



local res, err = db:hget("public", "name")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=public&field=name, result: ", res, "<br>")



local ok, err = db:hset("public", "name", "none")
if not ok then
    say("failed to hset: ", err)
    return
end
say("hset requests: key=public&field=name&value=none, result: ", ok, "<br>")



local res, err = db:hget("public", "name")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=public&field=name, result: ", res, "<br>")



local ok, err = db:hset("public", "name", "LazyZhu")
if not ok then
    say("failed to hset: ", err)
    return
end
say("hset requests: key=public&field=name&value=LazyZhu, result: ", ok, "<br>")



local ok, err = db:hexists("public")
if not ok then
    say("failed to hexists: ", err)
    return
end
say("hexists requests: key=public, result: ", ok, "<br>")



local res, err = db:hget("public", "name")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=public&field=name, result: ", res, "<br>")



local ok, err = db:hdel("public", "name")
if not ok then
    say("failed to hdel: ", err)
    return
end
say("hdel requests: key=public&field=name, result: ", ok, "<br>")



local ok, err = db:hexists("public")
if not ok then
    say("failed to hexists: ", err)
    return
end
say("hexists requests: key=public, result: ", ok, "<br>")



local res, err = db:hget("public", "name")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=public&field=name, result: ", res, "<br>")



local ok, err = db:hdel("public", "name")
if not ok then
    say("failed to hdel: ", err)
    return
end
say("hdel requests: key=public&field=name, result: ", ok, "<br><br>")





local ok, err = db:hset("personal", "age", "18")
if not ok then
    say("failed to hset: ", err)
    return
end
say("hset requests: key=personal&field=age&value=18, result: ", ok, "<br>")



local res, err = db:hget("personal", "age")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=personal&field=age, result: ", res, "<br>")



local ok, err = db:hincr("personal", "age", "2")
if not ok then
    say("failed to hincr: ", err)
    return
end
say("hincr requests: key=personal&field=age&value=2, result: ", ok, "<br>")



local res, err = db:hget("personal", "age")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=personal&field=age, result: ", res, "<br>")



local ok, err = db:hincr("personal", "age", "-2")
if not ok then
    say("failed to hincr: ", err)
    return
end
say("hincr requests: key=personal&field=age&value=-2, result: ", ok, "<br>")



local res, err = db:hget("personal", "age")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=personal&field=age, result: ", res, "<br>")



local ok, err = db:hdecr("personal", "age", "2")
if not ok then
    say("failed to hdecr: ", err)
    return
end
say("hdecr requests: key=personal&field=age&value=2, result: ", ok, "<br>")



local res, err = db:hget("personal", "age")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=personal&field=age, result: ", res, "<br>")



local ok, err = db:hdecr("personal", "age", "-2")
if not ok then
    say("failed to hdecr: ", err)
    return
end
say("hdecr requests: key=personal&field=age&value=-2, result: ", ok, "<br>")



local res, err = db:hget("personal", "age")
if not res then
    say("failed to hget: ", err)
    return
end
if res == ngx.null then
    say("hget not found.")
    return
end
say("hget requests: key=personal&field=age, result: ", res, "<br>")



local ok, err = db:hdel("personal", "age")
if not ok then
    say("failed to hdel: ", err)
    return
end
say("hdel requests: key=personal&field=age, result: ", ok, "<br>")



local ok, err = db:hexists("personal")
if not ok then
    say("failed to hexists: ", err)
    return
end
say("hexists requests: key=personal, result: ", ok, "<br><br>")





local ok, err = db:multi_hset("public", "name", "LazyZhu", "domain", "lazyzhu.com", "email", "admin@lazyzhu.com")
if not ok then
    say("failed to multi_hset: ", err)
    return
end
say("multi_hset requests: key=public&field=name&value=LazyZhu, key=public&field=domain&value=lazyzhu.com, key=public&field=email&value=admin@lazyzhu.com, result: ", ok, "<br>")



local res, err = db:multi_hexists("public", "personal")
if not res then
    say("failed to multi_hexists: ", err)
    return
end
if res == ngx.null then
    say("multi_hexists not found.")
    return
end
say("multi_hexists requests: key=public, key=personal, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_hget("public", "name", "domain", "email")
if not res then
    say("failed to multi_hget: ", err)
    return
end
if res == ngx.null then
    say("multi_hget not found.")
    return
end
say("multi_hget requests: key=public&field=name, key=public&field=domain, key=public&field=email, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")



local res, err = db:hscan("public", "", "", "5")
if not res then
    say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    say("hscan not found.")
    return
end
say("hscan requests: key=public&rule=public:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hrscan("public", "", "", "5")
if not res then
    say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    say("hrscan not found.")
    return
end
say("hrscan requests: key=public&rule=blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hscan("public", "", "", "2")
if not res then
    say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    say("hscan not found.")
    return
end
say("hscan requests: key=public&rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hrscan("public", "", "", "2")
if not res then
    say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    say("hrscan not found.")
    return
end
say("hrscan requests: key=public&rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hscan("public", "d", "n", "5")
if not res then
    say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    say("hscan not found.")
    return
end
say("hscan requests: key=public&rule=d:n:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hscan("public", "d", "o", "5")
if not res then
    say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    say("hscan not found.")
    return
end
say("hscan requests: key=public&rule=d:o:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hrscan("public", "n", "d", "5")
if not res then
    say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    say("hrscan not found.")
    return
end
say("hrscan requests: key=public&rule=n:d:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hrscan("public", "o", "d", "5")
if not res then
    say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    say("hrscan not found.")
    return
end
say("hrscan requests: key=public&rule=o:d:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")



local res, err = db:hkeys("public", "", "", "5")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=public&rule=blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hkeys("public", "", "", "2")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=public&rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hkeys("public", "d", "n", "5")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=public&rule=d:n:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hkeys("public", "d", "o", "5")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=public&rule=d:o:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hkeys("public", "n", "d", "5")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=public&rule=n:d:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local ok, err = db:hsize("public")
if not ok then
    say("failed to hsize: ", err)
    return
end
say("hsize requests: key=public, result: ", ok, "<br>")



local res, err = db:multi_hsize("public", "personal")
if not res then
    say("failed to multi_hsize: ", err)
    return
end
if res == ngx.null then
    say("multi_hsize not found.")
    return
end
say("multi_hsize requests: key=public, key=personal, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local res, err = db:hlist("", "", "3")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=blank:blank:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hlist("", "", "1")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=blank:blank:1, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hlist("p", "p", "3")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=p:p:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hlist("p", "q", "3")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=p:q:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:hlist("q", "p", "3")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=q:p:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local res, err = db:multi_hdel("public", "name", "domain", "email")
if not res then
    say("failed to multi_hdel: ", err)
    return
end
if res == ngx.null then
    say("multi_hdel not found.")
    return
end
say("multi_hdel requests: key=public&field=name, key=public&field=domain, key=public&field=email, result: ", res, "<br>")



local res, err = db:multi_hexists("public", "personal")
if not res then
    say("failed to multi_hexists: ", err)
    return
end
if res == ngx.null then
    say("multi_hexists not found.")
    return
end
say("multi_hexists requests: key=public, key=personal, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_hget("public", "name", "domain", "email")
if not res then
    say("failed to multi_hget: ", err)
    return
end
if res == ngx.null then
    say("multi_hget not found.")
    return
end
say("multi_hget requests: key=public&field=name, key=public&field=domain, key=public&field=email, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local ok, err = db:close()
