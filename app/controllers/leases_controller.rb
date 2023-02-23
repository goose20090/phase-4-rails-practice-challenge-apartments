class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create
        lease = Lease.create!(params.permit(:rent, :apartment_id, :tenant_id))
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    
    private
    def render_not_found_response
        render json: {errors: "Lease not found"} , status: :not_found
    end

    def render_unprocessable_entity invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end