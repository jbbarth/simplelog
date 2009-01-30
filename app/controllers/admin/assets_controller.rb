class Admin::AssetsController < Admin::BaseController
  def index
    @sorter = SortingHelper::Sorter.new self, %w(filename), params[:sort], params[:order], 'filename', 'ASC'
    @assets = Asset.find(:all)
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

  def upload
    post = Asset.save(params[:asset])
    render :text => "File has been uploaded successfully"
  end
end
