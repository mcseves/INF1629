# Ponto de Controle 4 - 04/07/2018

### Equipe

A equipe responsável pelo desenvolvimento é formada pelos seguintes alunos:
- Gustavo Olenka
- Maria Carolina Marinho
- Willian Simões

## Replanejamento
Houve um replanejamento no cronograma. O desenvolvimento passou a ser feito com o framework [Django](https://www.djangoproject.com), que usa python como linguagem.
[Cronograma atualizado](https://docs.google.com/spreadsheets/d/1kH1tavMgmxV3_RoG5Pk3cWTGzGf5C3rF6pZLdxmP7QY/edit#gid=1115838130) e [diagrama de classes atualizado](https://drive.google.com/file/d/1GdugSNIjK-dm_Zlc3UIMKm0lG9sySdDm/view).

## Django
Por conta da mudança para Django, foram feitas algumas adaptações. O webcrawl é feito usando a biblioteca [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/), e o deploy foi feito usando [Heroku](http://heroku.com). 
Ambos tem fácil integração com Django.

O aplicativo lista conta agora com os seguintes arquivos novos, de maior relevância:

- requirements.txt, runtime.txt, Procfile = usados para fazer o deploy da aplicação usando Heroku.
- views.py = responsável pela ligação entre os templates e o json contendo as informações sobre os artigos.
- scrapeBS4.py = onde fazemos a busca do número de citações de artigos em uma certa pagina do Google Scholars.

## O site
O aplicativo pode ser acessado pelo link [deploy_pes](https://deploypes.herokuapp.com).
Para rodar localmente, basta entrar no terminal, no diretório do aplicativo e digitar python manage.py runserver. É necessário ter python instalado.

 





