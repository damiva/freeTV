local srv, json = require("server"), require("json")
srv.body(json.encode({
    channels = {
        {
            title = "ТВ от tv-only.stream", 
            infolink = "http://tv-only.stream", 
            logo_30x30 = "http://tv-only.stream/wp-content/uploads/2018/06/1551330768_11-kanal-100x100.png",
            playlist_url = srv.url_root .. "/tvonly.lua",
            description = "<h3>Парсинг сайта:</h3><h3>http://tv-only.stream</h3>"
        },
        {
            title = "ТВ от rutv.cc", 
            infolink = "http://rutv.cc", 
            logo_30x30 = "http://rutv.cc/favicon.ico",
            playlist_url = srv.url_root .. "/rutv.lua",
            description = "<h3>Парсинг сайта:</h3><h3>http://rutv.cc</h3>"
        },
        {
            title = "ТВ от webarmen.com", 
            infolink = "https://webarmen.com/my/iptv/", 
            logo_30x30 = "https://webarmen.com/my/iptv/icon.png",
            playlist_url = "http://"..srv.host.."/parserlink?curl%20-L%20%22https%3A%2F%2Fwebarmen.com%2Fmy%2Fiptv%2Fauto.nogrp.m3u%22%7C%7C%7C%23EXTINF%3A%25-1%20group%25-title%3D%22%25-%20.-%25.mp4%7C",
            description = "<h3>Плейлист от</h3><h3>webarmen</h3>"
        }
    }
}))