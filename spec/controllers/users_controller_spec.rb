require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "andato tutto bene" do
      get :show, :id => @user
      response.should be_success
    end
    it "trovato user giusto" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "Titolo corretto" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name )
    end
    it "Nome utente nella pagina" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name )
    end
  end
  
  describe "GET 'new'" do
    it "Pagina esistente" do
      get 'new'
      response.should be_success
    end
    it "Titolo pagina corretto" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
  
  describe "POST 'create' | " do 
    describe "failure |" do
      before(:each) do
        @attr = { :name => "",
                  :email => "",
                  :password => "",
                  :password_confirmation => "" }
      end    
      it " controllo che un errore non mi crei un record sbagliato nella tabella user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end   
      it "Titolo pagina corretto" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      it "Errore ritorno pagina registrazione" do
        post :create, :user => @attr
        response.should render_template('new')
      end                  
    end
    
    describe "success |" do
      before(:each) do
        @attr = { :name => "Mario",
                  :email => "mario@gmail.com",
                  :password => "PinkFloid",
                  :password_confirmation => "PinkFloid" }
      end    
      it "Creazione utente" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      it "Redirect a pagina utente" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end                  
      it "creazione messaggio flash Successo" do
        post :create, :user => @attr
        flash[:success].should =~ /benvenuti nell\' app/i
      end
      it "controllo login effettivo" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end  # end di describe "success" do   
  end # end di describe "POST 'create'" do

  describe "GET 'edit' | " do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    it "Modifica avvenuta con successo" do
      get :edit, :id => @user
      response.should be_success
    end
    it "Nome utente nella pagina" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Modifica utente" )
    end
    it "Avatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url, :content => "change" )
    end
  end

  describe "PUT 'update' | " do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "Fallito | " do
      before(:each) do
        @attr = { :name => "",
                  :email => "",
                  :password => "",
                  :password_confirmation => "" }
      end    
      
      it "deve restituire pagina edit" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      it "titolo corretto nella pagina" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Modifica utente" )
      end


    end
    describe "Successo | " do
      before(:each) do
        @attr = { :name => "Nome",
                  :email => "test@localhost.it",
                  :password => "123456",
                  :password_confirmation => "123456" }
      end    
      it "Salvataggio modifiche" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end
      it "Redirect" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end 
      it "Flash" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end 
    end
  end
  
  describe "autenticazione per pagine edit/update" do
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "utenti non loggati" do
      it "accesso negato a pagina edit" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "accesso negato a pagina update" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "Per utenti loggati" do
      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
    
      it "user match per user edit" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "accesso negato a pagina update" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end
end
