ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    #div class: "blank_slate_container", id: "dashboard_default_message" do
      #span class: "blank_slate" do
       # span I18n.t("active_admin.dashboard_welcome.welcome")
      #  small I18n.t("active_admin.dashboard_welcome.call_to_action")
     # end
    #end

    section "Last categories" do
      table_for Category.order("created_at desc").limit(5) do |category|
        category.column(:id)
        category.column(:name)
        category.column(:user_id)
      end
    end

    section "Last comments" do
      table_for Comment.order("created_at desc").limit(5) do |comment|
        comment.column(:id)
        comment.column(:body)
        comment.column(:image_id)
        comment.column(:user_id)
      end
    end

    section "Last images" do
      table_for Image.order("created_at desc").limit(10) do |image|
        image.column(:id)
        image.column(:path)
        image.column(:category_id)
        image.column "Image" do |img|
                image_tag(img.file.url, size: "32x20" )
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
