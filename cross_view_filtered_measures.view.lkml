include: "order_items.view"

view: cross_view_filtered_measures  {
  extends: [order_items]
  fields_hidden_by_default: yes

  # *** ADD THIS LINE ***
  sql_table_name: `thelook_ecommerce.order_items` ;;

  measure: sum_margin_calvin_klein_option_2_crossview {
    hidden: no
    label: "€ Calvin Klein Margin Option 2 {Cross View}"
    description: "The amount of margin made on Calvin Klein products."
    type: sum
    sql:
    CASE WHEN ${products.brand} = 'Calvin Klein'
            THEN ${sale_price} - ${inventory_items.cost}
      ELSE NULL
      END ;;
    value_format_name: eur
  }

}
