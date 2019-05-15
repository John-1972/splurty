class QuotesController < ApplicationController
  def index
    @quote = Quote.order(Arel.sql("RANDOM()")).first
    # Rails 5.2 warns that "RANDOM()" is a 'non-attribute argument' & isn't allowed in Rails 6
    # So raw SQL that's known to be safe must be wrapped in "Arel.sql()"
  end

  def create
    @quote = Quote.create(quote_params)
    if @quote.invalid?
      flash[:error] = '<strong>Could not save.</strong> The data you entered is invalid.'
    end  
    redirect_to root_path
  end

  def about
  end

  private

  def quote_params
    params.require(:quote).permit(:saying, :author)
  end
end
