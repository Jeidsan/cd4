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

--  ----------------------------------------------------------------------------------------------
-- Configuração inicial para a cena
--  ----------------------------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplicação
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- Carrego o motor de física
local physics = require("physics")

-- Seto a gravidade como zero para que os objetos não caiam
physics.start()
physics.setGravity(0, 7)

--  ----------------------------------------------------------------------------------------------
-- Variáveis da cena
--  ----------------------------------------------------------------------------------------------

-- Imagens
local imgBackground
local imgJogador
local imgVidas
local imgPerguntas
local imgPontos
local imgAtaque
local imgDefesa

-- Plataforma
local plataforma

-- Textos
local txtVidas
local txtPerguntas
local txtPontos

-- Grupos de objetos
local groupBackground
local groupInformacoes
local groupCenario
local groupJogador
local groupControle

-- Timers
local timerJogador
local timerCenario

-- Tabela para carregar as perguntas
local tablePerguntas = {}

-- Variável para informar se o jogo está pausado.
local flagPausado = true

-- Musica

-- Unidades de referência para os elementos gráficos
local tamanhoIcone = 40
local tamanhoMargem = 40
local tamanhoUnidade = (display.contentWidth / 5) - tamanhoMargem

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

-- Seto ps parâmetros iniciais
composer.setVariable("vidas", 5)
composer.setVariable("perguntas", 0)
composer.setVariable("pontos", 0)
composer.setVariable("ataque", 10)
composer.setVariable("defesa", 10)

-- Cria o plano de fundo da cena e adiciona uma movimentação
local function criarBackground(group)
	-- Crio o background para o jogo e posiciono-o
	--background = display.newImageRect(group, "images/backgroundGame.jpg", 2955, 768)
	--background.x = display.contentCenterY
	--background.y = display.contentCenterY
end

-- Controla o efeito do personagem correndo
local function loopJogador()
	--[[if nrGamer == 1 then
		gamer1.isVisible = true
		gamer2.isVisible = false
		gamer3.isVisible = false
		nrGamer = 2
	elseif nrGamer == 2 then
		gamer1.isVisible = false
		gamer2.isVisible = true
		gamer3.isVisible = false
		nrGamer = 3
	else
		gamer1.isVisible = false
		gamer2.isVisible = false
		gamer3.isVisible = true
		nrGamer = 1
	end]]
end

-- Cria o jogador e trata a sua movimentação
local function criarJogador(group)
	-- Crio o grupo para o jogador
	imgJogador = display.newImageRect(group, "./imagens/samurai.png", 200, 200)
	imgJogador.x = 150
	imgJogador.y = display.contentHeight - 250

	-- Informo que o gamer é do tipo gamer
	imgJogador.type = "gamer"

	-- Adiciono-o ao motor de física
	physics.addBody(imgJogador, "dynamic")  
end

-- Faz o jogador pular
local function pular()
	imgJogador:applyLinearImpulse(0, -7, imgJogador.x, imgJogador.y)
end

-- Faz o jogador atirar
local function atirar()
end

-- Carrega a tabela com as perguntas
local function loadQuestionTable()
	--[[
	-- Carrego a biblioteca JSON para decodificao os dados
	local json = require("json")

	-- Defino o caminho do arquivo de dados
	local dataPath = system.pathForFile("data/data.json", system.ResourceDirectory)

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
		questionTable = json.decode(contents)

		-- TODO: Jeidsan: Tratar caso em que a tabela não contenha dados
	end
	]]
end

local function ajustarTexto(text)
	text = tostring(text)	
	local qtyZeros = 8 - #text
	
	for i = 1, qtyZeros do
		text = "0" .. text
	end
	print(text)
	return text
end

-- Atualiza os textos de pontuação, munição e vidas
local function atualizarInformacoes()
	txtVidas.text = ajustarTexto(composer.getVariable("vidas"))
	txtPerguntas.text = ajustarTexto(composer.getVariable("perguntas"))
	txtPontos.text = ajustarTexto(composer.getVariable("pontos"))
	
	-- TODO: Jeidsan: Atualizar as barras de ataque e de defesa
