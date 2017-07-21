set nocompatible
filetype off

"let g:EasyMotion_do_mapping=0 "Disable default mappings

"let g:EasyMotion_leader_key='<Leader>'

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding. `s{char}{label}`
""nmap s <Plug>(easymotion-overwin-f)
"or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
""nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
" "let g:EasyMotion_smartcase = 1

" JK motions: Line motions
""map <Leader>j <Plug>(easymotion-j)
""map <Leader>k <Plug>(easymotion-k) 
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" let Vundle manage Vundle
"Plugin 'VundleVim/Vundle.vim'
"" put some nice plugins here...
"Plugin 'scrooloose/nerdtree'

""call vundle#end()
" "filetype plugin indent on
" Brief help
" :PluginList		- lists configured plugins
" :PluginInstall	- installs plugins; append '!' to update
" 			  or just :Pluginupdate
" :PluginSearch foo	- searches for foo; append '!' refreshes local cache
" :PluginClean		- confirm removal of unused plugins;
" 			- append '!' to auto-approve removal
" :h vundle for more details
" allow backspacing over everything in insert mode
set backspace=2

" if has("vms")
  " set noackup		" do not keep a backup file, use versions instead
" else
  " set backup		" keep a backup file (restore to previous version)
  " set undofile		" keep an undo file (undo changes after closing)
" endif
set history=50		" keep 50 lines of command line history
set ruler		"ru"	show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		"is"	do incremental searching
set hlsearch
set number		"nu"	show line numbers
set ignorecase		"ic"	set ignore case on searching 
set smartcase		"smc"	override ignorecase if uppercase letters given
set wrap
set smartindent		"si"
set relativenumber	"rnu"
"set nowrapscan		"ws"

" set tabwidth
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
" set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  set formatoptions+=t

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
"
" key mappings for moving between splits without prefix nnoremap <C-H> <C-W><C-H>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" key mappings for moving lines up and down
" nnoremap <C-S-j> :m.+1<CR>==
" nnoremap <C-S-k> :m.-2<CR>==
" inoremap <C-S-j> <Esc>:m.+1<CR>==gi
" inoremap <C-S-k> <Esc>:m.-2<CR>==gi
" vnoremap <C-S-j> :m'>+1<CR>gv=gv
" vnoremap <C-S-k> :m'<-2<CR>gv=gv
"

" Tab Mappings with Alt
set <M-1>=1
set <M-2>=2
set <M-3>=3
set <M-4>=4
set <M-5>=5
set <M-6>=6
set <M-7>=7
set <M-8>=8
set <M-9>=9
nmap <M-1> 1gt
nmap <M-2> 2gt
nmap <M-3> 3gt
nmap <M-4> 4gt
nmap <M-5> 5gt
nmap <M-6> 6gt
nmap <M-7> 7gt
nmap <M-8> 8gt
nmap <M-9> 9gt

" provide hjkl movements in Insert mode via the <Alt> modifier key
set <M-h>=h
set <M-j>=j
set <M-k>=k
set <M-l>=l
inoremap <M-h> <left>
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-l> <right>

set splitbelow
set splitright

inoremap jk <esc>

set timeoutlen=1000 ttimeoutlen=0

if $TERM == "xterm-256color"
	set t_Co=8
endif

" set colorscheme
colorscheme industry "nice bright colorscheme

" show a vertical line at 80 character
hi ColorColumn ctermbg=DarkGrey
" let &colorcolumn="80,".join(range(81,300),",")
set colorcolumn=80

" set line number colors
hi LineNr ctermfg=darkgrey ctermbg=darkgrey 
hi CursorLineNr ctermfg=yellow ctermbg=darkgrey 

" highlight current line
set cursorline
hi CursorLine cterm=NONE term=NONE ctermbg=darkgrey ctermfg=NONE
hi Normal ctermbg=none

" colors
hi Pmenu ctermbg=DarkGrey ctermfg=DarkGrey
hi PmenuSel ctermbg=DarkGrey ctermfg=Yellow
hi PmenuSbar ctermbg=DarkGrey
hi PmenuThumb ctermbg=Yellow
hi VertSplit cterm=bold ctermbg=DarkGrey ctermfg=DarkGrey
hi StatusLine cterm=bold ctermbg=DarkGrey ctermfg=White
hi StatusLineNC cterm=NONE ctermbg=DarkGrey ctermfg=DarkGrey
hi TablineSel cterm=bold ctermbg=DarkGrey ctermfg=White
hi Tabline cterm=NONE ctermbg=DarkGrey ctermfg=DarkGrey
hi TabLineFill cterm=NONE ctermbg=NONE ctermfg=NONE
hi ErrorMsg cterm=bold ctermbg=none ctermfg=Red
hi Error cterm=underline ctermbg=none ctermfg=Darkred
hi Todo ctermfg=Yellow ctermbg=Yellow
hi Statement ctermfg=Blue ctermbg=none 
hi Constant cterm=NONE ctermfg=DarkGreen ctermbg=NONE
hi Visual cterm=NONE ctermfg=DarkGrey ctermbg=DarkGrey

