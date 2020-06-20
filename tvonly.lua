srv, json, pl, mul = require("server"), require("json"), {}, "http://tv-only.stream/"
function get_url(url)
    local http = require("http")
    local r, e = http.get(url)
    assert(r, e)
    assert(r.status_code == 200, "Returned code: "..r.status_code)
    return r.body
end
local cat, url, img, ttl, myu = srv.form("cat"), srv.form("url"), srv.form("img"), srv.form("ttl"), srv.url_root .. "/tvonly.lua"
if cat ~= "" then
    local b = get_url(mul.."?cat="..cat):match('^.-<div class="boxwp%-posts%-container">(.-)<nav.*$')
    for i, u, t in b:gmatch('.-id="post%-.-<img.-src="(.-)".-<h3.-<a href="(.-)" rel="bookmark">(.-)</a></h3>.-') do
        pl[#pl + 1] = {title = t, logo_30x30 = i, playlist_url = myu.."?url="..srv.encuri(u).."&img="..srv.encuri(i).."&ttl="..srv.encuri(t)}
    end
elseif url ~= "" then
    local b = get_url(url)
    local bs = b:match('^.-file:%[(.-)%].*$')
    if bs then
        for n, u in bs:gmatch('.-"title":"(.-)".-"file":"(.-)".-') do
            pl[#pl + 1] = {title = ttl.." ("..n..")", logo_30x30 = img, stream_url = u}
        end
    else
        local u = b:match('^.-file:"(.-)".*$')
        if u then
            pl[#pl + 1] = {title = ttl, logo_30x30 = img, stream_url = u}
        end
    end
else
    local b = get_url(mul):match("^.-<select.->(.-)</select>.*$")
    for c, t, i in b:gmatch('.-value="(.-)".->(.-)%&.-(%(.-%))<.-') do
        pl[#pl + 1] = {title = t.."<span style='float:right'>"..i.."</span>", playlist_url = myu.."?cat="..c}
    end
end
srv.body(json.encode({is_iptv = cat ~= "" or url ~= "", channels = pl}))