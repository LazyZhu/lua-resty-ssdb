Name
====

lua-resty-ssdb - Lua ssdb client driver for the ngx_lua based on the cosocket API

Status
======

This library is considedb production ready.

Description
===========

This Lua library is a SSDB client driver for the ngx_lua nginx module:

http://wiki.nginx.org/HttpLuaModule

This Lua library takes advantage of ngx_lua's cosocket API, which ensures
100% nonblocking behavior.

Note that at least [ngx_lua 0.5.14](https://github.com/chaoslawful/lua-nginx-module/tags) or [ngx_openresty 1.2.1.14](http://openresty.org/#Download) is required.

SSDB is an open source, advanced key-value store server based on leveldb database:

https://github.com/ideawu/ssdb

Synopsis
========

    lua_package_path "/path/to/lua-resty-ssdb/lib/?.lua;;";

    server {
        location /test {
            content_by_lua '
                local ssdb = require "resty.ssdb"
                local db = ssdb:new()

                db:set_timeout(1000) -- 1 sec

                local ok, err = db:connect("127.0.0.1", 8888)
                if not ok then
                    ngx.say("failed to connect: ", err)
                    return
                end

                ok, err = db:set("dog", "an animal")
                if not ok then
                    ngx.say("failed to set dog: ", err)
                    return
                end

                ngx.say("set result: ", ok)

                local res, err = db:get("dog")
                if not res then
                    ngx.say("failed to get dog: ", err)
                    return
                end

                if res == ngx.null then
                    ngx.say("dog not found.")
                    return
                end

                ngx.say("dog: ", res)

                db:init_pipeline()
                db:set("cat", "Marry")
                db:set("horse", "Bob")
                db:get("cat")
                db:get("horse")
                local results, err = db:commit_pipeline()
                if not results then
                    ngx.say("failed to commit the pipelined requests: ", err)
                    return
                end

                for i, res in ipairs(results) do
                    if type(res) == "table" then
                        if not res[1] then
                            ngx.say("failed to run command ", i, ": ", res[2])
                        else
                            -- process the table value
                        end
                    else
                        -- process the scalar value
                    end
                end

                -- put it into the connection pool of size 100,
                -- with 0 idle timeout
                local ok, err = db:set_keepalive(0, 100)
                if not ok then
                    ngx.say("failed to set keepalive: ", err)
                    return
                end

                -- or just close the connection right away:
                -- local ok, err = db:close()
                -- if not ok then
                --     ngx.say("failed to close: ", err)
                --     return
                -- end
            ';
        }
    }

Methods
=======

All of the SSDB commands have their own methods with the same name except all in lower case.

You can find the complete list of SSDB commands here:

https://github.com/ideawu/ssdb/wiki/Commands

You need to check out this SSDB command reference to see what SSDB command accepts what arguments.

The SSDB command arguments can be directly fed into the corresponding method call. For example, the "GET" SSDB command accepts a single key argument, then you can just call the "get" method like this:

    local res, err = db:get("key")

Similarly, the "SCAN" ssdb command accepts four arguments, then you should call the "scan" method like this:

    local res, err = db:scan("key", "0", "z", "8")

For example, "SET", "GET", "SCAN", and "RSCAN" commands correspond to the methods "set", "get", "scan", and "rscan".

All ssdb command methods returns a status reply and `nil` otherwise. In case of errors or failures, it will also return a second value which is a string describing the error.

A non-nil SSDB "bulk reply" results in a Lua string as the return value. A nil bulk reply results in a `ngx.null` return value.

A non-nil SSDB "multi-bulk reply" results in a Lua table holding all the composing values (if any).

A nil multi-bulk reply returns in a `ngx.null` value.

See https://github.com/ideawu/ssdb/wiki/Commands for details regarding various SSDB reply types.

In addition to all those ssdb command methods, the following methods are also provided:

new
---
`syntax: db, err = ssdb:new()`

Creates a ssdb object. In case of failures, returns `nil` and a string describing the error.

connect
-------
`syntax: ok, err = db:connect(host, port, options_table?)`

Attempts to connect to the remote host and port that the ssdb server is listening to.

Before actually resolving the host name and connecting to the remote backend, this method will always look up the connection pool for matched idle connections created by previous calls of this method.

An optional Lua table can be specified as the last argument to this method to specify various connect options:

* `pool`
: Specifies a custom name for the connection pool being used. If omitted, then the connection pool name will be generated from the string template `<host>:<port>`.

set_timeout
----------
`syntax: db:set_timeout(time)`

Sets the timeout (in ms) protection for subsequent operations, including the `connect` method.

set_keepalive
------------
`syntax: ok, err = db:set_keepalive(max_idle_timeout, pool_size)`

Puts the current SSDB connection immediately into the ngx_lua cosocket connection pool.

You can specify the max idle timeout (in ms) when the connection is in the pool and the maximal size of the pool every nginx worker process.

In case of success, returns `1`. In case of errors, returns `nil` with a string describing the error.

Only call this method in the place you would have called the `close` method instead. Calling this method will immediately turn the current ssdb object into the `closed` state. Any subsequent operations other than `connect()` on the current objet will return the `closed` error.

get_reused_times
----------------
`syntax: times, err = db:get_reused_times()`

This method returns the (successfully) reused times for the current connection. In case of error, it returns `nil` and a string describing the error.

If the current connection does not come from the built-in connection pool, then this method always returns `0`, that is, the connection has never been reused (yet). If the connection comes from the connection pool, then the return value is always non-zero. So this method can also be used to determine if the current connection comes from the pool.

close
-----
`syntax: ok, err = db:close()`

Closes the current ssdb connection and returns the status.

In case of success, returns `1`. In case of errors, returns `nil` with a string describing the error.

init_pipeline
-------------
`syntax: db:init_pipeline()`

Enable the ssdb pipelining mode. All subsequent calls to SSDB command methods will automatically get cached and will send to the server in one run when the `commit_pipeline` method is called or get cancelled by calling the `cancel_pipeline` method.

This method always succeeds.

If the ssdb object is already in the SSDB pipelining mode, then calling this method will discard existing cached SSDB queries.

commit_pipeline
---------------
`syntax: results, err = db:commit_pipeline()`

Quits the pipelining mode by committing all the cached SSDB queries to the remote server in a single run. All the replies for these queries will be collected automatically and are returned as if a big multi-bulk reply at the highest level.

This method returns `nil` and a Lua string describing the error upon failures.

cancel_pipeline
---------------
`syntax: db:cancel_pipeline()`

Quits the pipelining mode by discarding all existing cached SSDB commands since the last call to the `init_pipeline` method.

This method always succeeds.

If the ssdb object is not in the SSDB pipelining mode, then this method is a no-op.

add_commands
------------
`syntax: hash = ssdb.add_commands(cmd_name1, cmd_name2, ...)`

Adds new ssdb commands to the `resty.ssdb` class. Here is an example:

    local ssdb = require "resty.ssdb"

    ssdb.add_commands("foo", "bar")

    local db = ssdb:new()

    db:set_timeout(1000) -- 1 sec

    local ok, err = db:connect("127.0.0.1", 6379)
    if not ok then
        ngx.say("failed to connect: ", err)
        return
    end

    local res, err = db:foo("a")
    if not res then
        ngx.say("failed to foo: ", err)
    end

    res, err = db:bar()
    if not res then
        ngx.say("failed to bar: ", err)
    end

Debugging
=========

It is usually convenient to use the [lua-cjson](http://www.kyne.com.au/~mark/software/lua-cjson.php) library to encode the return values of the ssdb command methods to JSON. For example,

    local cjson = require "cjson"
    ...
    local res, err = db:multi_get("h1234", "h5678")
    if res then
        print("res: ", cjson.encode(res))
    end

Limitations
===========

* This library cannot be used in code contexts like set_by_lua*, log_by_lua*, and
header_filter_by_lua* where the ngx_lua cosocket API is not available.
* The `resty.ssdb` object instance cannot be stodb in a Lua variable at the Lua module level,
because it will then be shadb by all the concurrent requests handled by the same nginx
 worker process (see
http://wiki.nginx.org/HttpLuaModule#Data_Sharing_within_an_Nginx_Worker ) and
result in bad race conditions when concurrent requests are trying to use the same `resty.ssdb` instance.
You should always initiate `resty.ssdb` objects in function local
variables or in the `ngx.ctx` table. These places all have their own data copies for
each request.

Installation
============

If you are using the ngx_openresty bundle (http://openresty.org ), then
you need to copy `ssdb.lua` to resty dir because it does't includes
lua-resty-ssdb by default. And you can just use it in your Lua code,
as in

    local ssdb = require "resty.ssdb"
    ...

If you're using your own nginx + ngx_lua build, then you need to configure
the lua_package_path directive to add the path of your lua-resty-ssdb source
tree to ngx_lua's LUA_PATH search path, as in

    # nginx.conf
    http {
        lua_package_path "/path/to/lua-resty-ssdb/lib/?.lua;;";
        ...
    }

TODO
====

Community
=========

English Mailing List
--------------------

The [openresty-en](https://groups.google.com/group/openresty-en) mailing list is for English speakers.

Chinese Mailing List
--------------------

The [openresty](https://groups.google.com/group/openresty) mailing list is for Chinese speakers.

Bugs and Patches
================

Please report bugs or submit patches by

1. creating a ticket on the [GitHub Issue Tracker](https://github.com/LazyZhu/lua-resty-ssdb/issues),
1. or posting to the [OpenResty community](http://wiki.nginx.org/HttpLuaModule#Community).

Author
======

LazyZhu (lazyzhu.com) <billfzhu@gmail.com>

Yichun "agentzh" Zhang (章亦春) <agentzh@gmail.com>, CloudFlare Inc.

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2012-2013, by Yichun Zhang (agentzh) <agentzh@gmail.com>, CloudFlare Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

See Also
========
* the ngx_lua module: http://wiki.nginx.org/HttpLuaModule
* the ssdb widb protocol specification: https://github.com/ideawu/ssdb/wiki/Commands
* the [lua-resty-redis](https://github.com/agentzh/lua-resty-redis) library

