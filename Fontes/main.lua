--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		main.lua
--	version:		1.0
--  description:	Ponto de entrada do game.
--  authors:		Jeidsan A. da C. Pereira (jeidsan.pereira@gmail.com)
--					Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:		2018-09-25
--  modified:		2018-09-25
--	dependencies:	Composer (https://docs.coronalabs.com/guide/system/composer/index.html)
--  ----------------------------------------------------------------------------------------------

-- Carrego o Composer para gerenciamento de cenas
local composer = require("composer")

-- Escondo a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Seto o fundo como branco (temporario)
display.setDefault("background", 1, 1, 1)

-- Seto uma nova semente para o gerador de números aleatórios
math.randomseed(os.time())

-- Defino uma tabela de cores para usar em toda a aplicação
cores =
{
	amarelo   =   { r = 235/255, g = 189/255, b = 18/255 },
	verde     =   { r = 145/255, g = 163/255, b = 41/255 },
	azul      =   { r = 4/255, g = 107/255, b = 138/255 },
	rosa      =   { r = 210/255, g = 23/255, b = 92/255 },
	vermelho  =   { r = 251/255, g = 53/255, b = 76/255},
	preto     =   { r = 0/255, g = 0/255, b = 0/255 },
	branco    =   { r = 255/255, g = 255/255, b = 255/255},
}

-- Chamo a cena do menu
composer.gotoScene("cenas.menu")
--composer.gotoScene("cenas.chefao")