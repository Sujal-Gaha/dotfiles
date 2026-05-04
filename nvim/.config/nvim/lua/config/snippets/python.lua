local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- main -> if __name__ == "__main__":
	s(
		"main",
		fmt(
			[[
if __name__ == "__main__":
    {}
]],
			{ i(1, "main()") }
		)
	),

	-- def -> Function definition with docstring
	s(
		"def",
		fmt(
			[[
def {}({}):
    """{}"""
    {}
]],
			{ i(1, "function_name"), i(2, "args"), i(3, "Docstring"), i(4, "pass") }
		)
	),

	-- trye -> try-except block
	s(
		"trye",
		fmt(
			[[
try:
    {}
except {}:
    {}
]],
			{ i(1, "pass"), i(2, "Exception"), i(3, "raise") }
		)
	),
}
