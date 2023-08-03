function Header(block)
	local add = true
	for _, class in ipairs(block.classes) do
		if class == "unnumbered" then
			add = false
			break
		end
	end
	if add then
		table.insert(block.classes, "unnumbered")
	end
	return block
end
