-- asciiart from: https://www.asciiart.eu
local M = {}

-- stylua: ignore
M.rand_pool = {
	'camping', 'mountain', 'sunset', 'beach1', 'beach2', 'mushroom',
	'dolphin1', 'dolphin2', 'dog1', 'dog2', 'cat1', 'cat2', 'rains',
}

M.camping = [[
        ______
       /     /\
      /     /  \
     /_____/----\_    (
    "     "          ).
   _ ___          o (:') o
  (@))_))        o ~/~~\~ o
                  o  o  o
]]

M.mountain = [[
        _    .  ,   .           .
    *  / \_ *  / \_      _  *        *   /\'__        *
      /    \  /    \,   ((        .    _/  /  \  *'.
 .   /\/\  /\/ :' __ \_  `          _^/  ^/    `--.
    /    \/  \  _/  \-'\      *    /.' ^_   \_   .'\  *
  /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \
 /  `-.__ ^   / .-'.--\ =-=~_=-=~=^/  _ `--./ .-'  `-
/        `.  / /       `.~-^=-=~=^=.-'      '-._ `._
]]

M.sunset = [[
                   \       /            _\/_
                     .-'-.              //o\  _\/_
  _  ___  __  _ --_ /     \ _--_ __  __ _ | __/o\\ _
=-=-_=-=-_=-=_=-_= -=======- = =-=_=-=_,-'|"'""-|-,_
 =- _=-=-_=- _=-= _--=====- _=-=_-_,-"          |
   =- =- =-= =- = -  -===- -= - ."
]]

M.beach1 = [[
          |
        \ _ /
      -= (_) =-
        /   \         _\/_
          |           //o\  _\/_
   _____ _ __ __ ____ _ | __/o\\ _
 =-=-_-__=_-= _=_=-=_,-'|"'""-|-,_
  =- _=-=- -_=-=_,-"          |
    =- =- -=.--"
]]

M.beach2 = [[
                                        |
                                      \ _ /
                                    -= (_) =-
   .\/.                               /   \
.\\//o\\                      ,\/.      |              ,~
//o\\|,\/.   ,.,.,   ,\/.  ,\//o\\                     |\
  |  |//o\  /###/#\  //o\  /o\\|                      /| \
^^|^^|^~|^^^|' '|:|^^^|^^^^^|^^|^^^""""""""("~~~~~~~~/_|__\~~~~~~~~~~
 .|'' . |  '''""'"''. |`===`|''  '"" "" " (" ~~~~ ~ ~======~~  ~~ ~
    ^^   ^^^ ^ ^^^ ^^^^ ^^^ ^^ ^^ "" """( " ~~~~~~ ~~~~~  ~~~ ~
]]

M.mushroom = [[
                       .-'~~~-.
                     .'o  oOOOo`.
                    :~~~-.oOo   o`.
                     `. \ ~-.  oOOo.
                       `.; / ~.  OO:
                       .'  ;-- `.o.'
                      ,'  ; ~~--'~
                      ;  ;
_______\|/__________\\;_\\//___\|/________
]]

M.rains = [[
        __I__
   .-'"  .  "'-.
 .'  / . ' . \  '.
/_.-..-..-..-..-._\ .---------------------------------.
         #  _,,_   ( I hear it might rain people today )
         #/`    `\ /'---------------------------------'
         / / 6 6\ \
         \/\  Y /\/       /\-/\
         #/ `'U` \       /a a  \               _
       , (  \   | \     =\ Y  =/-~~~~~~-,_____/ )
       |\|\_/#  \_/       '^--'          ______/
       \/'.  \  /'\         \           /
        \    /=\  /         ||  |---'\  \
        /____)/____)       (_(__|   ((__|
]]

M.dolphin1 = [[
                                    _
                               _.-~~.)
         _.--~~~~~---....__  .' . .,'
       ,'. . . . . . . . . .~- ._ (
      ( .. .g. . . . . . . . . . .~-._
   .~__.-~    ~`. . . . . . . . . . . -.
   `----..._      ~-=~~-. . . . . . . . ~-.
             ~-._   `-._ ~=_~~--. . . . . .~.
              | .~-.._  ~--._-.    ~-. . . . ~-.
               \ .(   ~~--.._~'       `. . . . .~-.                ,
                `._\         ~~--.._    `. . . . . ~-.    .- .   ,'/
_  . _ . -~\        _ ..  _          ~~--.`_. . . . . ~-_     ,-','`  .
             ` ._           ~                ~--. . . . .~=.-'. /. `
       - . -~            -. _ . - ~ - _   - ~     ~--..__~ _,. /   \  - ~
              . __ ..                   ~-               ~~_. (  `
)`. _ _               `-       ..  - .    . - ~ ~ .    \    ~-` ` `  `. _
      _ __ . _
]]

M.dolphin2 = [[
                (`.
                 \ `.
                  )  `._..---._
\`.       __...---`         o  )
 \ `._,--'           ,    ___,'
  ) ,-._          \  )   _,-'
 /,'    ``--.._____\/--''
]]

M.dog1 = [[
  __      _
o'')}____//
 `_/      )
 (_(_/-(_/
]]

M.dog2 = [[
           /\___/\
           `)9 9('
           {_:Y:.}_
-----------( )U-'( )----------
           ```   '''
]]

M.cat1 = [[
 |\__/,|   (`\
 |_ _  |.--.) )
 ( T   )     /
(((^_(((/(((_/
]]

M.cat2 = [[
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
]]

---@return table
M.visual = function()
	local logo = {}
	local chars = { '▀▄─', '▄▀─', '▀─▄', '▄─▀' }
	for y = 0, 4 do
		local line = ''
		for _ = 0, 16 do
			line = line .. chars[(y % 4) + 1]
		end
		table.insert(logo, line)
	end
	return logo
end

---@param str string
---@return string
M.normalize_string = function(str)
	local max_len = 0
	-- count max_len
	str:gsub('[^\n]+', function(line)
		max_len = math.max(max_len, #line)
		return ''
	end)

	-- padding
	local template = '%-' .. max_len .. 's'
	local result = str:gsub('[^\n]+', function(line)
		return string.format(template, line)
	end)

	return result
end

---@param name string?
---@return string
M.getHeader = function(name)
	if not name then
		math.randomseed(os.time())
		name = M.rand_pool[math.random(1, #M.rand_pool)]
	end

	local header = M[name]

	if type(header) == 'function' then
		header = header()
	end

	if type(header) == 'string' then
		return M.normalize_string(header)
	elseif type(header) == 'table' then
		return table.concat(header, '\n')
	end

	return ''
end

return M
