
function! Dot(path)
  return "~/.config/nvim/" . a:path
endfunction

execute "source" Dot("settings.vim")
execute "source" Dot("plugins.vim")

for file in split(glob(Dot("modules/*.vim")), "\n")
  execute "source" file
endfor










