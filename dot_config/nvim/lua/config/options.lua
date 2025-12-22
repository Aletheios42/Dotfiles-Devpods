-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true                               --  Escribe el número de linea como :set nu
vim.opt.relativenumber = true                       --  Escribe el número de linea relativo
vim.opt.splitbelow = true                           -- Los nuevos buffers de splits horizontales siempre abajo
vim.opt.splitright = true                           -- Los nuevos buffers de splits verticales siempre izquierda
vim.opt.wrap = false                                -- no apila las lineas largas
vim.opt.expandtab = true                            -- tabs se vuelven espacios
vim.opt.tabstop = 4                                 -- los tabs se ven como 4 espacios
vim.opt.shiftwidth = 4                              -- especifica los espacios que indentan >> << 
vim.opt.clipboard = "unnamedplus"                   -- hace que nvim reconozca el clipboard del sistema
vim.opt.scrolloff = 999                             -- mantiene el cursor en el centro un poco cuestionable ya que porque se puede remapear la navegacion vertical apendizando zz
vim.opt.virtualedit = "block"                       -- Permite que el cursor se mueva a posiciones donde no existe un carácter real
vim.opt.inccommand = "split"                        -- modo interectivo para los comandos de sustitucion (Pantallita con los cambios de :s)
vim.opt.ignorecase = true                           -- Hace que la busqueda de patrones no distinga mayuscula muniscula grep -i
vim.opt.termguicolors = true                        --  para permitir que nvim enseñe por pantalla todos los colores que permita tu terminal
vim.g.mapleader = " "                               -- La tecla para las opciones
vim.opt.path:append "**"                            -- Para que el modo ex incluya archivos en subdirectoririos, genial con find para la búsqueda de archivos
vim.opt.showcmd = true                              -- Muestra el comando que estás escribiendo en la parte inferior derecha

-- Setup diagnostigs
vim.diagnostic.config({
    -- virtual_text = true,                         -- visualización de los mensajes de diagnóstico como texto flotante en lín
    virtual_lines = true,                           -- Los mensajes de diagnóstico se insertan en el búfer como líneas virtuales completas justo después de la línea de código que contiene el problema.
})
