# 1. IMAGEM DE BASE
# Começamos com uma imagem oficial do Nginx. A tag 'alpine' indica que é uma versão
# super leve do Linux, o que resulta em uma imagem final muito menor.
FROM nginx:alpine

# 2. LIMPEZA E CONFIGURAÇÃO
# Remove a configuração padrão do Nginx que vem com a imagem. Isso garante que
# a nossa configuração será a única, evitando conflitos de 'default_server'.
RUN rm /etc/nginx/conf.d/default.conf

# Copia o nosso arquivo de configuração personalizado (que criamos anteriormente) para
# o local onde o Nginx espera encontrá-lo dentro do container.
COPY nginx.conf /etc/nginx/nginx.conf

# 3. ADICIONANDO O CONTEÚDO DO SITE
# Remove o conteúdo HTML padrão que vem na imagem do Nginx (a página de boas-vindas).
# Isso garante que apenas os arquivos do nosso site estarão lá.
RUN rm -rf /usr/share/nginx/html/*

# Copia TUDO do diretório atual (representado pelo '.') para o diretório raiz do
# servidor web do Nginx dentro do container.
# Lembre-se que o comando 'docker build' deve ser executado de dentro da pasta do seu portfólio.
COPY . /usr/share/nginx/html/

# 4. EXPOSIÇÃO DA PORTA
# Informa ao Docker que o container vai expor a porta 80.
# Isso não publica a porta, apenas a documenta. A publicação é feita no comando 'docker run -p'.
EXPOSE 80

# 5. COMANDO DE EXECUÇÃO
# O comando que será executado quando o container iniciar.
# 'nginx -g "daemon off;"' inicia o Nginx em modo 'foreground' (primeiro plano),
# o que é essencial para que o container continue rodando.
CMD ["nginx", "-g", "daemon off;"]
