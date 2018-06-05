local string = string

-- Acentua��o com tratamento correto
os.setlocale("", "ctype")

module(...)

local conversoesAcentos = {
	['�'] = 'a', ['�'] = 'a', ['�'] = 'a', ['�'] = 'a',
	['�'] = 'c',
	['�'] = 'e', ['�'] = 'e', ['�'] = 'e',
	['�'] = 'i', ['�'] = 'i', ['�'] = 'i',
	['�'] = 'n',
	['�'] = 'o', ['�'] = 'o', ['�'] = 'o', ['�'] = 'o',
	['�'] = 'u', ['�'] = 'u', ['�'] = 'u', ['�'] = 'u',
	['&'] = ' e ',
}

local function removeAcento(caractere)
	caractere = string.lower(caractere)
	return conversoesAcentos[caractere] or caractere
end
local function eliminaCaractereAcentuado(caractere)
	if conversoesAcentos[caractere] then
		return ""
	else
		return caractere
	end
end

local conversoesHtml = {
	["Agrave"] = '�', ["Aacute"] = '�', ["Acirc"] = '�', ["Atilde"] = '�',
	["agrave"] = '�', ["aacute"] = '�', ["acirc"] = '�', ["atilde"] = '�',
	["Ccedil"] = '�',
	["ccedil"] = '�',
	["Egrave"] = '�', ["Eacute"] = '�', ["Ecirc"] = '�',
	["egrave"] = '�', ["eacute"] = '�', ["ecirc"] = '�',
	["Igrave"] = '�', ["Iacute"] = '�', ["Icirc"] = '�',
	["igrave"] = '�', ["iacute"] = '�', ["icirc"] = '�',
	["Ntilde"] = '�',
	["ntilde"] = '�',
	["Ograve"] = '�', ["Oacute"] = '�', ["Ocirc"] = '�', ["Otilde"] = '�',
	["ograve"] = '�', ["oacute"] = '�', ["ocirc"] = '�', ["otilde"] = '�',
	["Ugrave"] = '�', ["Uacute"] = '�', ["Ucirc"] = '�', ["Uuml"] = '�',
	["ugrave"] = '�', ["uacute"] = '�', ["ucirc"] = '�', ["uuml"] = '�',
	["amp"] = "&",
	["nbsp"] = " ",
}

local function converteEscapeHtml(escape)
	return conversoesHtml[escape] or ""
end

local conversoesUTF = {
	['�'] = '%c3%a0', ['�'] = '%c3%a1', ['�'] = '%c3%a2', ['�'] = '%c3%a3',
	['�'] = '%c3%a7',
	['�'] = '%c3%a8', ['�'] = '%c3%a9', ['�'] = '%c3%aa',
	['�'] = '%c3%ac', ['�'] = '%c3%ad', ['�'] = '%c3%ae',
	['�'] = '%c3%b1',
	['�'] = '%c3%b2', ['�'] = '%c3%b3', ['�'] = '%c3%b4', ['�'] = '%c3%b5',
	['�'] = '%c3%b9', ['�'] = '%c3%ba', ['�'] = '%c3%bb', ['�'] = '%c3%bc',
	['&'] = '%26',
}
local function codificaAcentoUTF(caractere)
	return conversoesUTF[caractere] or caractere
end

local function removeExcessoEspacos(str)
	str = string.gsub(str, "^%s*", "") -- remove espa�os sobrando (in�cio)
	str = string.gsub(str, "%s*$", "") -- remove espa�os sobrando (fim)
	str = string.gsub(str, "%s%s+", " ") -- remove espa�os sobrando (meio)
	return str
end

function removeAcentos(str)
	str = string.gsub(str, "(.)", removeAcento) -- remove acentos
	return str
end

function eliminaAcentos(str)
	str = string.gsub(str, "(.)", eliminaCaractereAcentuado) -- elimina acentos
	return str
end

function limpaString(str)
	str = string.gsub(str, "&(%w-);", converteEscapeHtml) -- converte escapes HTML
	str = string.gsub(str, "&(%w-);", "") -- remove unicode
	str = string.gsub(str, "%p", " ") -- remove caracteres de pontuacao
	str = string.lower(str) -- converte para minusculas
	str = removeExcessoEspacos(str)
	return str
end

function escapaStringURL(str)
	str = limpaString(str) -- limpa string
	str = string.gsub(str, "(.)", codificaAcentoUTF) -- converte acentos para escapes UTF-8
	str = string.gsub(str, "(%s)", "%%20") -- escapa espa�os
	return str
end

-- Monta a url
-- @param url: url da requisicao
-- @param title: titulo do paper
-- @param results: quantos resultados devem aparecer
function montaUrl(url, title, author, results)
	local last_name = author
        for w in author:gmatch("%s([^%s]*)$") do last_name = w end
	-- string.sub tira os espa�os dos do t�tulo da obra.
	title = escapaStringURL(title)
	last_name = escapaStringURL(last_name)
	results = results or 50
	-- string.format: gera uma string com a URL da pagina do google scholar de busca do artigo.
	return string.format(url, title, last_name, results)
end