end

-- Cria o painel de informações do jogo
local function criarGrupoInformacoes(infoGroup)
	-- Cria o ícone das vidas
	imgVidas = display.newImageRect(infoGroup, "./imagens/vidas.png", tamanhoIcone, tamanhoIcone)
	imgVidas.x = tamanhoMargem
	imgVidas.y = tamanhoMargem

	-- Crio o texto para informações sobre a vidas
	local options = { 
		parent = infoGroup, 
		text = ajustarTexto(composer.getVariable("vidas")), 
		x = tamanhoMargem + tamanhoIcone, 
		y = tamanhoMargem,
		font = native.systemFont, 
		fontSize = tamanhoIcone
	}
	txtVidas = display.newText(options)	
	txtVidas:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtVidas.anchorX = 0

	-- Cria o ícone das perguntas
	imgPerguntas = display.newImageRect(infoGroup, "./imagens/pergunta.png", tamanhoIcone, tamanhoIcone)
	imgPerguntas.x = tamanhoMargem
	imgPerguntas.y = 10 + tamanhoMargem + tamanhoIcone

	-- Crio o texto para informações sobre a perguntas
	options = { 
		parent = infoGroup, 
		text = ajustarTexto(composer.getVariable("perguntas")), 
		x = tamanhoMargem + tamanhoIcone, 
		y = 10 + tamanhoMargem + tamanhoIcone, 
		font = native.systemFont, 
		fontSize = tamanhoIcone
	}
	txtPerguntas = display.newText(options)	
	txtPerguntas:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtPerguntas.anchorX = 0
	
	-- Cria o ícone da pontuação
	imgPontos = display.newImageRect(infoGroup, "./imagens/pontos.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
	imgPontos.x = 2 * tamanhoMargem + tamanhoIcone + tamanhoUnidade
	imgPontos.y = 60

	-- Crio o texto para informações sobre pontos
	options = { 
		parent = infoGroup, 
		text = ajustarTexto(composer.getVariable("pontos")), 
		x = 3 * tamanhoMargem + 2 * tamanhoIcone + tamanhoUnidade, 
		y = 65, 
		font = native.systemFont, 
		fontSize = 2 * tamanhoIcone
	}
	txtPontos = display.newText(options)	
	txtPontos:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtPontos.anchorX = 0
	
	-- Cria o ícone do poder de ataque
	imgAtaque = display.newImageRect(infoGroup, "./imagens/ataque.png", tamanhoIcone, tamanhoIcone)
	imgAtaque.x = display.contentWidth - 2 * tamanhoUnidade
	imgAtaque.y = tamanhoMargem

	-- TODO: Jeidsan: Incluir barra de poder de ataque

	-- Cria o ícone do poder de defesa
	imgDefesa = display.newImageRect(infoGroup, "./imagens/defesa.png", tamanhoIcone, tamanhoIcone)
	imgDefesa.x = display.contentWidth - 2 * tamanhoUnidade
	imgDefesa.y = 10 + tamanhoMargem + tamanhoIcone	

	-- TODO: Jeidsan: Incluir barra de poder de defesa
end

-- Cria o cenário
local function criarGrupoCenario(group)
	-- Crio a plataforma
	plataforma = display.newLine(group, 0, display.contentHeight - 155, display.contentWidth, display.contentHeight - 155)
	plataforma.anchorY = 0
	plataforma:setStrokeColor(0,0,0, 1)
	plataforma.strokeWidth = 2
	physics.addBody(plataforma, "static")
end

local function gotoMenu()
  composer.gotoScene("cenas.menu")
end

-- Cria o grupo de controles
local function criarGrupoControle(group)
  -- Cria o botão para pular
  local btnPular = display.newImageRect(group, "./imagens/pular.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnPular.x = 3 * tamanhoMargem
  btnPular.y = display.contentHeight - 2 * tamanhoMargem
  btnPular:addEventListener("tap", pular)
  
  -- Cria o botão de atirar 
  local btnAtirar = display.newImageRect(group, "./imagens/ataque.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnAtirar.x = display.contentWidth - 3 * tamanhoMargem
  btnAtirar.y = display.contentHeight - 2 * tamanhoMargem
  btnAtirar:addEventListener("tap", atirar)

  -- Cria o botão fechar 
  local btnFechar = display.newImageRect(group, "./imagens/fechar.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnFechar.x = display.contentCenterX
  btnFechar.y = display.contentHeight - 100
  btnFechar:addEventListener("tap", gotoMenu)
end

-- Cria os objetos
local function criarObjeto(tipoObjeto)
	-- Crio o inimigo
	local objeto = display.newImageRect(groupCenario, "./imagens/" .. tipoObjeto .. ".png", 100, 100)

	-- Posiciono o inimigo fora da tela
	objeto.x = display.contentWidth + 100 
	if tipoObjeto == "inimigo" then
		objeto.y = display.contentHeight - 250
	else
		objeto.y = 250
	end

	-- Defino o tipo do objeto
	objeto.type = tipoObjeto

	-- Submeto o objeto à ação da física
	physics.addBody(objeto, "dynamic")

	-- Impulsiono o obstáculo em direção ao jogador
	transition.to(objeto, { x = -100, y = objeto.y, time = 4000, onComplete = function() display.remove(objeto) end})
end
-- Implementa o loop do jogo
local function gameLoop()
	-- Sorteio o objeto que será criado
	local objectType = math.random(1, 6)

	-- Crio o objeto conforme sorteio
	if objectType <= 3 then
		criarObjeto("inimigo")
	elseif objectType == 4 then
		criarObjeto("pergunta")
	elseif objectType == 5 then
		criarObjeto("ataque")
	else
		criarObjeto("defesa")
	end
end

local function gameOver()
  -- Manda para a proxima cena a pontuaçao total
	composer.setVariable("score", txtScore.text)

  --Muda de cena - Fim de Jogo
  composer.gotoScene("cenas.gameover")
end

-- Trata das colisões com os obstáculos
local function obstacleCollision(obj1, obj2)
  local lives = composer.getVariable("lives") - 1
  composer.setVariable("lives", lives)
  updateText()

  if obj1.type == "obstacle" then
    display.remove(obj1)
  else
    display.remove(obj2)
  end

  if lives == 0 then
    gameOver()
  end
end

-- Trata da colisão com as questões
local function questionCollision(obj1, obj2)
  -- Pauso o jogo
  gamePaused = true;

  --Sorteio o tipo de quiz que irá aparecer
  local quizType = math.random(1, 3)
  local inicio
  local fim

  if quizType <= 2 then
    inicio = 1
    fim = 26
  else
    inicio = 27
    fim = #questionTable
  end

  -- Sorteio uma das questões e asalternativas
  local nrQuestion, alt1, alt2, alt3

  while (nrQuestion == alt1) or (nrQuestion == alt2) or (nrQuestion == alt3) or (alt1 == alt2) or (alt1 == alt3) or (alt2 == alt3) do
      nrQuestion, alt1, alt2, alt3 = math.random(inicio, fim), math.random(inicio, fim), math.random(inicio, fim), math.random(inicio, fim)
  end

  local alts = {
    {
      nm_imagem = questionTable[alt1].nm_imagem,
      ds_resposta = questionTable[alt1].ds_resposta
    },
    {
      nm_imagem = questionTable[alt2].nm_imagem,
      ds_resposta = questionTable[alt2].ds_resposta
    },
    {
      nm_imagem = questionTable[alt3].nm_imagem,
      ds_resposta = questionTable[alt3].ds_resposta
    },
  }

  local quiz = questionTable[nrQuestion]

  -- Carrego a questão na variável com composer
  composer.setVariable("quiz", quiz)
  composer.setVariable("alternativas", alts)

  if quizType == 1 then
    composer.removeScene("quizImagem")
    composer.gotoScene("quizImagem", { time=1000, effect="crossFade" })
  elseif quizType == 2 then
    composer.removeScene("quizTipo")
    composer.gotoScene("quizTipo", { time=1000, effect="crossFade" })
  else
    composer.removeScene("quizPergunta")
    composer.gotoScene("quizPergunta", { time=1000, effect="crossFade" })
  end
end

-- Trata da colisão com bonus
local function bonusCollision(obj1, obj2)
  -- Adiciono os pontos para o jogador
  composer.setVariable("score", composer.getVariable("score") + 10)
  updateText()

  -- Apago o bonus
  display.remove(obj2)
end

-- Trata a colisão entre objetos
local function onCollision(event)
  if (not gamePaused) then
    -- Verifico se é o início da colisão com a phase "began"
    if ( event.phase == "began" ) then
      -- Capturo os objetos que colidiram
      local obj1 = event.object1
      local obj2 = event.object2

      -- Testo as colisões que preciso tratar
      if (obj1.type == "gamer" and obj2.type == "obstacle") or (obj1.type == "obstacle" and obj2.type == "gamer") then
        obstacleCollision(obj1, obj2)
      elseif (obj1.type == "gamer" and obj2.type == "question") or (obj1.type == "question" and obj2.type == "gamer") then
        questionCollision(obj1, obj2)
      elseif (obj1.type == "gamer" and obj2.type == "bonus") or (obj1.type == "bonus" and obj2.type == "gamer") then
        bonusCollision(obj1, obj2)
      end
    end
  end
end

Runtime:addEventListener("collision", onCollision)

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
	-- Busco o grupo principal para a cena
	local sceneGroup = self.view

	-- Pauso a física temporareamente
	physics.pause()

	-- Crio o grupo de background e adiciono ao grupo da cena
	groupBackground = display.newGroup()
	sceneGroup:insert(groupBackground)
	criarBackground(groupBackground)

	-- Crio o grupo do cenário e adiciono ao grupo da cena
	groupCenario = display.newGroup()
	sceneGroup:insert(groupCenario)
	criarGrupoCenario(groupCenario)

	-- Crio o grupo de informações e adiciono ao grupo da cena
	groupInformacoes = display.newGroup()
	sceneGroup:insert(groupInformacoes)
	criarGrupoInformacoes(groupInformacoes)

	-- Crio um grupo para o jogador r adiciono ao grupo da cena
	groupJogador = display.newGroup()
	sceneGroup:insert(groupJogador)
	criarJogador(groupJogador)

	-- Crio o grupo de Controles e adiciono ao grupo da cena
	groupControle = display.newGroup()
	sceneGroup:insert(groupControle)
	criarGrupoControle(groupControle)

	-- Carrego as questões
	loadQuestionTable()
end

-- Quando a cena está pronta para ser mostrada (phase will) e quando é mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Reinicio o jogo
		gamePaused = false

		-- Reinicio o motor de física
		physics.start()

		-- Programo o loop do jogo para executar a cada 500ms
		gameLoopTimer = timer.performWithDelay(1500, gameLoop, 0)

		-- Programo o loop do jogador para executar a cada segundo
		gamerLoopTimer = timer.performWithDelay(100, gamerLoop, 0)

		-- Atualizo o texto da pontuação
		atualizarInformacoes()
	end
end

-- Quando a cena está prestes a ser escondida (phase will) e assim que é escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
    -- Paro os temporizadores
		timer.cancel(gameLoopTimer)
    timer.cancel(gamerLoopTimer)

	elseif ( phase == "did" ) then
    -- Pauso o jogo
    gamePaused = true

    -- Removo a detecção de colisões
    Runtime:removeEventListener("colision", onCollision)

    -- Pauso o motor de física
    physics.pause()
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