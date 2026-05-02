local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- int -> Interface declaration
	s(
		"int",
		fmt(
			[[
interface {} {{
    {}: {};
}}
]],
			{ i(1, "Name"), i(2, "property"), i(3, "type") }
		)
	),

	-- typ -> Type alias
	s("typ", fmt([[type {} = {};]], { i(1, "Name"), i(2, "Type") })),
}
