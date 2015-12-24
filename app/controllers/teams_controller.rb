class TeamsController < ApplicationController

  # GET /documents
  # GET /documents.json
  def index
    @teams = Team.all.order("id ASC")
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @teams = Team.all
    @team_member = Team.friendly.find(params[:id])
  end

  # # GET /documents/new
  # def new
  #   @company = Company.find(params[:company_id])
  #   @document = Document.new
  # end

  def edit
  end

  # # POST /documents
  # # POST /documents.json
  # def create
  #   @document = Document.new(document_params)
  #   @company = Company.find(params[:document][:company_id])
  #   respond_to do |format|
  #     if @document.save
  #       @company.documents << @document
  #       format.html { redirect_to "/companies", notice: 'Document was successfully created.' }
  #       format.json { render :show, status: :created, location: @document }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @document.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /documents/1
  # # DELETE /documents/1.json
  # def destroy
  #   @document.destroy
  #   respond_to do |format|
  #     format.html { redirect_to companies_url, notice: 'Document was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :file_name, :summary, :fullbio, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :title, :slug )
    end
end
