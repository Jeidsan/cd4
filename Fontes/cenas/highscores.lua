--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		quiz.lua
--	version:		1.0
--  description:	Pontuação adquirida.
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

local scoresTable = {}

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
-- Função que carrega os dados da tabela
function loadScore()
	-- Carrego a biblioteca JSON para decodificao os dados
  local json = require("json")

  -- Defino o caminho do arquivo de dados
  local dataPath = system.pathForFile("data/scores.json", system.ResourceDirectory)

  -- Carrego o arquivo de dados na variável file (errorString irá indicar se houve erro)
  local file, errorString = io.open(dataPath, "r")

  -- Carrego os dados na tabela
  if not file then
    -- TODO: Jeidsan: Tratar o caso de erro ao carregar arquivo
  else
    -- Carrego os dados do arquivo
    local contents = file:read("*a")
    io.close(file)

    -- Converto os dados de JSON para o formato de tabela de Lua
    scoresTable = json.decode(contents)

    if (scoresTable == nil or #scoresTable == 0) then
      scoresTable = { 50, 40, 30, 20, 10 }
    end
  end
end

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
  local logo = display.newText(sceneGroup, "Recordes", display.contentCenterX, 130, "./font/edo.ttf", 130)
  logo.anchorX = 0.5
  logo.anchorY = 0.5
  logo:setFillColor(color.branco.r, color.branco.g, color.branco.b)

  local textHeight = 260;

  --Preencho os pontos na tela
  for i = 1, 5 do
    -- Se a posição não estiver nula
    if (scoresTable[i]) then
      -- crio um novo texto para inserir
      local center = display.newText(sceneGroup, scoresTable[i], display.contentCenterX, textHeight, "./font/Sniglet-Regular.otf", 70)
      center:setFillColor(color.branco.r, color.branco.g, color.branco.b)
      center.anchorX = 0.5

      --Incremnento a posição do texto
      textHeight = textHeight + 80
    end
  end
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Carrego os dados de scores
  loadScore()

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
