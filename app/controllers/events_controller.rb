class EventsController < InheritedResources::Base

  private

    def event_params
      params.require(:event).permit(:name, :location, :description, :date, :link)
    end
end

