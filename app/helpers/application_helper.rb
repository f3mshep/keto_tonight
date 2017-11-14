module ApplicationHelper

    def breakfast_category
        Category.find_by(name: "Breakfast")
    end

    def lunch_category
        Category.find_by(name: "Lunch")
    end

    def dinner_category
        Category.find_by(name: "Dinner")
    end 

    def bootstrap_modal(toggle_id)

     html = " <div class='modal fade' id='#{toggle_id}' tabindex='-1' role='dialog' aria-labelledby='comment' aria-hidden='true'>
            <div class='modal-dialog modal-lg' role='document'>
                <div class='modal-content'>
                    <div class='modal-body'>
                        <div class='container'>
                            #{yield}
                        </div>
                    </div>
                </div>
            </div>
        </div> "
        
        html.html_safe
    end

end
