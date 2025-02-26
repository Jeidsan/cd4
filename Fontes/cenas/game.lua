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
-- Configura��o inicial para a cena
--  ----------------------------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplica��o
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- Carrego o motor de f�sica
local physics = require("physics")

-- Seto a gravidade como zero para que os objetos n�o caiam
physics.start()
physics.setGravity(0, 20)

--  ----------------------------------------------------------------------------------------------
-- Vari�veis da cena
--  ----------------------------------------------------------------------------------------------

-- Imagens
local imgBackground
local imgJogador
local imgJogador1
local imgJogador2
local imgJogador3
local imgJogador4
local imgJogador5
local imgJogador6
local imgJogador7
local imgJogador8
local imgJogador9
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
local questionTable = {}

-- Vari�vel para informar se o jogo est� pausado.
local flagPausado = true

-- Musica

-- Unidades de refer�ncia para os elementos gr�ficos
local tamanhoIcone = 40
local tamanhoMargem = 40
local tamanhoUnidade = (display.contentWidth / 5) - tamanhoMargem

-- Par�metros para definir a dificuldade do jogo
local danoJogador = 1 --composer.getVariable("danoJogador")
local danoInimigo = 2 --composer.getVariable("danoInimigo")
local bonusDefesa = 10 --composer.getVariable("bonusDefesa")
local bonusAtaque = 25 --composer.getVariable("bonusAtaque")
local quantidadeInimigos = 15 --composer.getVariable("quantidadeInimigos")

composer.setVariable("vidas", 5)
local vidas = composer.getVariable("vidas")

composer.setVariable("perguntas", 0)
local perguntas = composer.getVariable("perguntas")

composer.setVariable("pontos", 0)
local pontos = composer.getVariable("pontos")

composer.setVariable("ataque", 100)
local ataque = composer.getVariable("ataque")

composer.setVariable("defesa", 10)
local defesa = composer.getVariable("defesa")

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

local function criarBackground(group)
	-- Crio o background para o jogo e posiciono-o
	background = display.newImageRect(group, "./imagens/game/background1.png", 2955, 768)
	background.x = display.contentCenterY
	background.y = display.contentCenterY
	background.alpha = 0.6
end

local function loopJogador()
	if nrGamer == 1 then
		imgJogador1.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador4.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 2
	elseif nrGamer == 2 then
		imgJogador2.isVisible = true
		imgJogador.isVisible, imgJogador1.isVisible, imgJogador3.isVisible, imgJogador4.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 3
	elseif nrGamer == 3 then
		imgJogador3.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador1.isVisible, imgJogador4.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 4
	elseif nrGamer == 4 then
		imgJogador4.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 5
	elseif nrGamer == 5 then
		imgJogador5.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador4.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 6
	elseif nrGamer == 6 then
		imgJogador6.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador5.isVisible, imgJogador4.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 7
	elseif nrGamer == 7 then
		imgJogador7.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador4.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 8
	elseif nrGamer == 8 then
		imgJogador8.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador4.isVisible, imgJogador9.isVisible = false
		nrGamer = 9
	elseif nrGamer == 9 then
		imgJogador9.isVisible = true
		imgJogador.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador1.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador4.isVisible, imgJogador8.isVisible = false
		nrGamer = 0
	else
		imgJogador.isVisible = true
		imgJogador1.isVisible, imgJogador2.isVisible, imgJogador3.isVisible, imgJogador4.isVisible, imgJogador5.isVisible, imgJogador6.isVisible, imgJogador7.isVisible, imgJogador8.isVisible, imgJogador9.isVisible = false
		nrGamer = 1
	end
end

