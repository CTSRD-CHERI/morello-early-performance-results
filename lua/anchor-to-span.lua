function Inlines(inlines)
	local openedanchor = false

	local newinlines = {}
	for i, inline in ipairs(inlines) do
		local newinline = inline

		if inline.t == "RawInline" and inline.format == "html" then
			if inline.text == "</a>" then
				if not openedanchor then
					error("Closing non-existent anchor")
				end
				newinline = nil
				openedanchor = false
			else
				if openedanchor then
					error("Unclosed anchor")
				end
				_, _, id =
				    inline.text:find("^<a name=\"([^\"]+)\">$")
				if id ~= nil then
					openedanchor = true
					newinline = pandoc.Span({})
					newinline.identifier = id
				end
			end
		elseif openedanchor then
			error("Unclosed anchor")
		end

		if newinline ~= nil then
			table.insert(newinlines, newinline)
		end
	end

	if openedanchor then
		error("Unclosed anchor")
	end
	return newinlines
end
