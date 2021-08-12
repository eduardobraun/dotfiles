-- TODO: figure out how to bind non global closures to keys
_G.helpers = require('helpers')
require("which-key").load()
require('plugins/_packer')
require('_settings')
require('lsp')
require('_scheme')