local function criarJogador(group)
	imgJogador = display.newImageRect(group, "./imagens/jogador/0.png", 300, 300, 50)
	imgJogador.x = 100
	imgJogador.y = display.contentHeight - 200
	imgJogador.type = "jogador"

	imgJogador1 = display.newImageRect(group, "./imagens/jogador/1.png", 300, 300, 50)
	imgJogador1.x = 100
	imgJogador1.y = display.contentHeight - 200
	imgJogador1.type = "jogador"

	imgJogador2 = display.newImageRect(group, "./imagens/jogador/2.png", 300, 300, 50)
	imgJogador2.x = 100
	imgJogador2.y = display.contentHeight - 200
	imgJogador2.type = "jogador"

	imgJogador3 = display.newImageRect(group, "./imagens/jogador/3.png", 300, 300, 50)
	imgJogador3.x = 100
	imgJogador3.y = display.contentHeight - 200
	imgJogador3.type = "jogador"

	imgJogador4 = display.newImageRect(group, "./imagens/jogador/4.png", 300, 300, 50)
	imgJogador4.x = 100
	imgJogador4.y = display.contentHeight - 200
	imgJogador4.type = "jogador"

	imgJogador5 = display.newImageRect(group, "./imagens/jogador/5.png", 300, 300, 50)
	imgJogador5.x = 100
	imgJogador5.y = display.contentHeight - 200
	imgJogador5.type = "jogador"

	imgJogador6 = display.newImageRect(group, "./imagens/jogador/6.png", 300, 300, 50)
	imgJogador6.x = 100
	imgJogador6.y = display.contentHeight - 200
	imgJogador6.type = "jogador"

	imgJogador7 = display.newImageRect(group, "./imagens/jogador/7.png", 300, 300, 50)
	imgJogador7.x = 100
	imgJogador7.y = display.contentHeight - 200
	imgJogador7.type = "jogador"

	imgJogador8 = display.newImageRect(group, "./imagens/jogador/8.png", 300, 300, 50)
	imgJogador8.x = 100
	imgJogador8.y = display.contentHeight - 200
	imgJogador8.type = "jogador"

	imgJogador9 = display.newImageRect(group, "./imagens/jogador/9.png", 300, 300, 50)
	imgJogador9.x = 100
	imgJogador9.y = display.contentHeight - 200
	imgJogador9.type = "jogador"

	physics.addBody(imgJogador, "static")
	physics.addBody(imgJogador1, "static")
	physics.addBody(imgJogador2, "static")
	physics.addBody(imgJogador3, "static")
	physics.addBody(imgJogador4, "static")
	physics.addBody(imgJogador5, "static")
	physics.addBody(imgJogador6, "static")
	physics.addBody(imgJogador7, "static")
	physics.addBody(imgJogador8, "static")
	physics.addBody(imgJogador9, "static")
end

-- Faz o jogador pular
local function subir()
	imgJogador.x = 100
	imgJogador1.x = 100
	imgJogador2.x = 100
	imgJogador3.x = 100
	imgJogador4.x = 100
	imgJogador5.x = 100
	imgJogador6.x = 100
	imgJogador7.x = 100
	imgJogador8.x = 100
	imgJogador9.x = 100
	imgJogador.y =  280
	imgJogador1.y = 280
	imgJogador2.y = 280
	imgJogador3.y = 280
	imgJogador4.y = 280
	imgJogador5.y = 280
	imgJogador6.y = 280
	imgJogador7.y = 280
	imgJogador8.y = 280
	imgJogador9.y = 280
end

-- Faz o jogador pular
local function descer()
	imgJogador.x = 100
	imgJogador1.x = 100
	imgJogador2.x = 100
	imgJogador3.x = 100
	imgJogador4.x = 100
	imgJogador5.x = 100
	imgJogador6.x = 100
	imgJogador7.x = 100
	imgJogador8.x = 100
	imgJogador9.x = 100
	imgJogador.y = display.contentHeight - 200
	imgJogador1.y = display.contentHeight - 200
	imgJogador2.y = display.contentHeight - 200
	imgJogador3.y = display.contentHeight - 200
	imgJogador4.y = display.contentHeight - 200
	imgJogador5.y = display.contentHeight - 200
	imgJogador6.y = display.contentHeight - 200
	imgJogador7.y = display.contentHeight - 200
	imgJogador8.y = display.contentHeight - 200
	imgJogador9.y = display.contentHeight - 200
end

local function ajustarTexto(text)
	text = tostring(text)
	local qtyZeros = 8 - #text
	for i = 1, qtyZeros do
		text = "0" .. text
	end
	return text
end

local function loadQuestionTable()
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
end

