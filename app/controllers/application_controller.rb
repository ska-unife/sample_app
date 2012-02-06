class ApplicationController < ActionController::Base
  protect_from_forgery # letteralmente proteggere dalla contraffazione
  include SessionsHelper
end


# con protect_from_forgery nel controller) dovresti vedere questo comportamento:
#  - nella form viene inserito un campo hidden con un token casuale
#  - al submit della form, il controller verifica che quel token non sia gia'  stato creato (dovresti vederti il token tra i parametri in development.log)
#  - poi tu mostri il risultato della form; se l'utente fa reload, vengono rimandati gli stessi dati, incluso lo stesso token; il server ti tira una exception.
