include: "/order_items.view.lkml"

view: +order_items {
  ########## Filtered cross view measure ############
  measure: sum_margin_calvin_klein_option_2r {
    label: "€ Calvin Klein Margin Option 2 {Refined}"
    description: "The amount of margin made on Calvin Klein products."
    type: sum
    sql:
    CASE WHEN ${products.brand} = 'Calvin Klein'
            THEN ${order_items.sale_price} - ${inventory_items.cost}
      ELSE NULL
      END ;;
    value_format_name: eur
  }
}
