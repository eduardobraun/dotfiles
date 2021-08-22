-- TODO: figure out how to bind non global closures to keys
require('_scheme')
_G.helpers = require('helpers')
require("which-key").load()
require('plugins/_packer')
require('_settings')
require('lsp')
