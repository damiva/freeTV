local srv, http = require("server"), require("http")
local chn, myu = srv.form("chn"), srv.url_root.."/rutv.lua"
local r, e = http.get("http://rutv.cc"..chn)
assert(r, e)
assert(r.status_code == 200, "Returned code: "..r.status_code)
if chn == "" then
    local pl = {}
    for g, s in r.body:gmatch('.-<section><h3>(.-)</h3>(.-)</section>') do
        for u, c, t in s:gmatch('.-href="(.-)".-<h3(.-)>(.-)</h3>.-') do
            if c == "" then
                pl[#pl + 1] = {
                    title = t, 
                    group = g, 
                    mb_parser = myu.."?chn="..srv.encuri(u), 
                    stream_url = "md5mbhash"
                }
            end
        end
    end
    local json = require("json")
    srv.body(json.encode({is_iptv = true, channels = pl}))
else
    local b = r.body:match('^.-{.-file:"(.-)".-}.*$')
    if b then
        srv.body(b)
    else
        srv.header(404)
    end
end