class StatusesController < ApplicationController

  before_filter :fetch_user
  before_filter :authenticate, :authorize, :except => [:index, :show]

  # GET /statuses
  # GET /statuses.xml
  # GET /statuses.json
  def index
    @statuses = @user ? @user.statuses : Status.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses.to_xml(:include => :user) }
      format.json { render :json => @statuses.to_json(:include => :user) }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status.to_xml(:include => :user) }
      format.json { render :json => @status.to_json(:include => :user) }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  # GET /statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status.to_xml }
      format.json { render :json => @status.to_json }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  # POST /statuses.json
  def create
    @status = @user.statuses.build(params[:status])

    respond_to do |format|
      if @status.save
        flash[:notice] = 'Status was successfully created.'
        format.html { redirect_to([@user, @status]) }
        format.xml  { render :xml => @status.to_xml(:include => :user), :status => :created, :location => [@user, @status] }
        format.json  { render :json => @status.to_json(:include => :user), :status => :created, :location => [@user, @status] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        flash[:notice] = 'Status was successfully updated.'
        format.html { redirect_to([@user, @status]) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(user_statuses_url(@user)) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end


  private
  def fetch_user
    @user = User.find_by_permalink!(params[:user_id]) if params[:user_id]
  end

  def authenticate
    @current_user = authenticate_or_request_with_http_basic("Twitter clone: introduce yourself right on!") do |login, password|
      User.find_by_login_and_password(login, password)
    end
  end

  def authorize
    if @user != @current_user
      flash[:warning] = "You're not authorized to perform this action"
      redirect_to(root_path) and return false
    end
  end

end
