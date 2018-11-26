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
physics.setGravity(0, 20)

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

-- Parâmetros para definir a dificuldade do jogo
local danoJogador = 1 --composer.getVariable("danoJogador")
local danoInimigo = 1 --composer.getVariable("danoInimigo")
local bonusDefesa = 10 --composer.getVariable("bonusDefesa")
local bonusAtaque = 10 --composer.getVariable("bonusAtaque")
local quantidadeInimigos = 15 --composer.getVariable("quantidadeInimigos")

-- Carrego os demais parâmetros do jogo
composer.setVariable("vidas", 5)
local vidas = composer.getVariable("vidas")

composer.setVariable("perguntas", 0)
local perguntas = composer.getVariable("perguntas")

composer.setVariable("pontos", 0)
local pontos = composer.getVariable("pontos")

composer.setVariable("ataque", 10)
local ataque = composer.getVariable("ataque")

composer.setVariable("defesa", 10)
local defesa = composer.getVariable("defesa")

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

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
	imgJogador = display.newImageRect(group, "./imagens/samurai.png", 220, 220)
	imgJogador.x = 150
	imgJogador.y = display.contentHeight - 250	

	-- Informo que o gamer é do tipo gamer
	imgJogador.type = "jogador"

	-- Adiciono-o ao motor de física
	physics.addBody(imgJogador, "static")
end

-- Faz o jogador pular
local function subir()
	imgJogador.x = 150
	imgJogador.y = 250
	--imgJogador:applyLinearImpulse(0, -7, imgJogador.x, imgJogador.y)
end

-- Faz o jogador pular
local function descer()
	imgJogador.x = 150
	imgJogador.y = display.contentHeight - 250
	--imgJogador:applyLinearImpulse(0, -7, imgJogador.x, imgJogador.y)
end

-- Faz o jogador atirar
local function atirar()
	local bala = display.newImageRect(, objectSheet, 5, 14, 40 )
    physics.addBody( newLaser, "dynamic", { isSensor=true } )
    newLaser.isBullet = true
    newLaser.myName = "laser"
 
    newLaser.x = ship.x
    newLaser.y = ship.y
end

local function ajustarTexto(text)
	text = tostring(text)	
	local qtyZeros = 8 - #text
	for i = 1, qtyZeros do
		text = "0" .. text
	end	
	return text
end

-- Atualiza os textos de pontuação, munição e vidas
local function atualizarInformacoes()
	txtVidas.text = ajustarTexto(vidas)
	txtPerguntas.text = ajustarTexto(perguntas)
	txtPontos.text = ajustarTexto(pontos)
	txtAtaque.text = ajustarTexto(ataque)
	txtDefesa.text = ajustarTexto(defesa)
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
		text = ajustarTexto(vidas), 
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
		text = ajustarTexto(perguntas), 
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
	imgPontos.x = display.contentCenterX - 5.5 * tamanhoIcone --2 * tamanhoMargem + tamanhoIcone + tamanhoUnidade
	imgPontos.y = 60

	-- Crio o texto para informações sobre pontos
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
	
	-- Cria o ícone do poder de ataque
	imgAtaque = display.newImageRect(infoGroup, "./imagens/ataque.png", tamanhoIcone, tamanhoIcone)
	imgAtaque.x = display.contentWidth - tamanhoUnidade - tamanhoIcone
	imgAtaque.y = tamanhoMargem

	-- Crio o texto para informações sobre o ataque
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

	-- Cria o ícone do poder de defesa
	imgDefesa = display.newImageRect(infoGroup, "./imagens/defesa.png", tamanhoIcone, tamanhoIcone)
	imgDefesa.x = display.contentWidth - tamanhoUnidade - tamanhoIcone
	imgDefesa.y = 10 + tamanhoMargem + tamanhoIcone	

	-- Crio o texto para informações sobre a defesa
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
  -- Cria o botão para subir
  local btnSubir = display.newImageRect(group, "./imagens/pular.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnSubir.x = 2 * tamanhoMargem
  btnSubir.y = display.contentHeight - 2 * tamanhoMargem
  btnSubir:addEventListener("tap", subir)

  -- Cria o botão para descer
  local btnDescer = display.newImageRect(group, "./imagens/abaixar.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnDescer.x = 4.5 * tamanhoMargem
  btnDescer.y = display.contentHeight - 2 * tamanhoMargem
  btnDescer:addEventListener("tap", descer)
  
  -- Cria o botão de atirar 
  local btnAtirar = display.newImageRect(group, "./imagens/ataque.png", 2 * tamanhoIcone, 2 * tamanhoIcone)
  btnAtirar.x = display.contentWidth - 3 * tamanhoMargem
  btnAtirar.y = display.contentHeight - 2 * tamanhoMargem
  btnAtirar:addEventListener("tap", atirar)

  -- Cria o botão fechar 
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

-- Trata das colisões com os inimigos
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

-- Trata das colisões com os bonus de defesa
local function incrementaDefesa()
	defesa = defesa + bonusDefesa
end	

local function incrementaAtaque()
	ataque = ataque + bonusAtaque
end

local function penalizarInimigo(inimigo)
	inimigo.defesa = inimigo.defesa - danoInimigo
	if (inimigo.defesa <= 0) then
		display.remove(inimigo)
	end
end

local function irParaPergunta()
	perguntas = perguntas + 1
	-- AQUI CHAMAR A CENA DA PERGUNTA
	-- SE ACERTAR, INCREMENTAR A VARIÁVEL pontos
end

-- Trata a colisão entre objetos
local function onCollision(event)	
	if (not gamePaused) then
		-- Capturo os objetos que colidiram
		local obj1 = event.object1
		local obj2 = event.object2

		-- Verifico se é o início da colisão com a phase "began"
		if ( event.phase == "began" ) then
			-- Testo as colisões que preciso tratar
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
		gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)

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
	composer.setVariable("vidas", vidas)
	composer.setVariable("pontos", pontos)
	composer.setVariable("perguntas", perguntas)
	composer.setVariable("defesa", defesa)
	composer.setVariable("ataque", ataque)

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