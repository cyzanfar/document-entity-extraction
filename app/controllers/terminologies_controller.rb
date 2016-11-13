class TerminologiesController < ApplicationController
  before_action :set_terminology, only: [:show, :edit, :update, :destroy]
  before_action :set_document, only: [:new, :create, :destroy, :update]

  def new
    @terminology = Terminology.new
  end

  def create
    @terminology = Terminology.new(terminology_params)

    respond_to do |format|
      if @terminology.save
        @document.terminologies.create(@terminology, :created => Time.now.to_i)

        format.html { redirect_to @document, notice: 'Terminology was successfully created.' }
        format.json { render action: 'show', status: :created, location: @terminology }
      else
        format.html { render action: 'new' }
        format.json { render json: @terminology.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @terminology.update(terminology_params)
        format.html { redirect_to @terminology, notice: 'Terminology was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @terminology.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # it will automatically destroy the relationship as well
    @terminology.destroy
    respond_to do |format|
      format.html { redirect_to @document }
      format.json { head :no_content }
    end
  end

  private

  def set_terminology
    @terminology = Terminology.find(params[:id])
  end

  def set_document
    @document = Document.find(params[:document_id])
  end

  def terminology_params
    params[:terminology]
  end
end
