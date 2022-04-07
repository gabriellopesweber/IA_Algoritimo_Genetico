--- ### Codigo em Lua para Atividade da aula
--- 'Modelos Evolucionários e Tratamento de Incertezas'

TAMANHO_CAIBRO = 500
PEDIDOS = 200
DIVISAO = 5
ERAS = 200
MEDIDA = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}
PEDIDO_ALEATORIO = {}

SISTEMA_LOG = false
LOG = ""

for i = 1, PEDIDOS, 1 do -- Esta loop realiza a criação de um array vazio de acordo com o tamanho de pedidos definidos
    table.insert(PEDIDO_ALEATORIO, i, {})
end

function Main()
    local EXIBIR = 10
    print(" - Iniciando execucao - ")
    GerarPedido()
    for i = 1, ERAS, 1 do
        OrderdarDecrecente()
        ExibirPedido(EXIBIR, true, i)
        CrossOver()
    end
    print(" - Fim da execucao - ")
end

function CrossOver()
    local tempAtual = {{}}
    for i = 1, DIVISAO, 1 do -- Esta loop realiza a criação de um array vazio de acordo com o tamanho de pedidos definidos
        table.insert(tempAtual, i, {})
    end
    local msg = ""
    for p = 1, #PEDIDO_ALEATORIO, 1 do
        for o = 1, DIVISAO, 1 do
            msg = msg .. "[DEBUG] -> Valor do O: " .. o .. "\n"
            if o == DIVISAO then
                msg =
                    msg ..
                    "[DEBUG] -> Realizando insercao no indereco [" ..
                        o .. "] pedido: " .. tostring(PEDIDO_ALEATORIO[1][o]) .. "\n"
                table.insert(tempAtual[p], o, PEDIDO_ALEATORIO[1][o])
            else
                msg =
                    msg ..
                    "[DEBUG] -> Realizando insercao no indereco [" ..
                        o .. "] pedido: " .. tostring(PEDIDO_ALEATORIO[p][o + 1]) .. "\n"
                table.insert(tempAtual[p], o, PEDIDO_ALEATORIO[p][o + 1])
            end
        end
        for i = DIVISAO + 1, #PEDIDO_ALEATORIO[1], 1 do
            msg = msg .. "[DEBUG] -> Valor do I: " .. i .. "\n"
            msg =
                msg ..
                "[DEBUG] -> Realizando insercao no indereco [" .. i .. "] pedido: " .. PEDIDO_ALEATORIO[p][i] .. "\n"

            table.insert(tempAtual[p], i, PEDIDO_ALEATORIO[p][i])
        end
        if p == DIVISAO then
            break
        end
    end
    for indice, valor in ipairs(tempAtual) do
        table.insert(PEDIDO_ALEATORIO, indice, valor)
    end
end

function ExibirPedidoOrdenado()
    local f = io.open("Lista_Atualizada.log", "w+")
    local msg = " - Exibindo Lista Ordenada - \n"

    for indice, valor in ipairs(PEDIDO_ALEATORIO) do
        msg = msg .. "\t[" .. indice .. "] " .. Exibir(valor) .. "\n"
    end

    f:write(msg)
    f:close()
end