local function atualizarInformacoes()
	txtVidas.text = ajustarTexto(vidas)
	txtPerguntas.text = ajustarTexto(perguntas)
	txtPontos.text = ajustarTexto(pontos)
	txtAtaque.text = ajustarTexto(ataque)
	txtDefesa.text = ajustarTexto(defesa)
end

local function atirar()
	if (ataque > 0) then
		local bala = display.newImageRect("./imagens/bala.png", 50, 50)
		physics.addBody(bala, "static", { isSensor = true } )    
		bala.type = "bala"
		bala.x = imgJogador.x
		bala.y = imgJogador.y	

		transition.to(bala, { x = display.contentWidth + 50, time = 500, onComplete = function() display.remove(bala) end })
		ataque = ataque - 1
		atualizarInformacoes()
	end
end

-- Cria o painel de informações do jogo
local function criarGrupoInformacoes(infoGroup)
	-- Cria o ícone das vidas
	imgVidas = display.newImageRect(infoGroup, "./imagens/vidas.png", tamanhoIcone, tamanhoIcone)
	imgVidas.x = tamanhoMargem
	imgVidas.y = tamanhoMargem

	-- Crio o texto para informa��es sobre a vidas
	local options = {
		parent = infoGroup,
		text = ajustarTexto(vidas),
		x = tamanhoMargem + tamanhoIcone,
		y = tamanhoMargem,
		font = native.systemFont,
		fontSize = tamanhoIcone
	}
	txtVidas = display.newText(options)
	txtVidas:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtVidas.anchorX = 0

	-- Cria o �cone das perguntas
	imgPerguntas = display.newImageRect(infoGroup, "./imagens/pergunta.png", tamanhoIcone, tamanhoIcone)
	imgPerguntas.x = tamanhoMargem
	imgPerguntas.y = 10 + tamanhoMargem + tamanhoIcone

	-- Crio o texto para informa��es sobre a perguntas
	options = {
		parent = infoGroup,
		text = ajustarTexto(perguntas),
		x = tamanhoMargem + tamanhoIcone,
		y = 10 + tamanhoMargem + tamanhoIcone,
		font = native.systemFont,
		fontSize = tamanhoIcone
	}
	txtPerguntas = display.newText(options)
	txtPerguntas:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtPerguntas.anchorX = 0

	-- Cria o �cone da pontua��o
	imgPontos = display.newImageRect(infoGroup, "./imagens/pontos.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
	imgPontos.x = display.contentCenterX - 5.5 * tamanhoIcone --2 * tamanhoMargem + tamanhoIcone + tamanhoUnidade
	imgPontos.y = 60

	-- Crio o texto para informa��es sobre pontos
	options = {
		parent = infoGroup,
		text = ajustarTexto(composer.getVariable("pontos")),
		x = display.contentCenterX - 3.5 * tamanhoIcone, --3 * tamanhoMargem + 2 * tamanhoIcone + tamanhoUnidade,
		y = 65,
		font = native.systemFont,
		fontSize = 2 * tamanhoIcone
	}
	txtPontos = display.newText(options)
	txtPontos:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtPontos.anchorX = 0

	-- Cria o �cone do poder de ataque
	imgAtaque = display.newImageRect(infoGroup, "./imagens/ataque.png", tamanhoIcone, tamanhoIcone)
	imgAtaque.x = display.contentWidth - tamanhoUnidade - tamanhoIcone
	imgAtaque.y = tamanhoMargem

	-- Crio o texto para informa��es sobre o ataque
	options = {
		parent = infoGroup,
		text = ajustarTexto(ataque),
		x = display.contentWidth - tamanhoUnidade,
		y = tamanhoMargem,
		font = native.systemFont,
		fontSize = tamanhoIcone
	}
	txtAtaque = display.newText(options)
	txtAtaque:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtAtaque.anchorX = 0

	-- Cria o �cone do poder de defesa
	imgDefesa = display.newImageRect(infoGroup, "./imagens/defesa.png", tamanhoIcone, tamanhoIcone)
	imgDefesa.x = display.contentWidth - tamanhoUnidade - tamanhoIcone
	imgDefesa.y = 10 + tamanhoMargem + tamanhoIcone

	-- Crio o texto para informa��es sobre a defesa
	options = {
		parent = infoGroup,
		text = ajustarTexto(defesa),
		x = display.contentWidth - tamanhoUnidade,
		y = 10 + tamanhoMargem + tamanhoIcone,
		font = native.systemFont,
		fontSize = tamanhoIcone
	}
	txtDefesa = display.newText(options)
	txtDefesa:setFillColor(cores.vermelho.r, cores.vermelho.g, cores.vermelho.b)
	txtDefesa.anchorX = 0
end

local function criarGrupoCenario(group)
end

local function gotoMenu()
  composer.gotoScene("cenas.menu")
end

-- Cria o grupo de controles
local function criarGrupoControle(group)
  -- Cria o bot�o para subir
  local btnSubir = display.newImageRect(group, "./imagens/pular.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnSubir.x = 2 * tamanhoMargem
  btnSubir.y = display.contentHeight - 2 * tamanhoMargem
  btnSubir:addEventListener("tap", subir)

  -- Cria o bot�o para descer
  local btnDescer = display.newImageRect(group, "./imagens/abaixar.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnDescer.x = 4.5 * tamanhoMargem
  btnDescer.y = display.contentHeight - 2 * tamanhoMargem
  btnDescer:addEventListener("tap", descer)

  -- Cria o bot�o de atirar
  local btnAtirar = display.newImageRect(group, "./imagens/ataque.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnAtirar.x = display.contentWidth - 3 * tamanhoMargem
  btnAtirar.y = display.contentHeight - 2 * tamanhoMargem
  btnAtirar:addEventListener("tap", atirar)

  -- Cria o bot�o fechar
  local btnFechar = display.newImageRect(group, "./imagens/fechar.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnFechar.x = display.contentCenterX
  btnFechar.y = display.contentHeight - 2 * tamanhoMargem
  btnFechar:addEventListener("tap", gotoMenu)
end

-- Cria os objetos
local function criarObjeto(tipoObjeto)
	-- Crio o inimigo
	local objeto = display.newImageRect(groupCenario, "./imagens/" .. tipoObjeto .. ".png", 100, 100)

	-- Posiciona o objeto
	objeto.x = display.contentWidth + 100

	if (math.random(3) == 1) then
		objeto.y = 250
	else
		objeto.y = display.contentHeight - 250
	end

	if tipoObjeto == "inimigo" then
		objeto.defesa = 10		
	end

	-- Defino o tipo do objeto
	objeto.type = tipoObjeto

	-- Submeto o objeto � a��o da f�sica
	physics.addBody(objeto, "dynamic")

	-- Impulsiono o obst�culo em dire��o ao jogador
	transition.to(objeto, { x = -100, y = objeto.y, time = 4000, onComplete = function() display.remove(objeto) end})
end

-- Implementa o loop do jogo
local function gameLoop()
	-- Sorteio o objeto que será criado
	local objectType = math.random(8)

	-- Crio o objeto conforme sorteio
	if objectType <= 5 then
		criarObjeto("inimigo")
	elseif objectType == 6 then
		criarObjeto("pergunta")
	elseif objectType == 7 then
		criarObjeto("ataque")
	else
		criarObjeto("defesa")
	end
end

local function gameOver()
	composer.setVariable("pontos", pontos)
	composer.gotoScene("cenas.credits")
end

local function penalizarJogador()
	defesa = defesa - danoJogador
	if defesa == 0 then
		vidas = vidas - 1
		defesa = 10
		if vidas <= 0 then
			gameOver()
		end
	end
end

local function incrementaDefesa()
	defesa = defesa + bonusDefesa
end

local function incrementaAtaque()
	ataque = ataque + bonusAtaque
end

local function irParaChefao()
	gamePaused = true
	composer.setVariable("pontos", pontos)

	composer.removeScene("cenas.chefao")
	composer.gotoScene("cenas.chefao", { time=1000, effect="crossFade" })
end

local function penalizarInimigo(inimigo)
	inimigo.defesa = inimigo.defesa - danoInimigo
	if (inimigo.defesa <= 0) then
		pontos = pontos + 10
		display.remove(inimigo)

		quantidadeInimigos = quantidadeInimigos - 1
		if (quantidadeInimigos == 0) then
			irParaChefao()
		end
	end
end

local function irParaPergunta()
	gamePaused = true;

	local inicio = 0
	local fim = 15
	-- Sorteio uma das questões e asalternativas
	local nrQuestion
	nrQuestion = math.random(inicio, fim)

	local alts = {
		{ ds_alter = questionTable[nrQuestion].ds_alter1 },
		{ ds_alter = questionTable[nrQuestion].ds_alter2 },
	}

	local quiz = questionTable[nrQuestion]

	composer.setVariable("quiz", quiz)
	composer.setVariable("alternativas", alts)

	composer.removeScene("cenas.quiz")
	composer.gotoScene("cenas.quiz", { time=1000, effect="crossFade" })

	perguntas = perguntas + 1

	-- SE ACERTAR, INCREMENTAR A VARI�VEL pontos
end

local function onCollision(event)
	if (not gamePaused) then
		-- Capturo os objetos que colidiram
		local obj1 = event.object1
		local obj2 = event.object2

		if ( event.phase == "began" ) then
			if (obj1.type == "jogador" and obj2.type == "inimigo")  then
				penalizarJogador()
				display.remove(obj2)
			elseif(obj1.type == "inimigo" and obj2.type == "jogador") then
				penalizarJogador()
				display.remove(obj1)
			elseif (obj1.type == "jogador" and obj2.type == "defesa") then
				incrementaDefesa()
				display.remove(obj2)
			elseif (obj1.type == "defesa" and obj2.type == "jogador") then
				incrementaDefesa()
				display.remove(obj1)
			elseif (obj1.type == "jogador" and obj2.type == "ataque") then
				incrementaAtaque()
				display.remove(obj2)
			elseif (obj1.type == "ataque" and obj2.type == "jogador") then
				incrementaAtaque()
				display.remove(obj1)
			elseif (obj1.type == "jogador" and obj2.type == "pergunta") then
				irParaPergunta()
				display.remove(obj2)
			elseif (obj1.type == "pergunta" and obj2.type == "jogador") then
				irParaPergunta()
				display.remove(obj1)
			elseif (obj1.type == "bala" and obj2.type == "inimigo") then
				penalizarInimigo(obj2)
				display.remove(obj1)
			elseif (obj1.type == "inimigo" and obj2.type == "bala") then
				penalizarInimigo(obj1)
				display.remove(obj2)
			end

			atualizarInformacoes()
		end
	end
end

Runtime:addEventListener("collision", onCollision)

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

function scene:create(event)
	local sceneGroup = self.view
	physics.pause()

	groupBackground = display.newGroup()
	sceneGroup:insert(groupBackground)
	criarBackground(groupBackground)

	groupCenario = display.newGroup()
	sceneGroup:insert(groupCenario)
	criarGrupoCenario(groupCenario)

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

-- Quando a cena est� pronta para ser mostrada (phase will) e quando � mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Reinicio o jogo
		gamePaused = false

		-- Reinicio o motor de f�sica
		physics.start()

		-- Programo o loop do jogo para executar a cada 500ms
		timerJogador = timer.performWithDelay(50, loopJogador, 0)

		-- Programo o loop do jogador para executar a cada segundo
		timerCenario = timer.performWithDelay(1000, gameLoop, 0)

		-- Atualizo o texto da pontua��o
		atualizarInformacoes()
	end
end

-- Quando a cena est� prestes a ser escondida (phase will) e assim que � escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
    -- Paro os temporizadores
		timer.cancel(timerJogador)
		timer.cancel(timerCenario)

	elseif ( phase == "did" ) then
    -- Pauso o jogo
    gamePaused = true

    -- Removo a detec��o de colis�es
    Runtime:removeEventListener("colision", onCollision)

    -- Pauso o motor de f�sica
    physics.pause()
	end
end

-- Quando a cena � destruida
function scene:destroy(event)
	composer.setVariable("vidas", vidas)
	composer.setVariable("pontos", pontos)
	composer.setVariable("perguntas", perguntas)
	composer.setVariable("defesa", defesa)
	composer.setVariable("ataque", ataque)

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
