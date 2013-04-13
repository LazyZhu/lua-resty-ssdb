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





local ok, err = db:exists("domain")
if not ok then
    say("failed to exists: ", err)
    return
end
say("exists requests: key=domain, result: ", ok, "<br>")



local res, err = db:get("domain")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=domain, result: ", res, "<br>")



local ok, err = db:set("domain", "none")
if not ok then
    say("failed to set: ", err)
    return
end
say("set requests: key=domain&value=none, result: ", ok, "<br>")



local res, err = db:get("domain")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=domain, result: ", res, "<br>")



local ok, err = db:set("domain", "lazyzhu.com")
if not ok then
    say("failed to set: ", err)
    return
end
say("set requests: key=domain&value=lazyzhu.com, result: ", ok, "<br>")



local ok, err = db:exists("domain")
if not ok then
    say("failed to exists: ", err)
    return
end
say("exists requests: key=domain, result: ", ok, "<br>")



local res, err = db:get("domain")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=domain, result: ", res, "<br>")



local ok, err = db:del("domain")
if not ok then
    say("failed to del: ", err)
    return
end
say("del requests: key=domain, result: ", ok, "<br>")

local ok, err = db:exists("domain")
if not ok then
    say("failed to exists: ", err)
    return
end
say("exists requests: key=domain, result: ", ok, "<br>")

local res, err = db:get("domain")
if not res then
    say("failed to get: ", err)
    return
end
if res == ngx.null then
    say("get not found.")
    return
end
say("get requests: key=domain, result: ", res, "<br>")

local ok, err = db:del("domain")
if not ok then
    say("failed to del: ", err)
    return
end
say("del requests: key=domain, result: ", ok, "<br><br>")




local ok, err = db:set("age", "18")
if not ok then
    say("failed to set: ", err)
    return
end
say("set requests: key=age&value=18, result: ", ok, "<br>")



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



local ok, err = db:incr("age", "-2")
if not ok then
    say("failed to incr: ", err)
    return
end
say("incr requests: key=age&value=-2, result: ", ok, "<br>")



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



local ok, err = db:decr("age", "2")
if not ok then
    say("failed to decr: ", err)
    return
end
say("decr requests: key=age&value=2, result: ", ok, "<br>")



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

local ok, err = db:exists("age")
if not ok then
    say("failed to exists: ", err)
    return
end
say("exists requests: key=age, result: ", ok, "<br><br>")





local ok, err = db:multi_set("name", "LazyZhu", "age", "18", "domain", "lazyzhu.com")
if not ok then
    say("failed to multi_set: ", err)
    return
end
say("multi_set requests: key=name&value=LazyZhu, key=age&value=18, key=domain&value=lazyzhu.com, result: ", ok, "<br>")


local res, err = db:multi_exists("name", "age", "domain")
if not res then
    say("failed to multi_exists: ", err)
    return
end
if res == ngx.null then
    say("multi_exists not found.")
    return
end
say("multi_exists requests: key=name, key=age, key=domain, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_get("name", "age", "domain")
if not res then
    say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    say("multi_get not found.")
    return
end
say("multi_get requests: key=name, key=age, key=domain, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local res, err = db:scan("", "", "5")
if not res then
    say("failed to scan: ", err)
    return
end
if res == ngx.null then
    say("scan not found.")
    return
end
say("scan requests: rule=blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:rscan("", "", "5")
if not res then
    say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    say("rscan not found.")
    return
end
say("rscan requests: rule=blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:scan("", "", "2")
if not res then
    say("failed to scan: ", err)
    return
end
if res == ngx.null then
    say("scan not found.")
    return
end
say("scan requests: rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:rscan("", "", "2")
if not res then
    say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    say("rscan not found.")
    return
end
say("rscan requests: rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:scan("a", "n", "5")
if not res then
    say("failed to scan: ", err)
    return
end
if res == ngx.null then
    say("scan not found.")
    return
end
say("scan requests: rule=a:n:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:scan("a", "o", "5")
if not res then
    say("failed to scan: ", err)
    return
end
if res == ngx.null then
    say("scan not found.")
    return
end
say("scan requests: rule=a:o:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:rscan("n", "a", "5")
if not res then
    say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    say("rscan not found.")
    return
end
say("rscan requests: rule=n:a:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:rscan("o", "a", "5")
if not res then
    say("failed to rscan: ", err)
    return
end
if res == ngx.null then
    say("rscan not found.")
    return
end
say("rscan requests: rule=o:a:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:keys("", "", "5")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=blank:blank:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:keys("", "", "2")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=blank:blank:2, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:keys("a", "n", "5")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=a:n:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:keys("a", "o", "5")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=a:o:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br>")



local res, err = db:keys("n", "a", "5")
if not res then
    say("failed to keys: ", err)
    return
end
if res == ngx.null then
    say("keys not found.")
    return
end
say("keys requests: rule=n:a:5, result: ", res, "<br>")
say("result to json string: ", cjson.encode(res), "<br><br>")





local ok, err = db:multi_del("name", "age", "domain")
if not ok then
    say("failed to multi_del: ", err)
    return
end
say("multi_del requests: key=name, key=age, key=domain, result: ", ok, "<br>")



local res, err = db:multi_exists("name", "age", "domain")
if not res then
    say("failed to multi_exists: ", err)
    return
end
if res == ngx.null then
    say("multi_exists not found.")
    return
end
say("multi_exists requests: key=name, key=age, key=domain, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br>")



local res, err = db:multi_get("name", "age", "domain")
if not res then
    say("failed to multi_get: ", err)
    return
end
if res == ngx.null then
    say("multi_get not found.")
    return
end
say("multi_get requests: key=age, key=name, key=domain, result: ", res, "<br>")
local h = db:array_to_hash(res)
say("json hash-like string: ", cjson.encode(h), "<br><br>")





local ok, err = db:init_pipeline()
db:set("name", "LazyZhu")
db:set("age", "18")
db:set("domain", "lazyzhu.com")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: set key=name&value=LazyZhu, set key=age&value=18, set key=domain&value=lazyzhu.com", "<br>")
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
db:exists("name")
db:exists("age")
db:exists("domain")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: exists key=name, exists key=age, exists key=domain", "<br>")
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
db:get("name")
db:get("age")
db:get("domain")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: get key=name, get key=age, get key=domain", "<br>")
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
db:del("name")
db:del("age")
db:del("domain")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: del key=name, del key=age, del key=domain", "<br>")
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
db:exists("name")
db:exists("age")
db:exists("domain")
local results, err = db:commit_pipeline()
if not results then
    say("failed to commit the pipelined requests: ", err)
    return
end
say("pipeline requests: exists key=name, exists key=age, exists key=domain", "<br>")
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





local ok, err = db:close()
