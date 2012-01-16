class ParamsController < ApplicationController
  # GET /params
  # GET /params.json
  def index
    @params = Category.find(params[:id]).functions.find(params[:function_id]).params
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @params }
    end
  end

  # GET /params/1
  # GET /params/1.json
  def show
    @param = Param.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @param }
    end
  end

  # GET /params/new
  # GET /params/new.json
  def new
    @param = Param.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @param }
    end
  end

  # GET /params/1/edit
  def edit
    @param = Param.find(params[:id])
  end

  # POST /params
  # POST /params.json
  def create
    @param = Param.new(params[:param])

    respond_to do |format|
      if @param.save
        format.html { redirect_to @param, notice: 'Param was successfully created.' }
        format.json { render json: @param, status: :created, location: @param }
      else
        format.html { render action: "new" }
        format.json { render json: @param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /params/1
  # PUT /params/1.json
  def update
    @param = Param.find(params[:id])

    respond_to do |format|
      if @param.update_attributes(params[:param])
        format.html { redirect_to @param, notice: 'Param was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /params/1
  # DELETE /params/1.json
  def destroy
    @param = Param.find(params[:id])
    @param.destroy

    respond_to do |format|
      format.html { redirect_to params_url }
      format.json { head :ok }
    end
  end
end
