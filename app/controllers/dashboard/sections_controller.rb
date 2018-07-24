module Dashboard
  class SectionsController < Dashboard::ApplicationController
    before_action :set_section, only: %i[edit update destroy]

    layout 'dashboard/application'

    # GET /dashboard/sections/new
    def new
      @section = Section.new(article_id: params[:article_id], content_type: params[:content_type])
    end

    # GET /dashboard/sections/1/edit
    def edit; end

    # POST /dashboard/sections
    def create
      @section = Section.new(section_params)
      article = Article.find(params[:article_id])
      @section.article = article
      @section.sequence = article.sections.size

      if @section.save
        redirect_to [:dashboard, @section.article], success: 'Section was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /dashboard/sections/1
    # rubocop:disable Metrics/AbcSize
    def update
      @section.assign_attributes(section_params)

      if params[:commit] && @section.save
        redirect_to dashboard_article_url(id: @section.article_id), success: 'Section was successfully updated.'
        return
      end

      if params[:preview]
        scraper = ::Opengraph::Scraper.new
        og_info = scraper.load(@section.url)
        @section.url = og_info[:url]
        @section.og_title = og_info[:title]
        @section.og_description = og_info[:description]
        @section.og_site_name = og_info[:site_name]
        @section.og_image = og_info[:image]
      end

      render :edit
    end
    # rubocop:enable Metrics/AbcSize

    # DELETE /dashboard/sections/1
    def destroy
      article_id = @section.article_id
      @section.destroy
      redirect_to dashboard_article_url(id: article_id), success: 'Section was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(
        :article_id,
        :content_type,
        :title,
        :description,
        :url,
        :image,
        :og_title,
        :og_description,
        :og_image,
        :og_site_name
      )
    end
  end
end
