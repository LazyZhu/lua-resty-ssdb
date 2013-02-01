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


local ok, err = db:set("age", "6")
if not ok then
    say("failed to set: ", err)
    return
end
say("set requests: key=age&value=6, result: ", ok, "<br>")

local ok, err = db:set("age", "8")
if not ok then
    say("failed to set: ", err)
    return
end
say("set requests: key=age&value=8, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:incr("age", "2")
if not ok then
    say("failed to incr: ", err)
    return
end
say("incr requests: key=age&value=2, result: ", ok, "<br>")

local ok, err = db:incr("age", "-2")
if not ok then
    say("failed to incr: ", err)
    return
end
say("incr requests: key=age&value=-2, result: ", ok, "<br>")

local ok, err = db:decr("age", "2")
if not ok then
    say("failed to decr: ", err)
    return
end
say("decr requests: key=age&value=2, result: ", ok, "<br>")

local ok, err = db:decr("age", "-2")
if not ok then
    say("failed to decr: ", err)
    return
end
say("decr requests: key=age&value=-2, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:del("age")
if not ok then
    say("failed to del: ", err)
    return
end
say("del requests: key=age, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:del("age")
if not ok then
    say("failed to del: ", err)
    return
end
say("del requests: key=age, result: ", ok, "<br><br>")


local ok, err = db:multi_set("age", "none", "name", "none", "domain", "none")
if not ok then
    say("failed to multi_set: ", err)
    return
end
say("multi_set requests: key=age&value=none, key=name&value=none, key=domain&value=none, result: ", ok, "<br>")

local ok, err = db:multi_set("age", "8", "name", "LazyZhu", "domain", "lazyzhu.com")
if not ok then
    say("failed to multi_set: ", err)
    return
end
say("multi_set requests: key=age&value=8, key=name&value=LazyZhu, key=domain&value=lazyzhu.com, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    say("multi_get not found.")
    return
end
say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:multi_del("age", "name")
if not ok then
    say("failed to multi_del: ", err)
    return
end
say("multi_del requests: key=age, key=name, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    say("multi_get not found.")
    return
end
say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:del("domain")
if not ok then
    say("failed to del: ", err)
    return
end
say("del requests: key=domain, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    say("multi_get not found.")
    return
end
say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:multi_del("age", "name", "domain")
if not ok then
    say("failed to multi_del: ", err)
    return
end
say("multi_del requests: key=age, key=name, key=domain, result: ", ok, "<br><br>")

local ok, err = db:multi_set("age", "8", "name", "LazyZhu", "domain", "lazyzhu.com")
if not ok then
    say("failed to multi_set: ", err)
    return
end
say("multi_set requests: key=age&value=8, key=name&value=LazyZhu, key=domain&value=lazyzhu.com, result: ", ok, "<br>")

local res, err = db:scan("0", "z", "5")
if not res then
    say("failed to scan: ", err)
    return
end
if res == ngx.null then
    say("scan not found.")
    return
end
say("scan requests: rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:rscan("z", "0", "5")
if not res then
    say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    say("rscan not found.")
    return
end
say("rscan requests: rule=z:0:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:keys("0", "z", "5")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")

local ok, err = db:multi_del("age", "name", "domain")
if not ok then
    say("failed to multi_del: ", err)
    return
end
say("multi_del requests: key=age, key=name, key=domain, result: ", ok, "<br><br>")

local ok, err = db:hset("personal", "age", "none")
if not ok then
    say("failed to hset: ", err)
    return
end
say("hset requests: key=personal&field=age&value=none, result: ", ok, "<br>")

local ok, err = db:hset("personal", "age", "8")
if not ok then
    say("failed to hset: ", err)
    return
end
say("hset requests: key=personal&field=age&value=8, result: ", ok, "<br>")

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

local ok, err = db:hincr("personal", "age", "-2")
if not ok then
    say("failed to hincr: ", err)
    return
end
say("hincr requests: key=personal&field=age&value=-2, result: ", ok, "<br>")

local ok, err = db:hdecr("personal", "age", "2")
if not ok then
    say("failed to hdecr: ", err)
    return
end
say("hdecr requests: key=personal&field=age&value=2, result: ", ok, "<br>")

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
say("hdel requests: key=personal&field=age, result: ", ok, "<br><br>")

local ok, err = db:init_pipeline()
db:hset("public", "born", "CN")
db:hset("personal", "age", "8")
db:hset("personal", "name", "LazyZhu")
db:hset("personal", "domain", "lazyzhu.com")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: hset key=public&field=born&value=CN, hset key=personal&field=age&value=8, hset key=personal&field=name&value=LazyZhu, hset key=personal&field=domain&value=lazyzhu.com", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br>")

local ok, err = db:init_pipeline()
db:hget("public", "born")
db:hget("personal", "age")
db:hget("personal", "name")
db:hget("personal", "domain")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: hget key=public&field=born, hget key=personal&field=age, hget key=personal&field=name, hget key=personal&field=domain", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br><br>")

local res, err = db:hscan("personal", "0", "z", "5")
if not res then
    say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    say("hscan not found.")
    return
end
say("hscan requests: key=personal&rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:hrscan("personal", "z", "0", "5")
if not res then
    say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    say("hrscan not found.")
    return
end
say("hrscan requests: key=personal&rule=z:0:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:hkeys("personal", "0", "z", "5")
if not res then
    say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    say("hkeys not found.")
    return
end
say("hkeys requests: key=personal&rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")

local res, err = db:hsize("personal")
if not res then
    say("failed to hsize: ", err)
    return
end
if res == ngx.null then
    say("hsize not found.")
    return
end
say("hsize requests: key=personal, result: ", res, "<br>")

local res, err = db:hlist("0", "z", "5")
if not res then
    say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    say("hlist not found.")
    return
end
say("hlist requests: rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")

local ok, err = db:init_pipeline()
db:hdel("personal", "age")
db:hdel("personal", "name")
db:hdel("personal", "domain")
db:hdel("public", "born")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: hdel key=personal&field=age, hdel key=personal&field=name, hdel key=personal&field=domain, hdel key=public&field=born&value=CN", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br><br>")

local ok, err = db:zset("age", "8", "2")
if not ok then
    say("failed to zset: ", err)
    return
end
say("zset requests: key=age&member=8&score=2, result: ", ok, "<br>")

local ok, err = db:zset("age", "8", "1")
if not ok then
    say("failed to zset: ", err)
    return
end
say("zset requests: key=age&member=8&score=1, result: ", ok, "<br>")

local res, err = db:zget("age", "8")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=age&member=8, result: ", res, "<br>")

local ok, err = db:zincr("age", "8", "2")
if not ok then
    say("failed to zincr: ", err)
    return
end
say("zincr requests: key=age&member=8&score=2, result: ", ok, "<br>")

local ok, err = db:zincr("age", "8", "-2")
if not ok then
    say("failed to zincr: ", err)
    return
end
say("zincr requests: key=age&member=8&score=-2, result: ", ok, "<br>")

local ok, err = db:zdecr("age", "8", "2")
if not ok then
    say("failed to zdecr: ", err)
    return
end
say("zdecr requests: key=age&member=8&score=2, result: ", ok, "<br>")

local ok, err = db:zdecr("age", "8", "-2")
if not ok then
    say("failed to zdecr: ", err)
    return
end
say("zdecr requests: key=age&member=8&score=-2, result: ", ok, "<br>")

local res, err = db:zget("age", "8")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=age&member=8, result: ", res, "<br>")

local ok, err = db:zdel("age", "8")
if not ok then
    say("failed to zdel: ", err)
    return
end
say("zdel requests: key=age&member=8, result: ", ok, "<br>")

local res, err = db:zget("age", "8")
if not res then
    say("failed to zget: ", err)
    return
end
if res == ngx.null then
    say("zget not found.")
    return
end
say("zget requests: key=age&member=8, result: ", res, "<br>")

local ok, err = db:zdel("age", "8")
if not ok then
    say("failed to zdel: ", err)
    return
end
say("zdel requests: key=age&member=8, result: ", ok, "<br><br>")

local ok, err = db:init_pipeline()
db:zset("name", "LazyZhu", "1")
db:zset("name", "LazyZhu", "2")
db:zset("domain", "lazyzhu.com", "1")
db:zset("domain", "lazyzhu.net", "1")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: zset key=name&member=LazyZhu&score=1, zset key=name&member=LazyZhu&score=2, zset key=domain&member=lazyzhu.com&score=1, zset key=domain&member=lazyzhu.net&score=1", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br>")

local ok, err = db:init_pipeline()
db:zget("name", "LazyZhu")
db:zget("domain", "lazyzhu.com")
db:zget("domain", "lazyzhu.net")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: zget key=name&member=LazyZhu, zget key=domain&member=lazyzhu.com, zget key=domain&member=lazyzhu.net", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br><br>")

local res, err = db:zscan("domain", "", "0", "9", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&member=&rule=0:9:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "lazyzhu.com", "1", "9", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&member=lazyzhu.com&rule=1:9:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "lazyzhu.net", "1", "9", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&member=lazyzhu.net&rule=1:9:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "z", "1", "9", "5")
if not res then
    say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    say("zscan not found.")
    return
end
say("zscan requests: key=domain&member=z&rule=1:9:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zrscan("domain", "lazyzhu.net", "9", "0", "5")
if not res then
    say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    say("zrscan not found.")
    return
end
say("zrscan requests: key=domain&member=lazyzhu.net&rule=9:0:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zkeys("domain", "lazyzhu.com", "0", "9", "5")
if not res then
    say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    say("zkeys not found.")
    return
end
say("zkeys requests: key=domain&member=lazyzhu.com&rule=0:9:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")

local res, err = db:zsize("domain")
if not res then
    say("failed to zsize: ", err)
    return
end
if res == ngx.null then
    say("zsize not found.")
    return
end
say("zsize requests: key=domain, result: ", res, "<br>")

local res, err = db:zlist("0", "z", "5")
if not res then
    say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    say("zlist not found.")
    return
end
say("zlist requests: rule=0:z:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")

local times = db:get_reused_times()
say("reused times: ", times, "<br><br>")
local ok, err = db:set_keepalive()
if not ok then
    say("failed to set keepalive: ", err)
    return
end
local ok, err = db:connect("127.0.0.1", 8888)
if not ok then
    say("failed to connect: ", err)
    return
end

local ok, err = db:init_pipeline()
db:zdel("name", "LazyZhu")
db:zdel("domain", "lazyzhu.com")
db:zdel("domain", "lazyzhu.net")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: zdel key=name&member=LazyZhu, zdel key=domain&member=lazyzhu.com, zdel key=domain&member=lazyzhu.net", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
say("result to json string: ", cjson.encode(results), "<br><br>")

local times = db:get_reused_times()
say("reused times: ", times, "<br><br>")

local ok, err = db:close()