function OrderdarDecrecente()
    local f = io.open("mudanca_de_posicao.txt", "w+")
    local msg = ""
    for i = 1, #PEDIDO_ALEATORIO, 1 do
        local Cont_Atual = 0
        if SISTEMA_LOG then
            msg = msg .. "Indice de I: " .. i .. "\n"
        end

        Cont_Atual = Exibir(PEDIDO_ALEATORIO[i])

        if SISTEMA_LOG then
            msg = msg .. "Valor: " .. Cont_Atual .. "\n"
        end

        if i < #PEDIDO_ALEATORIO then
            for o = i, 1, -1 do
                ::VALIDA_NOVAMENTE::
                local Cont_ProximoPedido = Exibir(PEDIDO_ALEATORIO[o + 1])
                Cont_Atual = Exibir(PEDIDO_ALEATORIO[o])
                if SISTEMA_LOG then
                    msg = msg .. "[DEBUG] -> Vetor atual: " .. Cont_Atual .. "\n"
                    msg = msg .. "[DEBUG] -> Proximo vetor: " .. Cont_ProximoPedido .. "\n"
                    msg =
                        msg ..
                        "[DEBUG] -> " .. "Analisando se " .. Cont_Atual .. " é menor que " .. Cont_ProximoPedido .. "\n"
                end
                if Cont_Atual < Cont_ProximoPedido then
                    if SISTEMA_LOG then
                        msg = msg .. "[DEBUG] -> " .. Cont_Atual .. " é menor que " .. Cont_ProximoPedido .. "\n"
                        msg = msg .. "[DEBUG] -> " .. "Mudando posições\n"
                    end
                    local tempAtual = {}
                    for indice, valor in ipairs(PEDIDO_ALEATORIO[o]) do
                        table.insert(tempAtual, indice, valor)
                    end
                    local tempProx = {}
                    for indice, valor in ipairs(PEDIDO_ALEATORIO[o + 1]) do
                        table.insert(tempProx, indice, valor)
                    end
                    PEDIDO_ALEATORIO[o + 1] = tempAtual
                    PEDIDO_ALEATORIO[o] = tempProx
                    if SISTEMA_LOG then
                        msg = msg .. "[DEBUG] -> " .. "Contando novamente\n"
                    end
                    Cont_ProximoPedido = Exibir(PEDIDO_ALEATORIO[o + 1])
                    Cont_Atual = Exibir(PEDIDO_ALEATORIO[o])
                    if SISTEMA_LOG then
                        msg = msg .. "[DEBUG] -> Vetor atual: " .. Cont_Atual .. "\n"
                        msg = msg .. "[DEBUG] -> Proximo vetor: " .. Cont_ProximoPedido .. "\n"
                        msg = msg .. "[DEBUG] -> " .. "Validando novamente\n"
                    end
                    goto VALIDA_NOVAMENTE
                elseif o > 1 then
                    Cont_AnterirorPedido = Exibir(PEDIDO_ALEATORIO[o - 1])
                    if SISTEMA_LOG then
                        msg =
                            msg ..
                            "[DEBUG] -> " ..
                                "Analisando se " .. Cont_Atual .. " é maior que " .. Cont_ProximoPedido .. "\n"
                    end
                    if Cont_Atual > Cont_AnterirorPedido then
                        if SISTEMA_LOG then
                            msg = msg .. "[DEBUG] -> " .. Cont_Atual .. " é maior que " .. Cont_ProximoPedido .. "\n"
                            msg = msg .. "[DEBUG] -> " .. "Mudando posições\n"
                        end
                        local tempAtual = {}

                        for indice, valor in ipairs(PEDIDO_ALEATORIO[o]) do
                            table.insert(tempAtual, indice, valor)
                        end
                        local tempAnt = {}

                        for indice, valor in ipairs(PEDIDO_ALEATORIO[o - 1]) do
                            table.insert(tempAnt, indice, valor)
                        end
                        PEDIDO_ALEATORIO[o - 1] = tempAtual
                        PEDIDO_ALEATORIO[o] = tempAnt
                        if SISTEMA_LOG then
                            msg = msg .. "[DEBUG] -> " .. "Contando novamente\n"
                        end
                        Cont_AnterirorPedido = Exibir(PEDIDO_ALEATORIO[o - 1])
                        Cont_Atual = Exibir(PEDIDO_ALEATORIO[o])
                        if SISTEMA_LOG then
                            msg = msg .. "[DEBUG] -> Vetor atual: " .. Cont_Atual .. "\n"
                            msg = msg .. "[DEBUG] -> Proximo vetor: " .. Cont_ProximoPedido .. "\n"
                            msg = msg .. "[DEBUG] -> " .. "Validando novamente\n"
                        end
                        goto VALIDA_NOVAMENTE
                    end
                end
            end
        end
        if SISTEMA_LOG then
            msg = msg .. "\n"
        end
    end
    if SISTEMA_LOG then
        f:write(msg)
        f:close()
    end
end

function Exibir(list)
    local cont = 0
    for i = 1, #list, 1 do
        if list[i] == 1 then
            cont = cont + MEDIDA[i]
        end
    end
    return cont
end

function ExibirComp(list)
    local msg = ""
    for i = 1, #list, 1 do
        local cont = 0
        for indice, valor in ipairs(list[i]) do
            if valor == 1 then
                cont = cont + MEDIDA[indice]
                msg = msg .. cont .. "\n"
            end
        end
    end
    return msg
end

function ExibirPedido_list(list)
    local msg = ""
    msg = msg .. " -- Listando Pedidos -- \n\tTamanho: "
    for indice, valor in pairs(MEDIDA) do
        msg = msg .. "\t[" .. indice .. "] " .. valor .. "\t"
    end

    msg = msg .. "Total"
    msg = msg .. "\n"
    for i = 1, #list, 1 do
        local cont = 0
        msg = msg .. "\tItem" .. i .. "\t\t"
        for indice, valor in ipairs(list[i]) do
            if valor == 1 then
                msg = msg .. "[" .. indice .. "] true\t"
                cont = cont + MEDIDA[indice]
            else
                msg = msg .. "[" .. indice .. "] false\t"
            end
        end
        msg = msg .. cont .. "\n"
    end
    return msg
end

function ExibirPedido(vlr_exibir, exibir, erax)
    local era = erax
    LOG = LOG .. "\n"
    local f = io.open("./log.txt", "w+")
    LOG = LOG .. " ERA: " .. era .. "\n\n\tTamanho: "
    for indice, valor in pairs(MEDIDA) do
        LOG = LOG .. "\t[" .. indice .. "] " .. valor .. "\t"
    end
    LOG = LOG .. "Total"
    for i = 1, 50, 1 do
        local cont = 0
        LOG = LOG .. "\n\tItem" .. i .. "\t"
        for indice, valor in pairs(PEDIDO_ALEATORIO[i]) do
            LOG = LOG .. "\t[" .. indice .. "] "
            if valor == 1 then
                LOG = LOG .. "true"
                cont = cont + MEDIDA[indice]
            else
                LOG = LOG .. "false"
            end
        end
        LOG = LOG .. "\t" .. cont .. "\t"
    end

    f:write(LOG)
    f:close()
    return LOG
end

function GerarPedido()
    if PEDIDO_ALEATORIO ~= nil then
        math.randomseed(os.time()) -- Passa o horario atual da execução para com que a execução de um valor aleatoria seja aleatoria em toda execução.
        for indice = 1, #PEDIDO_ALEATORIO, 1 do
            for i = 1, #MEDIDA, 1 do
                local uso = math.random(0, 1) -- determinará se o tamanho é usado ou não.
                table.insert(PEDIDO_ALEATORIO[indice], i, uso)
            end
        end
    end
end

Main()
