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





local ok, err = db:zexists("domain")
if not ok then
    say("failed to zexists: ", err)
    return
end
say("zexists requests: key=domain, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zset("domain", "lazyzhu.com", "2013")
if not ok then
    say("failed to zset: ", err)
    return
end
say("zset requests: key=domain&member=lazyzhu.com&score=2013, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zset("domain", "lazyzhu.com", "2016")
if not ok then
    say("failed to zset: ", err)
    return
end
say("zset requests: key=domain&member=lazyzhu.com&score=2016, result: ", ok, "<br>")



local ok, err = db:zexists("domain")
if not ok then
    say("failed to zexists: ", err)
    return
end
say("zexists requests: key=domain, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")





local ok, err = db:zdel("domain", "lazyzhu.com")
if not ok then
    say("failed to zdel: ", err)
    return
end
say("zdel requests: key=domain&member=lazyzhu.com, result: ", ok, "<br>")



local ok, err = db:zexists("domain")
if not ok then
    say("failed to zexists: ", err)
    return
end
say("zexists requests: key=domain, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zdel("domain", "lazyzhu.com")
if not ok then
    say("failed to zdel: ", err)
    return
end
say("zdel requests: key=domain&member=lazyzhu.com, result: ", ok, "<br><br>")





local ok, err = db:zset("domain", "lazyzhu.com", "2016")
if not ok then
    say("failed to zset: ", err)
    return
end
say("zset requests: key=domain&member=lazyzhu.com&score=2016, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zincr("domain", "lazyzhu.com", "-3")
if not ok then
    say("failed to zincr: ", err)
    return
end
say("zincr requests: key=domain&member=lazyzhu.com&score=-3, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zincr("domain", "lazyzhu.com", "3")
if not ok then
    say("failed to zincr: ", err)
    return
end
say("zincr requests: key=domain&member=lazyzhu.com&score=3, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zdecr("domain", "lazyzhu.com", "3")
if not ok then
    say("failed to zdecr: ", err)
    return
end
say("zdecr requests: key=domain&member=lazyzhu.com&score=3, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zdecr("domain", "lazyzhu.com", "-3")
if not ok then
    say("failed to zdecr: ", err)
    return
end
say("zdecr requests: key=domain&member=lazyzhu.com&score=-3, result: ", ok, "<br>")



local res, err = db:zget("domain", "lazyzhu.com")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=domain&member=lazyzhu.com, result: ", res, "<br>")



local ok, err = db:zdel("domain", "lazyzhu.com")
if not ok then
    say("failed to zdel: ", err)
    return
end
say("zdel requests: key=domain&member=lazyzhu.com, result: ", ok, "<br>")



local ok, err = db:zexists("domain")
if not ok then
    say("failed to zexists: ", err)
    return
end
say("zexists requests: key=domain, result: ", ok, "<br><br>")








local ok, err = db:multi_zset("domain", "lazyzhu.com", "2016", "lazyzhu.net", "2013", "github.com", "2018")
if not ok then
    say("failed to multi_zset: ", err)
    return
end
say("multi_zset requests: key=domain&member=lazyzhu.com&score=2016, key=domain&member=lazyzhu.net&score=2013, key=domain&member=github.com&score=2018, result: ", ok, "<br>")



local res, err = db:multi_zexists("domain", "age")
if not res then
    say("failed to multi_zexists: ", err)
    return
end
if res == ngx.null then
    say("multi_zexists not found.")
    return
end
say("multi_zexists requests: key=domain, key=age, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_zget("domain", "lazyzhu.com", "lazyzhu.net", "github.com")
if not res then
    say("failed to multi_zget: ", err)
    return
end
if res == ngx.null then
    say("multi_zget not found.")
    return
end
say("multi_zget requests: key=domain&member=lazyzhu.com, key=domain&member=lazyzhu.net, key=domain&member=github.com, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local res, err = db:zscan("domain", "", "", "", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=blank:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zrscan("domain", "", "", "", "5")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&rule=blank:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "", "", "", "2")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=blank:blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zrscan("domain", "", "", "", "2")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&rule=blank:blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "g", "", "", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=g:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "l", "", "", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=l:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "z", "", "", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=z:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zrscan("domain", "g", "", "", "5")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&rule=g:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zrscan("domain", "l", "", "", "5")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&rule=l:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zrscan("domain", "z", "", "", "5")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&rule=z:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "", "2013", "2018", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=blank:2013:2018:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "", "2013", "2019", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=blank:2013:2019:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zscan("domain", "", "2013", "2019", "2")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&rule=blank:2013:2019:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local res, err = db:zkeys("domain", "", "", "", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=blank:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "", "", "", "2")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=blank:blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "g", "", "", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=g:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "l", "", "", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=l:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "z", "", "", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=z:blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "", "2013", "2018", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=blank:2013:2018:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "", "2013", "2019", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=blank:2013:2019:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zkeys("domain", "", "2013", "2019", "2")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&rule=blank:2013:2019:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local ok, err = db:zsize("domain")
if not ok then
    say("failed to zsize: ", err)
    return
end
say("zsize requests: key=domain, result: ", ok, "<br>")



local res, err = db:multi_zsize("domain", "age")
if not res then
    say("failed to multi_zsize: ", err)
    return
end
if res == ngx.null then
    say("multi_zsize not found.")
    return
end
say("multi_zsize requests: key=domain, key=age, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local res, err = db:zlist("", "", "3")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=blank:blank:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zlist("", "", "1")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=blank:blank:1, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zlist("d", "d", "3")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=d:d:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zlist("d", "e", "3")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=d:e:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:zlist("e", "d", "3")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=e:d:3, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local res, err = db:multi_zdel("domain", "lazyzhu.com", "lazyzhu.net", "github.com")
if not res then
    say("failed to multi_zdel: ", err)
    return
end
if res == ngx.null then
    say("multi_zdel not found.")
    return
end
say("multi_zdel requests: key=domain&member=lazyzhu.com, key=domain&member=lazyzhu.net, key=domain&member=github.com, result: ", res, "<br>")



local res, err = db:multi_zexists("domain", "age")
if not res then
    say("failed to multi_zexists: ", err)
    return
end
if res == ngx.null then
    say("multi_zexists not found.")
    return
end
say("multi_zexists requests: key=domain, key=age, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_zget("domain", "lazyzhu.com", "lazyzhu.net", "github.com")
if not res then
    say("failed to multi_zget: ", err)
    return
end
if res == ngx.null then
    say("multi_zget not found.")
    return
end
say("multi_zget requests: key=domain&member=lazyzhu.com, key=domain&member=lazyzhu.net, key=domain&member=github.com, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local ok, err = db:close()
