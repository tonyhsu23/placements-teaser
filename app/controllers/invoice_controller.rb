class InvoiceController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        render(
          json: File.read(
            Rails.root.join(
              'public', 'placements_teaser_data.json',
            )
          )
        )
      end
    end
  end
end
