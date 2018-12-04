class ListController < ApplicationController
  before_action :set_list, only: %i(edit update destroy)

  def new
    @list=List.new
  end

  def create
    @list=List.new(list_params)
    if @list.save
      redirect_to :root
    else
      @list.valid?
      render action: :new
    end
  end

  def edit
    @list=List.find_by(id: params[:id])
  end

  def update
    @list=List.find_by(id: params[:id])
    if @list.update_attributes(list_params)
      redirect_to :root
    else
      @list.valid?
      render action: :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to :root
  end


  private
    def list_params
      params.require(:list).permit(:title).merge(user: current_user)
    end

    def set_list
      @list=List.find_by(id: params[:id])
    end
end
