require 'httparty'

#não verificar SSL (resolver o erro de certificado SSL)
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#Configuração global do Proxy da rede
HTTParty::Basement.http_proxy('spobrproxy.serasa.intranet', '3128', 'stj2772', 'Alb@0610')