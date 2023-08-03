local Block = {}
Block.mt = {}
Block.mt.__index = function(table, key)
	error("Unsupported block type " .. key .. "\n")
end
setmetatable(Block, Block.mt)

local Inline = {}
Inline.mt = {}
Inline.mt.__index = function(table, key)
	error("Unsupported inline type " .. key .. "\n")
end
setmetatable(Inline, Inline.mt)

local function Blocks(level, blocks)
	for _, block in ipairs(blocks) do
		Block[block.tag](level, block)
	end
end

local function Inlines(level, inlines)
	for _, inline in ipairs(inlines) do
		Inline[inline.tag](level, inline)
	end
end

local sections = {}

Inline.Link = function(level, inline)
	if inline.target ~= "" then
		table.insert(sections, {level=level, file=inline.target})
	end
end

Inline.SoftBreak = function(level, inline)
end

Inline.Space = function(level, inline)
end

Inline.Str = function(level, inline)
end

Block.Header = function(level, block)
	Inlines(level, block.content)
end

Block.Para = function(level, block)
	Inlines(level, block.content)
end

Block.Plain = function(level, block)
	Inlines(level, block.content)
end

Block.RawBlock = function(level, inline)
end

Block.BulletList = function(level, block)
	for _, blocks in ipairs(block.content) do
		Blocks(level + 1, blocks)
	end
end

local function pathsplit(path)
	local rlastslash = path:reverse():find("/")
	if rlastslash == nil then
		rlastslash = 0
	end
	return path:sub(1, -rlastslash), path:sub(-rlastslash + 1, -1)
end

function Writer(doc, opts)
	local src
	local book
	local out
	local lua
	function Meta(meta)
		local function getdir(meta, key, val)
			if meta["mdbook." .. key] ~= nil then
				val = meta["mdbook." .. key]
			end
			val = val:gsub("/*$", "")
			if val ~= "" then
				val = val .. "/"
			end
			return val
		end
		src = getdir(meta, "srcdir", "src")
		book = getdir(meta, "bookdir", "book")
		out = getdir(meta, "outdir", "pdf")
		lua = getdir(meta, "luadir", "")
	end

	Meta(doc.meta)
	Blocks(0, doc.blocks)

	if #sections == 0 then
		error("No sections found")
	end

	local frags = {}
	local srcfiles = {}
	local bookfiles = {}
	local outfiles = {}
	for _, section in ipairs(sections) do
		local level = section.level
		local filedir, filename = pathsplit(section.file)

		local srcfile = src .. section.file

		local bookfilename = filename
		if bookfilename == "README.md" then
			bookfilename = "index.md"
		end
		local bookfile = book .. "markdown/" .. filedir .. bookfilename

		local outdir = out .. "build/" .. section.file .. ".dir/"
		local outfile = outdir .. "src.md"

		local shiftheadingflag
		if section.level > 1 then
			shiftheadingflag = " --shift-heading-level-by " ..
			    (section.level - 1)
		else
			shiftheadingflag = ""
		end

		local unnumberheadingflag
		if section.level == 0 then
			unnumberheadingflag = " --lua-filter " .. lua ..
			    "unnumber-heading.lua"
		else
			unnumberheadingflag = ""
		end

		local frag = outdir .. ":\n\tmkdir -p $@\n\n" ..
		    outfile .. ": " .. bookfile ..  " | " .. outdir ..
		    "\n\t$(PANDOC) -t markdown -o $@ -f markdown" ..
		    " --resource-path " .. src .. filedir ..
		    " --extract-media " .. outdir ..
		    " --id-prefix " .. filedir .. bookfilename .. "-" ..
		    shiftheadingflag ..
		    unnumberheadingflag ..
		    " --lua-filter " .. lua .. "xref-fixup.lua" ..
		    " --fail-if-warning -- $<\n"

		table.insert(frags, frag)
		table.insert(srcfiles, srcfile)
		table.insert(bookfiles, bookfile)
		table.insert(outfiles, outfile)
	end

	local srcfilesstr = table.concat(srcfiles, " ")
	local bookfilesstr = table.concat(bookfiles, " ")
	local outfilesstr = table.concat(outfiles, " ")

	return "PANDOC?=\tpandoc\n\n" ..
	    bookfilesstr .. ": " .. srcfilesstr ..
	    "\n\tmdbook build\n\n" ..
	    table.concat(frags, "\n") .. "\n" ..
	    out .. "book.pdf: " .. outfilesstr ..
	    "\n\t$(PANDOC) -t pdf -o $@ -f markdown $(PANDOCFLAGS) -- " ..
	    outfilesstr .. "\n"
end
