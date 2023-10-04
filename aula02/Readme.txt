Geracao Docker para conexao vpn
-------------------------------



1. Alterar arquivo extra/bin/connect.sh substituindo as variaveis $VPNPASS e $VPNUSER 
   pelos valores definidos pelo cliente.
	
2. Gerar imagem
    docker build . -t vpnserver
	
3. Executar container usando os parametros

    docker run -ti --rm --name vpncontainer -p 9091:9091 -p 9092:9092 -p 9093:9093 --privileged -ti vpnserver
	
4. Apos abrir o terminal bash executar a conexao vpn
    
	bash bin/connect.sh
	
5.  Para acessar diferentes bancos basta gerar um ponte virtual de portos

5.1. Abrir um terminal cmd
5.2. Executar um terminal dentro do docker e executar um script de tunnel, 
     pode ser um ou varios, mas sem repetir.

    docker exec -ti vpncontainer bash
	sh bin/tunnel_pib.sh
	
5.3. Conectar usando um cliente de DB (dbeaver por exemplo) 
     usando a conexao de acordo com a seguinte tabela
	 
	 banco PIB     | tunnel_pib.sh    | localhost:9091/D00SUP
	 banco GAV     | tunnel_gav.sh    | localhost:9092/D00SUP
	 banco Mobile4 | tunnel_mobile.sh | localhost:9093/D03MB11

6.- Para finalizar conexao, no docker da sessao vpn, pressione CTRL-C e logo execute o comando

    exit
	
