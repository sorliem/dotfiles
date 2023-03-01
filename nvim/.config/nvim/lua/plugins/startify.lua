return {
	'mhinz/vim-startify',
	config = function()
		vim.cmd [[
			let folder = system('basename $(pwd)')
			let g:startify_custom_header = startify#pad(split(system('figlet -w 100 -f digital ' .. folder), '\n'))

			function! s:gitModified()
				let files = systemlist('git ls-files -m 2>/dev/null')
				return map(files, "{'line': v:val, 'path': v:val}")
			endfunction

			" same as above, but show untracked files, honouring .gitignore
			function! s:gitUntracked()
				let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
				return map(files, "{'line': v:val, 'path': v:val}")
			endfunction

			let g:startify_lists = [
         \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
         \ { 'type': 'files',     'header': ['   MRU']            },
         \ { 'type': 'sessions',  'header': ['   Sessions']       },
         \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
         \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
         \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
         \ { 'type': 'commands',  'header': ['   Commands']       },
			  \]
		]]
	end
}
