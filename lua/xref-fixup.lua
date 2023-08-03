function Link(link)
	local hash = link.target:find("#")
	if hash ~= nil then
		local colon = link.target:find(":")
		if colon == nil or colon > hash then
			link.target = link.target:sub(hash, -1)
		end
	end
	return link
end
