--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		quiz.lua
--	version:		1.0
--  description:	Tela do quiz.
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

local quiz = composer.getVariable("quiz");
local alternativas = composer.getVariable("alternativas")

local background
local questionGroup
local alternative1
local alternative2
local alternative3

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
local function createBackground(sceneGroup)
	-- Crio o background da cena
  background = display.newImageRect(sceneGroup, "./imagens/game/quiz.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
end

local function quizGoodAlternative(event)
	-- Se o jogador acertar a pergunta, eu somo 0 pontos ao seu score
	local pontos = composer.getVariable("pontos") + 50
	composer.setVariable("pontos", pontos)
	composer.gotoScene("cenas.game")
end

local function quizBadAlternative(event)
	composer.gotoScene("cenas.game")
end

local function loadQuestion(backGroup)
	-- Crio um grupo para carregar os dados da questão
	questionGroup = display.newGroup()
	backGroup:insert(questionGroup)

	-- Guardo o tamanho da tela, para posicionar os componentes
	local _HEIGHT = display.contentHeight / 4
	local _WIDTH = (display.contentWidth - 150) / 2

	-- Crio a pergunta da questão
	local questao = display.newText(questionGroup, quiz.ds_pergunta, display.contentCenterX, 105, "./font/Sniglet-Regular.otf", 42)
  questao.anchorX = 0.5
  questao.anchorY = 0.5
	questao:setFillColor(cores.preto.r, cores.preto.g, cores.preto.b)

  local option = math.random(1, 3)
  if option == 1 then
    alternative1 = display.newText(questionGroup, quiz.ds_resposta, display.contentCenterX, display.contentCenterY - 55, "./font/Sniglet-Regular.otf", 36)
    alternative1:addEventListener("tap", quizGoodAlternative)
    alternative2 = display.newText(questionGroup, alternativas[1].ds_alter, display.contentCenterX, display.contentCenterY + 90, "./font/Sniglet-Regular.otf", 36)
    alternative2:addEventListener("tap", quizBadAlternative)
    alternative3 = display.newText(questionGroup, alternativas[2].ds_alter, display.contentCenterX, display.contentCenterY + 225, "./font/Sniglet-Regular.otf", 36)
    alternative3:addEventListener("tap", quizBadAlternative)
  elseif option == 2 then
    alternative1 = display.newText(questionGroup, alternativas[1].ds_alter, display.contentCenterX, display.contentCenterY - 55, "./font/Sniglet-Regular.otf", 36)
    alternative1:addEventListener("tap", quizBadAlternative)
    alternative2 = display.newText(questionGroup, quiz.ds_resposta, display.contentCenterX, display.contentCenterY + 90, "./font/Sniglet-Regular.otf", 36)
    alternative2:addEventListener("tap", quizGoodAlternative)
    alternative3 = display.newText(questionGroup, alternativas[2].ds_alter, display.contentCenterX, display.contentCenterY + 225, "./font/Sniglet-Regular.otf", 36)
    alternative3:addEventListener("tap", quizBadAlternative)
  else
    alternative1 = display.newText(questionGroup, alternativas[1].ds_alter, display.contentCenterX, display.contentCenterY - 55, "./font/Sniglet-Regular.otf", 36)
    alternative1:addEventListener("tap", quizBadAlternative)
    alternative2 = display.newText(questionGroup, alternativas[2].ds_alter, display.contentCenterX, display.contentCenterY + 90, "./font/Sniglet-Regular.otf", 36)
    alternative2:addEventListener("tap", quizBadAlternative)
    alternative3 = display.newText(questionGroup, quiz.ds_resposta, display.contentCenterX, display.contentCenterY + 225, "./font/Sniglet-Regular.otf", 30)
    alternative3:addEventListener("tap", quizGoodAlternative)
end

  alternative1:setFillColor(cores.preto.r, cores.preto.g, cores.preto.b)
	alternative2:setFillColor(cores.preto.r, cores.preto.g, cores.preto.b)
	alternative3:setFillColor(cores.preto.r, cores.preto.g, cores.preto.b)
end
-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Crio o background
	createBackground(sceneGroup)

	-- Carrega a questão e as alternativas
	loadQuestion(sceneGroup)

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
