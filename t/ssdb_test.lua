local cjson = require "cjson"
local ssdb = require "resty.ssdb"
local db = ssdb:new()

local ok, err = db:set_timeout(5000)

local ok, err = db:connect("127.0.0.1", 8888)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end



local ok, err = db:set("age", "6")
if not ok then
    ngx.say("failed to set: ", err)
    return
end
ngx.say("set requests: key=age&value=6, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    ngx.say("failed to get: ", err)
    return
end
if res == ngx.null then
    ngx.say("get not found.")
    return
end
ngx.say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:set("age", "8")
if not ok then
    ngx.say("failed to set: ", err)
    return
end
ngx.say("set requests: key=age&value=8, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    ngx.say("failed to get: ", err)
    return
end
if res == ngx.null then
    ngx.say("get not found.")
    return
end
ngx.say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:incr("age", "2")
if not ok then
    ngx.say("failed to incr: ", err)
    return
end
ngx.say("incr requests: key=age&value=2, result: ", ok, "<br>")

local ok, err = db:incr("age", "-2")
if not ok then
    ngx.say("failed to incr: ", err)
    return
end
ngx.say("incr requests: key=age&value=-2, result: ", ok, "<br>")

local ok, err = db:decr("age", "2")
if not ok then
    ngx.say("failed to decr: ", err)
    return
end
ngx.say("decr requests: key=age&value=2, result: ", ok, "<br>")

local ok, err = db:decr("age", "-2")
if not ok then
    ngx.say("failed to decr: ", err)
    return
end
ngx.say("decr requests: key=age&value=-2, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    ngx.say("failed to get: ", err)
    return
end
if res == ngx.null then
    ngx.say("get not found.")
    return
end
ngx.say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:del("age")
if not ok then
    ngx.say("failed to del: ", err)
    return
end
ngx.say("del requests: key=age, result: ", ok, "<br>")

local res, err = db:get("age")
if not res then
    ngx.say("failed to get: ", err)
    return
end
if res == ngx.null then
    ngx.say("get not found.")
    return
end
ngx.say("get requests: key=age, result: ", res, "<br>")

local ok, err = db:del("age")
if not ok then
    ngx.say("failed to del: ", err)
    return
end
ngx.say("del requests: key=age, result: ", ok, "<br><br>")


local ok, err = db:multi_set("age", "none", "name", "none", "domain", "none")
if not ok then
    ngx.say("failed to multi_set: ", err)
    return
end
ngx.say("multi_set requests: key=age&value=none, key=name&value=none, key=domain&value=none, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    ngx.say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    ngx.say("multi_get not found.")
    return
end
ngx.say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:multi_set("age", "8", "name", "LazyZhu", "domain", "lazyzhu.com")
if not ok then
    ngx.say("failed to multi_set: ", err)
    return
end
ngx.say("multi_set requests: key=age&value=8, key=name&value=LazyZhu, key=domain&value=lazyzhu.com, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    ngx.say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    ngx.say("multi_get not found.")
    return
end
ngx.say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:multi_del("age", "name")
if not ok then
    ngx.say("failed to multi_del: ", err)
    return
end
ngx.say("multi_del requests: key=age, key=name, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    ngx.say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    ngx.say("multi_get not found.")
    return
end
ngx.say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:del("domain")
if not ok then
    ngx.say("failed to del: ", err)
    return
end
ngx.say("del requests: key=domain, result: ", ok, "<br>")

local res, err = db:multi_get("age", "name", "domain")
if not res then
    ngx.say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    ngx.say("multi_get not found.")
    return
end
ngx.say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local ok, err = db:multi_del("age", "name", "domain")
if not ok then
    ngx.say("failed to multi_del: ", err)
    return
end
ngx.say("multi_del requests: key=age, key=name, key=domain, result: ", ok, "<br><br>")

local ok, err = db:multi_set("age", "8", "name", "LazyZhu", "domain", "lazyzhu.com")
if not ok then
    ngx.say("failed to multi_set: ", err)
    return
end
ngx.say("multi_set requests: key=age&value=8, key=name&value=LazyZhu, key=domain&value=lazyzhu.com, result: ", ok, "<br>")

local res, err = db:scan("0", "z", "5")
if not res then
    ngx.say("failed to scan: ", err)
    return
end
if res == ngx.null then
    ngx.say("scan not found.")
    return
end
ngx.say("scan requests: rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:rscan("z", "0", "5")
if not res then
    ngx.say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("rscan not found.")
    return
end
ngx.say("rscan requests: rule=z:0:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:keys("0", "z", "5")
if not res then
    ngx.say("failed to keys: ", err)
    return
end
if res == ngx.null then
    ngx.say("keys not found.")
    return
end
ngx.say("keys requests: rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")

local ok, err = db:multi_del("age", "name", "domain")
if not ok then
    ngx.say("failed to multi_del: ", err)
    return
end
ngx.say("multi_del requests: key=age, key=name, key=domain, result: ", ok, "<br><br>")

local ok, err = db:hset("personal", "name", "none")
if not ok then
    ngx.say("failed to hset: ", err)
    return
end
ngx.say("hset requests: hash=personal&field=name&value=none, result: ", ok, "<br>")

local res, err = db:hget("personal", "name")
if not res then
    ngx.say("failed to hget: ", err)
    return
end
if res == ngx.null then
    ngx.say("hget not found.")
    return
end
ngx.say("hget requests: hash=personal&field=name, result: ", res, "<br>")

local ok, err = db:hset("personal", "name", "LazyZhu")
if not ok then
    ngx.say("failed to hset: ", err)
    return
end
ngx.say("hset requests: hash=personal&field=name&value=LazyZhu, result: ", ok, "<br>")

local res, err = db:hget("personal", "name")
if not res then
    ngx.say("failed to hget: ", err)
    return
end
if res == ngx.null then
    ngx.say("hget not found.")
    return
end
ngx.say("hget requests: hash=personal&field=name, result: ", res, "<br>")

local ok, err = db:hdel("personal", "name")
if not ok then
    ngx.say("failed to hdel: ", err)
    return
end
ngx.say("hdel requests: hash=personal&field=name, result: ", ok, "<br>")

local res, err = db:hget("personal", "name")
if not res then
    ngx.say("failed to hget: ", err)
    return
end
if res == ngx.null then
    ngx.say("hget not found.")
    return
end
ngx.say("hget requests: hash=personal&field=name, result: ", res, "<br>")

local ok, err = db:hdel("personal", "name")
if not ok then
    ngx.say("failed to hdel: ", err)
    return
end
ngx.say("hdel requests: hash=personal&field=name, result: ", ok, "<br><br>")

local ok, err = db:hset("personal", "age", "8")
if not ok then
    ngx.say("failed to hset: ", err)
    return
end
ngx.say("hset requests: hash=personal&field=age&value=8, result: ", ok, "<br>")

local res, err = db:hget("personal", "age")
if not res then
    ngx.say("failed to hget: ", err)
    return
end
if res == ngx.null then
    ngx.say("hget not found.")
    return
end
ngx.say("hget requests: hash=personal&field=age, result: ", res, "<br>")

local ok, err = db:hincr("personal", "age", "2")
if not ok then
    ngx.say("failed to hincr: ", err)
    return
end
ngx.say("hincr requests: hash=personal&field=age&value=2, result: ", ok, "<br>")

local ok, err = db:hincr("personal", "age", "-2")
if not ok then
    ngx.say("failed to hincr: ", err)
    return
end
ngx.say("hincr requests: hash=personal&field=age&value=-2, result: ", ok, "<br>")

local ok, err = db:hdecr("personal", "age", "2")
if not ok then
    ngx.say("failed to hdecr: ", err)
    return
end
ngx.say("hdecr requests: hash=personal&field=age&value=2, result: ", ok, "<br>")

local ok, err = db:hdecr("personal", "age", "-2")
if not ok then
    ngx.say("failed to hdecr: ", err)
    return
end
ngx.say("hdecr requests: hash=personal&field=age&value=-2, result: ", ok, "<br>")

local res, err = db:hget("personal", "age")
if not res then
    ngx.say("failed to hget: ", err)
    return
end
if res == ngx.null then
    ngx.say("hget not found.")
    return
end
ngx.say("hget requests: hash=personal&field=age, result: ", res, "<br>")

local ok, err = db:hdel("personal", "age")
if not ok then
    ngx.say("failed to hdel: ", err)
    return
end
ngx.say("hdel requests: hash=personal&field=age, result: ", ok, "<br><br>")

local ok, err = db:init_pipeline()
db:hset("public", "born", "CN")
db:hset("personal", "age", "8")
db:hset("personal", "name", "LazyZhu")
db:hset("personal", "domain", "lazyzhu.com")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: hset hash=public&field=born&value=CN, hset hash=personal&field=age&value=8, hset hash=personal&field=name&value=LazyZhu, hset hash=personal&field=domain&value=lazyzhu.com", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br>")

local ok, err = db:init_pipeline()
db:hget("personal", "age")
db:hget("personal", "name")
db:hget("personal", "domain")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: hget hash=personal&field=age, hget hash=personal&field=name, hget hash=personal&field=domain", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br><br>")

local res, err = db:hscan("personal", "0", "z", "5")
if not res then
    ngx.say("failed to hscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("hscan not found.")
    return
end
ngx.say("hscan requests: hash=personal&rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:hrscan("personal", "z", "0", "5")
if not res then
    ngx.say("failed to hrscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("hrscan not found.")
    return
end
ngx.say("hrscan requests: hash=personal&rule=z:0:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:hkeys("personal", "0", "z", "5")
if not res then
    ngx.say("failed to hkeys: ", err)
    return
end
if res == ngx.null then
    ngx.say("hkeys not found.")
    return
end
ngx.say("hkeys requests: hash=personal&rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")

local res, err = db:hsize("personal")
if not res then
    ngx.say("failed to hsize: ", err)
    return
end
if res == ngx.null then
    ngx.say("hsize not found.")
    return
end
ngx.say("hsize requests: hash=personal, result: ", res, "<br>")

local res, err = db:hlist("0", "z", "5")
if not res then
    ngx.say("failed to hlist: ", err)
    return
end
if res == ngx.null then
    ngx.say("hlist not found.")
    return
end
ngx.say("hlist requests: rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br><br>")

local ok, err = db:init_pipeline()
db:hdel("personal", "age")
db:hdel("personal", "name")
db:hdel("personal", "domain")
db:hdel("public", "born")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: hdel hash=personal&field=age, hdel hash=personal&field=name, hdel hash=personal&field=domain, hdel hash=public&field=born&value=CN", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br><br>")

local ok, err = db:zset("name", "LazyZhu", "1")
if not ok then
    ngx.say("failed to zset: ", err)
    return
end
ngx.say("zset requests: key=name&value=LazyZhu&score=1, result: ", ok, "<br>")

local res, err = db:zget("name", "LazyZhu")
if not res then
    ngx.say("failed to zget: ", err)
    return
end
if res == ngx.null then
    ngx.say("zget not found.")
    return
end
ngx.say("zget requests: key=name&value=LazyZhu, result: ", res, "<br>")

local ok, err = db:zset("name", "LazyZhu", "2")
if not ok then
    ngx.say("failed to zset: ", err)
    return
end
ngx.say("zset requests: key=name&value=LazyZhu&score=2, result: ", ok, "<br>")

local res, err = db:zget("name", "LazyZhu")
if not res then
    ngx.say("failed to zget: ", err)
    return
end
if res == ngx.null then
    ngx.say("zget not found.")
    return
end
ngx.say("zget requests: key=name&value=LazyZhu, result: ", res, "<br>")

local ok, err = db:zdel("name", "LazyZhu")
if not ok then
    ngx.say("failed to zdel: ", err)
    return
end
ngx.say("zdel requests: key=name&value=LazyZhu, result: ", ok, "<br>")

local res, err = db:zget("name", "LazyZhu")
if not res then
    ngx.say("failed to zget: ", err)
    return
end
if res == ngx.null then
    ngx.say("zget not found.")
    return
end
ngx.say("zget requests: key=name&value=LazyZhu, result: ", res, "<br>")

local ok, err = db:zdel("name", "LazyZhu")
if not ok then
    ngx.say("failed to zdel: ", err)
    return
end
ngx.say("zdel requests: key=name&value=LazyZhu, result: ", ok, "<br><br>")

local ok, err = db:zset("age", "8", "1")
if not ok then
    ngx.say("failed to zset: ", err)
    return
end
ngx.say("zset requests: key=age&value=8&score=1, result: ", ok, "<br>")

local res, err = db:zget("age", "8")
if not res then
    ngx.say("failed to zget: ", err)
    return
end
if res == ngx.null then
    ngx.say("zget not found.")
    return
end
ngx.say("zget requests: key=age&value=8, result: ", res, "<br>")

local ok, err = db:zincr("age", "8", "2")
if not ok then
    ngx.say("failed to zincr: ", err)
    return
end
ngx.say("zincr requests: key=age&value=8&score=2, result: ", ok, "<br>")

local ok, err = db:zincr("age", "8", "-2")
if not ok then
    ngx.say("failed to zincr: ", err)
    return
end
ngx.say("zincr requests: key=age&value=8&score=-2, result: ", ok, "<br>")

local ok, err = db:zdecr("age", "8", "2")
if not ok then
    ngx.say("failed to zdecr: ", err)
    return
end
ngx.say("zdecr requests: key=age&value=8&score=2, result: ", ok, "<br>")

local ok, err = db:zdecr("age", "8", "-2")
if not ok then
    ngx.say("failed to zdecr: ", err)
    return
end
ngx.say("zdecr requests: key=age&value=8&score=-2, result: ", ok, "<br>")

local res, err = db:zget("age", "8")
if not res then
    ngx.say("failed to zget: ", err)
    return
end
if res == ngx.null then
    ngx.say("zget not found.")
    return
end
ngx.say("zget requests: key=age&value=8, result: ", res, "<br>")

local ok, err = db:zdel("age", "8")
if not ok then
    ngx.say("failed to zdel: ", err)
    return
end
ngx.say("zdel requests: key=age&value=8, result: ", ok, "<br><br>")

local ok, err = db:init_pipeline()
db:zset("name", "LazyZhu", "2")
db:zset("name", "LazyZhu", "1")
db:zset("domain", "lazyzhu.com", "1")
db:zset("domain", "lazyzhu.net", "1")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: zset key=name&value=LazyZhu&score=2, zset key=name&value=LazyZhu&score=1, zset key=domain&value=lazyzhu.com&score=1, zset key=domain&value=lazyzhu.net&score=1", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br>")

local ok, err = db:init_pipeline()
db:zget("name", "LazyZhu")
db:zget("domain", "lazyzhu.com")
db:zget("domain", "lazyzhu.net")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: zget key=name&value=LazyZhu, zget key=domain&value=lazyzhu.com, zget key=domain&value=lazyzhu.net", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br><br>")

local res, err = db:zscan("domain", "", "0", "9", "5")
if not res then
    ngx.say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zscan not found.")
    return
end
ngx.say("zscan requests: key=domain&value=&rule=0:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "0", "1", "9", "5")
if not res then
    ngx.say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zscan not found.")
    return
end
ngx.say("zscan requests: key=domain&value=0&rule=1:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "lazyzhu.com", "1", "9", "5")
if not res then
    ngx.say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zscan not found.")
    return
end
ngx.say("zscan requests: key=domain&value=lazyzhu.com&rule=1:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "lazyzhu.net", "1", "9", "5")
if not res then
    ngx.say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zscan not found.")
    return
end
ngx.say("zscan requests: key=domain&value=lazyzhu.net&rule=1:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zscan("domain", "z", "1", "9", "5")
if not res then
    ngx.say("failed to zscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zscan not found.")
    return
end
ngx.say("zscan requests: key=domain&value=z&rule=1:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zrscan("domain", "lazyzhu.com", "9", "0", "5")
if not res then
    ngx.say("failed to zrscan: ", err)
    return
end
if res == ngx.null then
    ngx.say("zrscan not found.")
    return
end
ngx.say("zrscan requests: key=domain&value=lazyzhu.com&rule=9:0:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")
local h = db:array_to_hash(res)
ngx.say("json hash-like string: ", cjson.encode(h), "<br>")

local res, err = db:zkeys("domain", "lazyzhu.com", "0", "9", "5")
if not res then
    ngx.say("failed to zkeys: ", err)
    return
end
if res == ngx.null then
    ngx.say("zkeys not found.")
    return
end
ngx.say("zkeys requests: key=domain&value=lazyzhu.com&rule=0:9:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br>")

local res, err = db:zsize("domain")
if not res then
    ngx.say("failed to zsize: ", err)
    return
end
if res == ngx.null then
    ngx.say("zsize not found.")
    return
end
ngx.say("zsize requests: key=domain, result: ", res, "<br>")

local res, err = db:zlist("0", "z", "5")
if not res then
    ngx.say("failed to zlist: ", err)
    return
end
if res == ngx.null then
    ngx.say("zlist not found.")
    return
end
ngx.say("zlist requests: rule=0:z:5, result: ", res, "<br>")
ngx.say("result to json string: ", cjson.encode(res), "<br><br>")

local times = db:get_reused_times()
ngx.say("reused times: ", times, "<br><br>")
local ok, err = db:set_keepalive()
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end
local ok, err = db:connect("127.0.0.1", 8888)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local ok, err = db:init_pipeline()
db:zdel("name", "LazyZhu")
db:zdel("domain", "lazyzhu.com")
db:zdel("domain", "lazyzhu.net")
local results, err = db:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end
ngx.say("pipeline requests: zdel key=name&value=LazyZhu, zdel key=domain&value=lazyzhu.com, zdel key=domain&value=lazyzhu.net", "<br>")
for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
            ngx.say("pipeline command ", i, ", result: ", res, "<br>")
        end
    else
        -- process the scalar value
        ngx.say("pipeline command ", i, ", result: ", res, "<br>")
    end
end
ngx.say("result to json string: ", cjson.encode(results), "<br><br>")

local times = db:get_reused_times()
ngx.say("reused times: ", times, "<br><br>")

local ok, err = db:close()
