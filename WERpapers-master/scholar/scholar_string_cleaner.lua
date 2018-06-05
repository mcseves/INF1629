local string = string

-- Acentuação com tratamento correto
os.setlocale("", "ctype")

module(...)

local conversoesAcentos = {
	['à'] = 'a', ['á'] = 'a', ['â'] = 'a', ['ã'] = 'a',
	['ç'] = 'c',
	['è'] = 'e', ['é'] = 'e', ['ê'] = 'e',
	['ì'] = 'i', ['í'] = 'i', ['î'] = 'i',
	['ñ'] = 'n',
	['ò'] = 'o', ['ó'] = 'o', ['ô'] = 'o', ['õ'] = 'o',
	['ù'] = 'u', ['ú'] = 'u', ['û'] = 'u', ['ü'] = 'u',
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
	["Agrave"] = 'À', ["Aacute"] = 'Á', ["Acirc"] = 'Â', ["Atilde"] = 'Ã',
	["agrave"] = 'à', ["aacute"] = 'á', ["acirc"] = 'â', ["atilde"] = 'ã',
	["Ccedil"] = 'Ç',
	["ccedil"] = 'ç',
	["Egrave"] = 'È', ["Eacute"] = 'É', ["Ecirc"] = 'Ê',
	["egrave"] = 'è', ["eacute"] = 'é', ["ecirc"] = 'ê',
	["Igrave"] = 'Ì', ["Iacute"] = 'Í', ["Icirc"] = 'Î',
	["igrave"] = 'ì', ["iacute"] = 'í', ["icirc"] = 'î',
	["Ntilde"] = 'Ñ',
	["ntilde"] = 'ñ',
	["Ograve"] = 'Ò', ["Oacute"] = 'Ó', ["Ocirc"] = 'Ô', ["Otilde"] = 'Õ',
	["ograve"] = 'ò', ["oacute"] = 'ó', ["ocirc"] = 'ô', ["otilde"] = 'õ',
	["Ugrave"] = 'Ù', ["Uacute"] = 'Ú', ["Ucirc"] = 'Û', ["Uuml"] = 'Ü',
	["ugrave"] = 'ù', ["uacute"] = 'ú', ["ucirc"] = 'û', ["uuml"] = 'ü',
	["amp"] = "&",
	["nbsp"] = " ",
}

local function converteEscapeHtml(escape)
	return conversoesHtml[escape] or ""
end

local conversoesUTF = {
	['à'] = '%c3%a0', ['á'] = '%c3%a1', ['â'] = '%c3%a2', ['ã'] = '%c3%a3',
	['ç'] = '%c3%a7',
	['è'] = '%c3%a8', ['é'] = '%c3%a9', ['ê'] = '%c3%aa',
	['ì'] = '%c3%ac', ['í'] = '%c3%ad', ['î'] = '%c3%ae',
	['ñ'] = '%c3%b1',
	['ò'] = '%c3%b2', ['ó'] = '%c3%b3', ['ô'] = '%c3%b4', ['õ'] = '%c3%b5',
	['ù'] = '%c3%b9', ['ú'] = '%c3%ba', ['û'] = '%c3%bb', ['ü'] = '%c3%bc',
	['&'] = '%26',
}
local function codificaAcentoUTF(caractere)
	return conversoesUTF[caractere] or caractere
end

local function removeExcessoEspacos(str)
	str = string.gsub(str, "^%s*", "") -- remove espaços sobrando (início)
	str = string.gsub(str, "%s*$", "") -- remove espaços sobrando (fim)
	str = string.gsub(str, "%s%s+", " ") -- remove espaços sobrando (meio)
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
	str = string.gsub(str, "(%s)", "%%20") -- escapa espaços
	return str
end

-- Monta a url
-- @param url: url da requisicao
-- @param title: titulo do paper
-- @param results: quantos resultados devem aparecer
function montaUrl(url, title, author, results)
	local last_name = author
        for w in author:gmatch("%s([^%s]*)$") do last_name = w end
	-- string.sub tira os espaços dos do título da obra.
	title = escapaStringURL(title)
	last_name = escapaStringURL(last_name)
	results = results or 50
	-- string.format: gera uma string com a URL da pagina do google scholar de busca do artigo.
	return string.format(url, title, last_name, results)
end
