class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :lease_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :lease_invalid

    def index 
        render json: Lease.all,
        status: 200
    end

    def show 
        lease = find_lease
        render json: lease, 
        status: 200
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease 
        lease.destroy
        head :no_content
    end



    private

    def find_lease 
        Lease.find(params[:id])
    end

    def lease_not_found
        render json: {errors: ['Lease not found']}, status: 404
    end

    def lease_invalid invalid_lease
        render json: { errors: invalid_lease.record.errors.full_messages}, status: 422
    end

    def lease_params 
        params.require(:lease).permit(:rent, :apartment_id, :tenant_id)
    end
end

