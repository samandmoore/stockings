namespace :sectors do

  desc "Creates all the sectors"
  task refresh: [:environment] do
    all_sectors = XigniteClient.new.all_sectors
    all_sectors.each do |x_sector|
      Sector.find_or_create_by!(code: x_sector.code) do |sector|
        sector.name = x_sector.name
        sector.key = x_sector.name.parameterize.underscore
        x_sector.children.each do |x_industry_group|
          Sector.find_or_create_by!(code: x_industry_group.code) do |group|
            group.name = x_industry_group.name
            group.key = x_industry_group.name.parameterize.underscore
            x_industry_group.children.each do |x_industry|
              Sector.find_or_create_by!(code: x_industry.code) do |industry|
                industry.name = x_industry.name
                industry.key = x_industry.name.parameterize.underscore
              end
            end
          end
        end
      end
    end
  end

end
