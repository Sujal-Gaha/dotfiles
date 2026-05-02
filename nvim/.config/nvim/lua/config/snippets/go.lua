local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"err",
		fmt(
			[[
    if err != nil {{
        return {}
    }}
  ]],
			{ i(1, "err") }
		)
	),
	s(
		"main",
		fmt(
			[[
    package main

    import "fmt"

    func main() {{
        {}
    }}
  ]],
			{ i(1, 'fmt.Println("Hello, World!")') }
		)
	),
	s(
		"str",
		fmt(
			[[
    type {} struct {{
        {} {}
    }}
  ]],
			{ i(1, "Name"), i(2, "Field"), i(3, "Type") }
		)
	),
}
