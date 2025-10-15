local _2afile_2a = "fnl/conjure-tapdance/main.fnl"
local _2amodule_name_2a = "conjure-tapdance.main"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("conjure-tapdance.aniseed.autoload")).autoload
local a, eval, extract, nvim, text = autoload("conjure-tapdance.aniseed.core"), autoload("conjure.eval"), autoload("conjure.extract"), autoload("conjure-tapdance.aniseed.nvim"), autoload("conjure.text")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["extract"] = extract
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["text"] = text
local function tap_str(code)
  return a.str("(tap> ", code, ")")
end
_2amodule_locals_2a["tap-str"] = tap_str
local function tap(code, range, origin)
  if not a["empty?"](code) then
    local code0 = tap_str(code)
    local e = {code = code0, range = range, origin = origin}
    return eval["eval-str"](e)
  else
    return nil
  end
end
_2amodule_2a["tap"] = tap
local function tap_word()
  local _let_2_ = extract.word()
  local content = _let_2_["content"]
  local range = _let_2_["range"]
  return tap(content, range, "word")
end
_2amodule_2a["tap-word"] = tap_word
local function tap_form()
  local _let_3_ = extract.form({})
  local content = _let_3_["content"]
  local range = _let_3_["range"]
  return tap(content, range, "form")
end
_2amodule_2a["tap-form"] = tap_form
local function tap_visual()
  local _let_4_ = extract.selection({kind = nvim.fn.visualmode(), ["visual?"] = true})
  local content = _let_4_["content"]
  local range = _let_4_["range"]
  return tap(content, range, "selection")
end
_2amodule_2a["tap-visual"] = tap_visual
local function tap__2aexc()
  return tap("*e", nil, "*e")
end
_2amodule_2a["tap-*exc"] = tap__2aexc
local function on_filetype()
  local function _5_()
    return tap_form()
  end
  nvim.buf_create_user_command(0, "TapForm", _5_, {desc = "Tap the form under the cursor"})
  local function _6_()
    return tap_word()
  end
  nvim.buf_create_user_command(0, "TapWord", _6_, {desc = "Tap the symbol under the cursor"})
  local function _7_()
    return tap_visual()
  end
  nvim.buf_create_user_command(0, "TapV", _7_, {range = true, desc = "Tap the selection"})
  local function _8_()
    return tap__2aexc()
  end
  return nvim.buf_create_user_command(0, "TapExc", _8_, {desc = "Tap *e"})
end
_2amodule_2a["on-filetype"] = on_filetype
local function init()
  local group = vim.api.nvim_create_augroup("tapdance_init_filetypes", {})
  return vim.api.nvim_create_autocmd("FileType", {group = group, pattern = "clojure", callback = on_filetype})
end
_2amodule_2a["init"] = init
--[[ (on-filetype) ]]
return _2amodule_2a