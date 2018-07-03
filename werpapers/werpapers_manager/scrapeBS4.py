# Aqui fazemos a busca no google scholars pela quantidade de artigos citados, usando beautiful soup

from bs4 import BeautifulSoup as bs
import requests

# link para o artigo 2 do wer98
scholar_url1 = 'https://scholar.google.com.br/scholar?as_q=%22derivaci'
scholar_url2 = '%C3%B3n%20de%20objetos%20utilizando%20lel%20y%20escenarios%20en%20un%20caso%20'
scholar_url3 = 'real%22&as_sauthors=%22fresno%22&num=50&hl=pt-BR&lr=&btnG=Pesquisar&lr='
scholar_url: str = scholar_url1 + scholar_url2 + scholar_url3

# transform
page = requests.get(scholar_url)
html_contents = page.text

page_soup_htmlparser = bs(html_contents, 'html.parser')

containers = page_soup_htmlparser.findAll(name='div', attrs={'class': 'gs_fl'})

# seleção do texto desejado no container
amount_articles = containers[2].text
amount = [s for s in amount_articles.split() if s.isdigit()]

#o numero desejado se encontra em amount[0], a primeira posicao da lista

