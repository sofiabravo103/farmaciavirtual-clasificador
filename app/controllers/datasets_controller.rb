class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    @dataset = Dataset.find(params[:id])
  end

  def new
    @dataset = Dataset.new
  end

  def create
    if params[:dataset].include? :csv
      @dataset = Dataset.create!

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
