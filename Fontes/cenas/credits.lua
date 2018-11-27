--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		game.lua
--	version:		1.0
--  description:	Ponto de entrada do game.
--  authors:		Jeidsan A. da C. Pereira (jeidsan.pereira@gmail.com)
--					Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:		2018-09-25
--  modified:		2018-09-25
--	dependencies:	Composer (https://docs.coronalabs.com/guide/system/composer/index.html)
--  ----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Configuração inicial para a cena
-- -----------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplicação
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- -----------------------------------------------------------------------------
-- Variáveis da cena
-- -----------------------------------------------------------------------------
--background1.png
-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
-- Leva o usuário até o menu principal
local function gotoMenu()
  composer.removeScene("cenas.menu")
	composer.gotoScene("cenas.menu", { time=500, effect="crossFade" })
end

local function createBackground(sceneGroup)
  -- Crio o background da cena
  local backgroundScore = display.newImageRect(sceneGroup, "./imagens/backMenu.jpg", display.contentWidth, display.contentHeight)
  backgroundScore.x = display.contentCenterX
  backgroundScore.y = display.contentCenterY
  backgroundScore.alpha = 0.9

  local back = display.newImageRect(sceneGroup, "./imagens/back.png", 130, 130)
  back.x = 130
  back.y = 130
  back.alpha = 0.8
  transition.scaleTo( back, { xScale=1.2, yScale=1.2, time=1000 } )
  back:addEventListener("tap", gotoMenu)

  -- Crio o título
  local logo = display.newText(sceneGroup, "Créditos", display.contentCenterX, 130, "./font/edo.ttf", 130)
  logo.anchorX = 0.5
  logo.anchorY = 0.5
  logo:setFillColor(color.branco.r, color.branco.g, color.branco.b)

  local jeidsan = display.newText(sceneGroup, "Jeidsan A. da C. Pereira", display.contentCenterX, 130, "./font/Sniglet-Regular.otf", 60)
  jeidsan.x = display.contentCenterX
  jeidsan.y = display.contentCenterY - 40
  jeidsan:setFillColor(color.branco.r, color.branco.g, color.branco.b)

  local jeidsanEmail = display.newText(sceneGroup, "(jeidsan.pereira@gmail.com)", display.contentCenterX, 130, "./font/Sniglet-Regular.otf", 60)
  jeidsanEmail.x = display.contentCenterX
  jeidsanEmail.y = display.contentCenterY + 20
  jeidsanEmail:setFillColor(color.branco.r, color.branco.g, color.branco.b)

  local rafaela = display.newText(sceneGroup, "Rafaela Ruchinski", display.contentCenterX, 130, "./font/Sniglet-Regular.otf", 60)
  rafaela.x = display.contentCenterX
  rafaela.y = display.contentCenterY + 150
  rafaela:setFillColor(color.branco.r, color.branco.g, color.branco.b)

  local rafaelaEmail = display.newText(sceneGroup, "(rafaelaruchi@gmail.com)", display.contentCenterX, 130, "./font/Sniglet-Regular.otf", 60)
  rafaelaEmail.x = display.contentCenterX
  rafaelaEmail.y = display.contentCenterY + 210
  rafaelaEmail:setFillColor(color.branco.r, color.branco.g, color.branco.b)

end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  createBackground(sceneGroup);

end

-- Quando a cena está pronta para ser mostrada (phase will) e quando é mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

-- Quando a cena está prestes a ser escondida (phase will) e assim que é escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

-- Quando a cena é destruida
function scene:destroy(event)
	local sceneGroup = self.view
end

-- -----------------------------------------------------------------------------
-- Adicionando os escutadores à cena
-- -----------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------

-- Retorno a cena
return scene
