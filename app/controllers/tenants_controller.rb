class TenantsController < ApplicationController
    
rescue_from ActiveRecord::RecordNotFound, with: :tenant_not_found
rescue_from ActiveRecord::RecordInvalid, with: :tenant_invalid
    
    def index
        render json: Tenant.all, 
        except: [:created_at, :updated_at],
        status: 200
        
    end

    def show
        tenant = find_tenant
        render json: tenant, 
        except: [:created_at, :updated_at],
        status: 200
    end


    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end


    private
    def tenant_not_found
        render json: {errors: ["Tenant not found"]}, status: :tenant_not_found
    end

    def tenant_invalid invalid_tenant
        render json: {errors: invalid_tenant.record.errors.full_messages}, status: 422
    end

    def tenant_params
        params.require(:tenant).permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end
end
