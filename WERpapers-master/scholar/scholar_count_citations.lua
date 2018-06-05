local scleaner = require"scholar_string_cleaner"

local math, pairs, string, table, tonumber = math, pairs, string, table, tonumber

module(...)

local function levenshtein(str1, str2)
	local carac1 = {}
	local carac2 = {}
	string.gsub(str1, "(.)", function (c) table.insert(carac1, c) end)
	string.gsub(str2, "(.)", function (c) table.insert(carac2, c) end)

	local distancia = {}

	local len1 = string.len(str1)
	local len2 = string.len(str2)
	for i = 0, len1 do distancia[i] = {} end
	for i = 0, len1 do distancia[i][0] = i end
	for i = 0, len2 do distancia[0][i] = i end

	for i = 1, len1 do
		for j = 1, len2 do
			local temp = (carac1[i] == carac2[j]) and 0 or 1
			distancia[i][j] = math.min(
				distancia[i-1][j] + 1,
				distancia[i][j-1] + 1,
				distancia[i-1][j-1] + temp
			)
		end
	end

	return distancia[len1][len2]
end

string.distancia = function (str1, str2)
	str1 = scleaner.eliminaAcentos(scleaner.limpaString(str1))
	str2 = scleaner.eliminaAcentos(scleaner.limpaString(str2))
	local len1 = string.len(str1)
	local len2 = string.len(str2)
	local menor = math.min(len1, len2)
	local diferenca = math.abs(len1 - len2)
	if (string.find(str1, str2) or string.find(str2, str1)) and (diferenca < menor * 0.66) then
		return -1
	end
	return levenshtein(str1, str2)
end

local function removeHtml(texto)
	return (string.gsub(texto, "(<[^<>]*>)", ""))
end

local function removeMeta(texto)
	return (string.gsub(texto, "(%[[^%[%]]*%])", ""))
end

return function (pagina, title)
	local resultados = {}

	local _, inicio, fim, seguinte
	local offset = 1
	local titulo, citacoes
	while true do
    citacoes = nil
		-- string.find pega o indice do inicio do primeiro titulo .
		_, inicio = string.find(pagina, '<h3 [^>]*>', offset)
		if not inicio then break end
		-- string.find pega o indice do fim do primeiro titulo .
		fim, _ = string.find(pagina, '</h3>', inicio)
		if not fim then break end
		
    -- removeMeta, removeHtml ,  stringSub  e limpaString limpam a string html
    -- titulo( inicio-fim ) tiranado as tag e retornando só o titulo.
		titulo = removeMeta(removeHtml(string.sub(pagina, inicio, fim)))
		titulo = scleaner.limpaString(titulo)

		-- string.find pega o indice do inicio do  titulo  seguinte.
		offset, seguinte = string.find(pagina, '<h3 [^>]*>', inicio + 1)

		-- string.find pega o indice do inicio da string do numero de citações.
		_, inicio = string.find(pagina, '">Citado por ', fim)
		if inicio and (not seguinte or inicio < seguinte) then
		-- string.find pega o indice do fim da string do numero de citações.
			fim, _ = string.find(pagina, '</a>', inicio)
			if fim then
			
			  -- transforma a string do numero de citações (strin.gsub) em numero.
				citacoes = tonumber(string.sub(pagina, inicio, fim - 1))
			end
		end
		
		-- o numero de citações é colocado na tabela com o titulo.
		table.insert(resultados, { titulo = titulo, citacoes = citacoes })

		-- passa para o proximo titulo
		if not seguinte then
			break
		end
	end

  local dados = 0
  -- testa para cada resultado da pesquisa por 1 artigo se a distancia
  -- para do titulo para o artigo que estamos procurando é menor do que 10.
	for _, resultado in pairs(resultados) do
    if string.distancia(title, resultado.titulo) < 10 then
      if resultado.citacoes then
        -- se a distancia é menor do que 10 soma-se o numero de citações.
        dados = dados + resultado.citacoes
      end
    end
  end
  return dados
end
