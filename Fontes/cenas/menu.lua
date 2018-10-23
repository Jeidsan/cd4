--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		menu.lua
--	version:		1.0
--  description:	Ponto de entrada do game.
--  authors:		Jeidsan A. da C. Pereira (jeidsan.pereira@gmail.com)
--					Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:		2018-09-25
--  modified:		2018-09-25
--	dependencies:	Composer (https://docs.coronalabs.com/guide/system/composer/index.html)
--  ----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Configura��o inicial para a cena
-- -----------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplica��o
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- -----------------------------------------------------------------------------
-- Vari�veis da cena
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- M�todos e escopo principal da cena
-- -----------------------------------------------------------------------------

-- Leva o usu�rio at� a cena do Jogo
local function gotoGame()
	composer.removeScene("game")
	composer.gotoScene("game", { time=1000, effect="crossFade" })
end

-- Leva o usu�rio at� a cena de pontua��o
local function gotoHighScores()
	composer.removeScene("highscores")
	composer.gotoScene("highscores", { time=1000, effect="crossFade" })
end

-- Leva o usu�rio at� a cena de cr�ditos
local function gotoCredits()
	composer.gotoScene("credits", { time=1000, effect="crossFade" })
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena � criada.
function scene:create(event)
	-- Busco o grupo principal para a cena
	local sceneGroup = self.view

	-- Crio o background da cena	
	local background = display.newImageRect(sceneGroup, "./imagens/back.jpg", 1280, 720)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- Crio a logo go jogo
	local logo = display.newText(sceneGroup, "CD4: The Agent", (display.contentWidth / 10) * 7 , 175, native.systemFont, 75)
	logo:setFillColor(color.branco.r, color.branco.g, color.branco.b, 0.85)
	

	-- Crio as op��es do menu
	local btnPlay = display.newText(sceneGroup, "Novo Jogo", (display.contentWidth / 10) * 7, 325, native.systemFont, 60)
	btnPlay:setFillColor(color.branco.r, color.branco.g, color.branco.b, 0.85)
	btnPlay:addEventListener("tap", gotoGame)

	
	local btnHighScores = display.newText(sceneGroup, "Pontuacao", (display.contentWidth / 10) * 7, 425, native.systemFont, 60)
	btnHighScores:setFillColor(color.branco.r, color.branco.g, color.branco.b, 0.85)
	btnHighScores:addEventListener("tap", gotoHighScores)

	local btnCredits = display.newText(sceneGroup, "Info", (display.contentWidth / 10) * 7, 525, native.systemFont, 60)
	btnCredits:setFillColor(color.branco.r, color.branco.g, color.branco.b, 0.85)
	btnCredits:addEventListener("tap", gotoCredits)

end

-- Quando a cena est� pronta para ser mostrada (phase will) e quando � mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then
	end
end

-- Quando a cena est� prestes a ser escondida (phase will) e assim que � escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then
	end
end

-- Quando a cena � destruida
function scene:destroy(event)
	local sceneGroup = self.view
end

-- -----------------------------------------------------------------------------
-- Adicionando os escutadores � cena
-- -----------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------

-- Retorno a cena
return scene
