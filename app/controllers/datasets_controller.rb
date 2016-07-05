class DatasetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @datasets = Dataset.all
  end

  def edit
    @dataset = Dataset.find(params[:id])
    unless current_user.has_role? :admin or current_user.email == @dataset.user.email
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
    @tweet = @dataset.get_unannotated_tweet
  end

  def update
    @dataset = Dataset.find(params[:id])
    @tweet = Tweet.find(params[:dataset][:tweet_id])
    @tweet.update!(annotation: params[:dataset][:annotation])
    redirect_to edit_dataset_path(@dataset.id)
  end

  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.destroy!
    redirect_to datasets_path
  end

  def show
    @dataset = Dataset.find(params[:id])
  end

  def new
    @dataset = Dataset.new
    @available_users = User.all
  end

  def create
    if params[:dataset].include? :csv and params[:dataset].include? :user
      @owner = User.find_by(email: params[:dataset][:user])
      @dataset = Dataset.create!(user: @owner)

      inserts = []
      params[:dataset][:csv].read.each_line do |line|
        text = line.split(',')[1].dup.force_encoding(Encoding::UTF_8)

        #replace quotes and parenthesis for db insertion
        text = text.tr("'", '').tr('"','').tr("`",'').tr("(",'').tr(")",'')

        inserts.push \
          "('#{@dataset.id}', '#{text}', '#{DateTime.now}', '#{DateTime.now}')"
      end

      sql = "INSERT INTO 'tweets' "+\
        "(`dataset_id`, `text`, `updated_at`, `created_at`) "+\
        "VALUES #{inserts.join(", ")}"
      ActiveRecord::Base.connection.execute(sql)

      redirect_to dataset_path(@dataset.id)
    else
    end
  end

end
