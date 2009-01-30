class Admin::AssetsController < Admin::BaseController
  def index
    @sorter = SortingHelper::Sorter.new self, %w(filename), params[:sort], params[:order], 'filename', 'ASC'
    @assets = Asset.find(:all)
  end
  
  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:notice] = 'Asset was successfully created.'
      redirect_to Site.full_url + '/admin/assets'    
    else
      render :action => :new
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    flash[:notice] = 'Asset was successfully destroyed.'
    redirect_to Site.full_url + '/admin/assets'
  end
end
