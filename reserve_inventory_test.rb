#reserve_inventory_test.rb
require 'csv'
require 'json'

module TestReserve
    class InventoryTest
      def initialize

      end

      def calc_victory_lap_totals

        tops_sizes = {"XS" => 0, "S" => 0, "M" => 0, "L" => 0, "XL" => 0}
        leggings_sizes = {"XS" => 0, "S" => 0, "M" => 0, "L" => 0, "XL" => 0}
        sports_bra_sizes = {"XS" => 0, "S" => 0, "M" => 0, "L" => 0, "XL" => 0}

        CSV.foreach('victory_lap_6_13_19.csv', :encoding => 'ISO-8859-1', :headers => true) do |row|
            puts row.inspect
            puts row['subscription_id']
            puts row['raw_line_item_properties']
            my_raw = eval(row['raw_line_item_properties'])
            my_raw.each do |myr|
              puts myr.inspect
              case myr[:name]
              when "leggings"
                local_value = myr[:value].upcase
                puts local_value.inspect
                
                  leggings_sizes[local_value] += 1
                

              when "tops"
                tops_sizes[myr[:value].upcase] += 1
              when "sports-bra"
                sports_bra_sizes[myr[:value].upcase] += 1
              else
                #do nothing
              end
              
            end

        end

        puts leggings_sizes.inspect
        puts tops_sizes.inspect
        puts sports_bra_sizes.inspect

        CSV.foreach('victory_lap_orders_6_13_19.csv', :encoding => 'ISO-8859-1', :headers => true) do |row|
          puts row.inspect
          my_line = row['line_items']
          puts my_line
          order_details = JSON.parse(row['line_items'])
          puts order_details.inspect
          #temp = "\'#{my_line}\'"
          #funky1 = Array.new
          #funky1 = eval(temp)
          #puts funky1.inspect
          mystuff = order_details.first
          mydetail = mystuff['properties']
          mydetail.each do |my|
            puts my.inspect
            case my['name']
            
            when "leggings"
              local_value = my['value']
              puts local_value.inspect
              leggings_sizes[local_value] += 1

            when "tops"
              tops_sizes[my['value']] += 1
            when "sports-bra"
              sports_bra_sizes[my['value']] += 1
            else
              #do nothing
            end

            
            end
          
          
        end

        puts "all done!"
        puts leggings_sizes.inspect
        puts tops_sizes.inspect
        puts sports_bra_sizes.inspect
      end


      def calc_victory_lap_order


      end

    end
end


