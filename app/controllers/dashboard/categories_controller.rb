module Dashboard
  class CategoriesController < Dashboard::ApplicationController
    before_action :set_category, only: %i[edit update destroy]

    layout 'dashboard/application'

    # GET /dashboard/categories
    def index
      @categories = Category.where(user_id: current_user.id).all
    end

    # GET /dashboard/categories/new
    def new
      @category = Category.new
    end

    # GET /dashboard/categories/1/edit
    def edit; end

    # POST /dashboard/categories
    def create
      @category = Category.new(category_params)
      @category.user_id = current_user.id

      if @category.save
        redirect_to dashboard_categories_url, success: 'Category was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /dashboard/categories/1
    def update
      if @category.update(category_params)
        redirect_to dashboard_categories_url, success: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /dashboard/categories/1
    def destroy
      if @category.destroy
        redirect_to dashboard_categories_url, success: 'Category was successfully destroyed.'
      else
        redirect_to dashboard_categories_url, danger: @category.errors.messages[:base].first
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :identifier, :description)
    end
  end
end
