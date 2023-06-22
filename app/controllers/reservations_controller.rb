class ReservationsController < ApplicationController

    def index
        @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 1).order(day: :desc)
    end

end