set fillchars+=vert:\  " removes the | in vertical split bar

" Map key to toggle opt
function MapToggle(key, opt)
	let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
	exec 'nnoremap '.a:key.' '.cmd
	exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Display-altering option toggles
MapToggle <F2> wrap
MapToggle <F3> list

" Behavior-altering option toggles
MapToggle <F10> scrollbind
MapToggle <F11> ignorecase
MapToggle <F12> paste
set pastetoggle=<F12>

inoremap { {}<ESC>i
inoremap {<CR> {<CR>}<ESC>O
" inoremap ( ()<esc>i
" inoremap [ []<esc>i
inoremap < <
inoremap <<tab> <><esc>i
inoremap (<tab> ()<CR>{<CR>}<esc>2kf(a
inoremap "<tab> ""<esc>i
inoremap '<tab> ''<esc>i
inoremap `<tab> ``<esc>i

inoremap <C-e> <esc>?[(){}"'\[\]>;:,.\|\`]<CR>:nohl<CR>lR
inoremap <C-f> <esc>/[(){}"'\[\]>;:,.\|\`]<CR>:nohl<CR>lR
inoremap <C-j> <esc>/[(){}"'\[\]>;:,.\|\`]<CR>:nohl<CR>a
inoremap <C-k> <esc>?[(){}"'\[\]>;:,.\|\`]<CR>:nohl<CR>a
inoremap <C-l> <esc>A
" inoremap <C-o> <esc>:w<CR>i

nnoremap ci< f<lct>
nnoremap ca< f<lca>
nnoremap ci( f(cib
nnoremap ca( f(cab
nnoremap ci[ f[ci]
nnoremap ca[ f[ca]
nnoremap ci{ /{<CR>ciB
nnoremap ca{ /{<CR>caB

nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

nnoremap \d "+d
nnoremap \D "+D
vnoremap \d "+d
vnoremap \D "+D

nnoremap \y "+y
nnoremap \Y "+Y
vnoremap \y "+y
vnoremap \Y "+Y

nnoremap \p "+p
nnoremap \P "+P
vnoremap \p "+p
vnoremap \P "+P

vnoremap \( <esc>`>a)<esc>`<i(<esc>
vnoremap \[ <esc>`>a]<esc>`<i[<esc>
vnoremap \< <esc>`>a><esc>`<i<<esc>
vnoremap \" <esc>`>a"<esc>`<i"<esc>
vnoremap \' <esc>`>a'<esc>`<i'<esc>
vnoremap \<cr> <esc>`>a<cr><esc>`<i<cr><esc>
vnoremap \<space> <esc>`>a<space><esc>`<i<space><esc>
vnoremap _c <esc>`>a*/<esc>`<^i/*<esc>
vnoremap ck <esc>`>a*/<esc>`<^i/*<esc>
vnoremap _u <esc>`>xx`<^2x<esc>
vnoremap nc <esc>`>xx`<^2x<esc>

inoremap syso System.out.println();<esc>2ha
inoremap sysf System.out.printf();<esc>2ha 
inoremap sysef System.err.printf();<esc>2ha  
inoremap sysel System.err.println();<esc>2ha 
inoremap dpdb Double.parseDouble()<esc>i
inoremap ipin Integer.parseInt()<esc>i
inoremap lpln Long.parseLong()<esc>i

inoremap intf<tab> int ()<CR>{<CR>}<ESC>2kf(i
inoremap voidf<tab> void ()<CR>{<CR>}<ESC>2kf(i
inoremap doublef<tab> double ()<CR>{<CR>}<ESC>2kf(i
inoremap longf<tab> long ()<CR>{<CR>}<ESC>2kf(i

inoremap main<tab> public static void main (String args[]) {<CR>}<ESC>O
inoremap mntr<tab> public static void main (String args[])<CR>throws<space>
inoremap run<tab> public void run () {<CR>}<ESC>O
inoremap try<tab> try {<CR>} catch ()<ESC>O
inoremap do<tab> do<space>{<CR>}<space>while();<ESC>O
inoremap if<tab> if() {<CR>}<esc>kf(a
inoremap if[<tab> if<space>[[<space><space>]]<cr>then<cr>fi<esc>2kf[2la
inoremap swi<tab> switch() {<CR>}<esc>kf(a
inoremap el<tab> else
inoremap elif<tab> else<space>if()<esc>i
inoremap elif[<tab> elif<space>[[<space><space>]]<cr>then<esc>kf[2la
inoremap whi<tab> while() {<CR>}<esc>kf(a
inoremap for<tab> for(;;) {<CR>}<esc>kf(a

inoremap cmn<tab> int main(int argc, char** argv)<CR>{<CR>}<ESC>O
inoremap #ifn<tab> #ifndef <CR>#endif<esc>kA
inoremap #if<tab> #ifdef <CR>#endif<esc>kA

inoremap <Nul> <C-n>

" normal mode commands as aliases for long ex commands
nnoremap tide :w !tide<space>

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"
"" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=50
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

set lazyredraw
