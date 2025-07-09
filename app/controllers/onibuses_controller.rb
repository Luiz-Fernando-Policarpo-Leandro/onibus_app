class OnibusesController < ApplicationController
  before_action :require_user, except: [ :home ]
  before_action :set_onibus, only: %i[ show edit update destroy ]

  def home
  end
  # GET /onibuses or /onibuses.json
  def index
    @onibuses = Onibus.all
  end

  # GET /onibuses/1 or /onibuses/1.json
  def show
  end

  # GET /onibuses/new
  def new
    @onibus = Onibus.new
  end

  # GET /onibuses/1/edit
  def edit
  end

  # POST /onibuses or /onibuses.json
  def create
    @onibus = Onibus.new(onibus_params)

    respond_to do |format|
      if @onibus.save
        format.html { redirect_to @onibus, notice: "Onibus was successfully created." }
        format.json { render :show, status: :created, location: @onibus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @onibus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /onibuses/1 or /onibuses/1.json
  def update
    respond_to do |format|
      if @onibus.update(onibus_params)
        format.html { redirect_to @onibus, notice: "Onibus was successfully updated." }
        format.json { render :show, status: :ok, location: @onibus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @onibus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /onibuses/1 or /onibuses/1.json
  def destroy
    @onibus.destroy!

    respond_to do |format|
      format.html { redirect_to onibuses_path, status: :see_other, notice: "Onibus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_onibus
      @onibus = Onibus.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def onibus_params
      params.fetch(:onibus, {})
    end
end
