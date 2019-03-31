local http = require("socket.http")
local ltn12 = require("ltn12")

function http.get(u)
   local t = {}
   local r, c, h = http.request{
      url = u,
      sink = ltn12.sink.table(t)}
   return r, c, h, table.concat(t)
end

-- 发送http.get请求，返回响应结果
function wb_getUrl(url)
	r,c,h,body = http.get(url)
	if c~= 200 then
		print("ErrorCode: " .. c)
		return
	else
		return body
	end
end

-- write data to file-"filename"
function writeFile(fname, data)
	f = io.open(fname, "wb")
	if f then
		f:write(data)
		f:close()
		return true
	else
		return false
	end
end

url = "http://www.baidu.com"
body = wb_getUrl(url)
if body ~= nil then
	writeFile("baidu.html", body)
end
