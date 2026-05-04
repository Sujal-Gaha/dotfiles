local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- clg -> console.log(...)
	s("clg", fmt([[console.log({});]], { i(1, "value") })),

	-- afn -> Arrow Function
	s(
		"afn",
		fmt(
			[[
const {} = ({}) => {{
    {}
}};
]],
			{ i(1, "name"), i(2, "args"), i(3, "// body") }
		)
	),

	-- tryc -> try-catch block
	s(
		"tryc",
		fmt(
			[[
      try {{
        {}
      }} catch (e) {{
        {}
      }}
      ]],
			{ i(1, "body"), i(2, "error") }
		)
	),
}
