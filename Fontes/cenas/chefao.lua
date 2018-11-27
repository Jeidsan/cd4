--  ----------------------------------------------------------------------------------------------
--  projectname:	CD4: The Agent
--  filename:		chefao.lua
--	version:		1.0
--  description:	Cena do chefão
--  authors:		Jeidsan A. da C. Pereira (jeidsan.pereira@gmail.com)
--					Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:		2018-10-25
--  modified:		2018-10-25
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
physics.setGravity(0, 0)

--  ----------------------------------------------------------------------------------------------
-- Variáveis da cena
--  ----------------------------------------------------------------------------------------------

-- Imagens
local imgBackground
local imgJogador
local imgChefao
local imgVidas
local imgPerguntas
local imgPontos
local imgAtaque
local imgDefesa

-- Textos
local txtVidas
local txtPerguntas
local txtPontos
local txtAtaque
local txtDefesa

-- Grupos de objetos
local groupBackground
local groupInformacoes
local groupJogador
local groupChefao
local groupControle

-- Timers
local timerJogador
local timerChefao
local timerCenario

-- Variável para informar se o jogo está pausado.
local flagPausado = true

-- Musica

-- Unidades de referência para os elementos gráficos
local tamanhoIcone = 40
local tamanhoMargem = 40
local tamanhoUnidade = (display.contentWidth / 5) - tamanhoMargem

-- Parâmetros para definir a dificuldade do jogo
local danoJogador = 1 --composer.getVariable("danoJogador")
local bonusDefesa = 10 --composer.getVariable("bonusDefesa")
local bonusAtaque = 25 --composer.getVariable("bonusAtaque")
local defesaChefao = 40

-- Carrego os demais parâmetros do jogo
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

-- Controle
local direcaoChefao = 1

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

local function criarJogador(group)
	imgJogador = display.newImageRect(group, "./imagens/samurai.png", 220, 220)
	imgJogador.x = 150
	imgJogador.y = display.contentHeight - 250	
	imgJogador.type = "jogador"

	physics.addBody(imgJogador, "static")
end

local function criarChefao(group)
	imgChefao = display.newImageRect(group, "./imagens/zombie.png", 280, 280)
	imgChefao.x = display.contentWidth - 200
	imgChefao.y = display.contentHeight - 250
	imgChefao.type = "chefao"
	imgChefao.defesa = defesaChefao

	physics.addBody(imgChefao, "static")
end

local function subir()
	imgJogador.x = 150
	imgJogador.y = 250	
end

local function descer()
	imgJogador.x = 150
	imgJogador.y = display.contentHeight - 250
end

local function ajustarTexto(text)
	text = tostring(text)	
	local qtyZeros = 8 - #text
	for i = 1, qtyZeros do
		text = "0" .. text
	end	
	return text
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
		local bala = display.newImageRect("./imagens/bala.png", 30, 30)
		physics.addBody(bala, "dynamic", { isSensor = true } )    
		bala.type = "bala"
		bala.x = imgJogador.x
		bala.y = imgJogador.y

		transition.to(bala, { x = display.contentWidth + 50, time = 500, onComplete = function() display.remove(bala) end })
		ataque = ataque - 1
		atualizarInformacoes()
	end
end

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

local function gotoMenu()
  composer.gotoScene("cenas.menu")
end

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

local function tiroChefao()
	local balaChefao = display.newImageRect("./imagens/inimigo1.png", 50, 50)
	physics.addBody(balaChefao, "dynamic", { isSensor = true } )    
	balaChefao.type = "balaChefao"
	balaChefao.x = imgChefao.x
	balaChefao.y = imgChefao.y	

	transition.to(balaChefao, { x = -50, time = 2500, onComplete = function() display.remove(balaChefao) end })
end

local function loopGame()
	-- Sorteio o objeto que será criado
	local objectType = math.random(10)

	-- Crio o objeto conforme sorteio
	if objectType <= 5 then
		tiroChefao()
	elseif objectType <= 8 then
		criarObjeto("ataque")
	else
		criarObjeto("defesa")
	end
end

local function gameOver()	
	composer.setVariable("pontos", pontos)
	composer.gotoScene("cenas.credits")
end

local function irParaVitoria()
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

local function penalizarChefao()	
	imgChefao.defesa = imgChefao.defesa - 1
	imgChefao.alpha = 0.8
	if (imgChefao.defesa == 0) then
		irParaVitoria()
	end

	print(imgChefao.defesa)
end

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

local function loopChefao()
	local objectType = math.random(10)
	imgChefao.alpha = 1
	-- Crio o objeto conforme sorteio
	if objectType <= 5 then
		imgChefao.x = display.contentWidth - 200
		imgChefao.y = display.contentHeight - 500
	else
		imgChefao.x = display.contentWidth - 200
		imgChefao.y = display.contentHeight - 250
	end			
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
			if (obj1.type == "jogador" and obj2.type == "balaChefao")  then
				penalizarJogador()
				display.remove(obj2)
			elseif(obj1.type == "balaChefao" and obj2.type == "jogador") then
				penalizarJogador()
				display.remove(obj1)
			elseif (obj1.type == "chefao" and obj2.type == "bala") then
				penalizarChefao()
				display.remove(obj2)
			elseif (obj1.type == "bala" and obj2.type == "chefao") then
				penalizarChefao()
				display.remove(obj1)	
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

	groupJogador = display.newGroup()
	sceneGroup:insert(groupJogador)
	criarJogador(groupJogador)

	groupChefao = display.newGroup()
	sceneGroup:insert(groupChefao)
	criarChefao(groupChefao)

	groupInformacoes = display.newGroup()
	sceneGroup:insert(groupInformacoes)
	criarGrupoInformacoes(groupInformacoes)

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
		gamePaused = false
		physics.start()

		timerCenario = timer.performWithDelay(1500, loopGame, 0)
		timerJogador = timer.performWithDelay(100, loopJogador, 0)
		timerChefao = timer.performWithDelay(500, loopChefao, 0)

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