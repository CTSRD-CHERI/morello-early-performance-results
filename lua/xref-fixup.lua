function filepathtoid(filepath)
	local normalised = pandoc.path.normalize(filepath)
	-- normalize doesn't squash ".." components, but we want to
	local components = pandoc.path.split(normalised)
	local newcomponents = {}
	for i, component in ipairs(components) do
		if component == ".." then
			if #newcomponents == 0 then
				error("File path walked above source root")
			end
			newcomponents[#newcomponents] = nil
		else
			table.insert(newcomponents, component)
		end
	end
	if #newcomponents == 0 or not newcomponents[#newcomponents]:find(".md$") then
		table.insert(newcomponents, "README.md")
	end
	normalised = pandoc.path.join(newcomponents)
	normalised = normalised:gsub("_", "__")
	normalised = normalised:gsub("/", "_")
	return "--mdbook-file-" .. normalised
end

local filedir
local filename

function Meta(meta)
	filedir = meta["mdbook.xref-fixup.filedir"]
	filename = meta["mdbook.xref-fixup.filename"]
end

function Pandoc(doc)
	local span = pandoc.Span({})
	span.identifier = filepathtoid(filedir .. filename)
	local plain = pandoc.Plain({span})
	table.insert(doc.blocks, 1, plain)
	return doc
end

function Link(link)
	-- URIs are left unmodified
	if link.target:find("^[%a][%a%d+-%.]*:") then
		return link
	end

	-- (Possible) URI-reference. If there's a hash then use that id as the link
	-- target, otherwise mangle the path.
	local hash = link.target:find("#")
	if hash ~= nil then
		link.target = link.target:sub(hash, -1)
	else
		link.target = "#" .. filepathtoid(filedir .. link.target)
	end

	return link
end

return {
	{ Meta = Meta },
	{ Pandoc = Pandoc, Link = Link }
}
