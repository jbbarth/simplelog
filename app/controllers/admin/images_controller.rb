class Admin::ImagesController < Admin::BaseController
  def index
    @sorter = SortingHelper::Sorter.new self, %w(filename), params[:sort], params[:order], 'filename', 'ASC'
    @images = Image.find(:all)
  end
  
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = 'Image was successfully uploaded.'
      redirect_to Site.full_url + '/admin/images'    
    else
      render :action => :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = 'Image was successfully destroyed.'
    redirect_to Site.full_url + '/admin/images'
  end
end
