class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :apartment_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :apartment_invalid

    def index
        render json: Apartment.all, 
        status: 200
    end

    def show
        apartment = find_apt
        render json: apartment, 
        status: 200
    end


    def create 
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = find_apt
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = find_apt
        apartment.destroy
        head :no_content
    end


    private
    def apartment_not_found
        render json: {errors: ["Apartment not found"]}, status: :apartment_not_found
    end

    def apartment_invalid invalid_apartment
        render json: {errors: invalid_apartment.record.errors.full_messages}, status: 422
    end

    def apartment_params
        params.require(:apartment).permit(:number).exclude(:created_at, :updated_at)
    end

    def find_apt
        Apartment.find(params[:id])
    end
end
