local get_params = request('get_formatter_ast.get_params')
local convert = request('!.file.convert')
local get_ast = request('!.lua.code.get_ast')
local formatter_preprocess = request('!.formats.lua.save.formatter.preprocess')

local parse =
  function(s)
    local result
    result = get_ast(s)
    result = formatter_preprocess(result, true) --second parameter is <keep_comments>
    return result
  end

return
  function(args)
    local f_in_name, f_out_name = get_params(args)
    if not f_in_name then
      return
    end
    convert(
      {
        f_in_name = f_in_name,
        f_out_name = f_out_name,
        parse = parse,
      }
    )
  end
